import 'dart:convert';
import 'package:http/http.dart' as http;

abstract class ExchangeRatesRepo {
  Future<double> getRate({required String from, required String to});
}

class HttpExchangeRatesRepo implements ExchangeRatesRepo {
  HttpExchangeRatesRepo({this.timeout = const Duration(seconds: 6)});

  final Duration timeout;
  final _cache = <String, double>{};

  static const double _EUR_to_BAM = 1.95583;
  static const double _BAM_to_EUR = 1 / _EUR_to_BAM;

  static const double _USD_to_AED = 3.6725;
  static const double _AED_to_USD = 1 / _USD_to_AED;

  @override
  Future<double> getRate({required String from, required String to}) async {
    if (from == to) {
      print('[rates] same currency ($from == $to) -> 1.0');
      return 1.0;
    }

    final key = '$from->$to';
    final cached = _cache[key];
    if (cached != null) {
      print('[rates] cache $key = $cached');
      return cached;
    }

    final fixed = _fixedRateOrNull(from, to);
    if (fixed != null) {
      _cache[key] = fixed;
      return fixed;
    }

    if (from == 'BAM' && to != 'EUR') {
      final eurToTo = await _frankfurterEurTo(to);
      final bamToTo = eurToTo / _EUR_to_BAM;
      _cache[key] = bamToTo;
      print('[rates] BAM->$to via EUR: $eurToTo / $_EUR_to_BAM = $bamToTo');
      return bamToTo;
    }
    if (to == 'BAM' && from != 'EUR') {
      final eurToFrom = await _frankfurterEurTo(from);
      final fromToBam = _EUR_to_BAM / eurToFrom;
      _cache[key] = fromToBam;
      print(
          '[rates] $from->BAM via EUR: $_EUR_to_BAM / $eurToFrom = $fromToBam');
      return fromToBam;
    }

    if (from == 'EUR') {
      final r = await _frankfurterEurTo(to);
      _cache[key] = r;
      return r;
    }
    if (to == 'EUR') {
      final eurToFrom = await _frankfurterEurTo(from);
      final r = 1.0 / eurToFrom;
      _cache[key] = r;
      return r;
    }

    try {
      final r = await _frankfurterDirect(from: from, to: to);
      _cache[key] = r;
      return r;
    } catch (e) {
      print('[rates] frankfurter direct failed: $e');
    }

    try {
      final usdMap = await _erapiLatest(base: 'USD');
      final usdToFrom = usdMap[from];
      final usdToTo = usdMap[to];
      if (usdToFrom != null && usdToTo != null) {
        final r = usdToTo / usdToFrom;
        _cache[key] = r;
        print(
            '[rates] ER-API USD base: $from->$to = $usdToTo / $usdToFrom = $r');
        return r;
      }
    } catch (e) {
      print('[rates] er-api USD triangulation failed: $e');
    }

    try {
      final eurMap = await _erapiLatest(base: 'EUR');
      final eurToFrom = eurMap[from];
      final eurToTo = eurMap[to];
      if (eurToFrom != null && eurToTo != null) {
        final r = eurToTo / eurToFrom;
        _cache[key] = r;
        print(
            '[rates] ER-API EUR base: $from->$to = $eurToTo / $eurToFrom = $r');
        return r;
      }
    } catch (e) {
      print('[rates] er-api EUR triangulation failed: $e');
    }

    throw Exception('No usable rate for $from -> $to (all sources failed)');
  }

  // ----------------- Helpers -----------------

  double? _fixedRateOrNull(String from, String to) {
    if (from == 'EUR' && to == 'BAM') return _EUR_to_BAM;
    if (from == 'BAM' && to == 'EUR') return _BAM_to_EUR;

    if (from == 'USD' && to == 'AED') return _USD_to_AED;
    if (from == 'AED' && to == 'USD') return _AED_to_USD;

    return null;
  }

  // ---- Frankfurter (ECB) ----
  Future<double> _frankfurterEurTo(String code) async {
    final uri = Uri.parse(
        'https://api.frankfurter.app/latest?amount=1&from=EUR&to=$code');
    print('[rates] GET $uri (EUR->$code)');
    final res = await http.get(uri).timeout(timeout);
    if (res.statusCode != 200) {
      throw Exception('frankfurter EUR->$code: HTTP ${res.statusCode}');
    }
    final map = jsonDecode(res.body) as Map<String, dynamic>;
    final rate = (map['rates'] as Map<String, dynamic>?)?[code];
    if (rate is num) return rate.toDouble();
    throw Exception('frankfurter EUR->$code: missing rate');
  }

  Future<double> _frankfurterDirect(
      {required String from, required String to}) async {
    final uri = Uri.parse(
        'https://api.frankfurter.app/latest?amount=1&from=$from&to=$to');
    print('[rates] GET $uri (direct)');
    final res = await http.get(uri).timeout(timeout);
    if (res.statusCode != 200) {
      throw Exception('frankfurter $from->$to: HTTP ${res.statusCode}');
    }
    final map = jsonDecode(res.body) as Map<String, dynamic>;
    final rate = (map['rates'] as Map<String, dynamic>?)?[to];
    if (rate is num) return rate.toDouble();
    throw Exception('frankfurter $from->$to: missing rate');
  }

  // ---- ExchangeRate-API ----
  Future<Map<String, double>> _erapiLatest({required String base}) async {
    // Primarni endpoint (v6)
    var uri = Uri.parse('https://open.er-api.com/v6/latest/$base');
    print('[rates] GET $uri (ER-API $base base)');
    var res = await http.get(uri).timeout(timeout);

    if (res.statusCode != 200) {
      uri = Uri.parse('https://open.er-api.com/v7/latest/$base');
      print('[rates] GET $uri (ER-API v7 $base base)');
      res = await http.get(uri).timeout(timeout);
    }

    if (res.statusCode != 200) {
      throw Exception('er-api latest $base: HTTP ${res.statusCode}');
    }

    final map = jsonDecode(res.body) as Map<String, dynamic>;
    if (map['result'] != 'success' && map['result'] != 'Success') {
      throw Exception('er-api: result not success ($base) → ${map['result']}');
    }
    final rates = map['rates'] as Map<String, dynamic>?;
    if (rates == null) {
      throw Exception('er-api: missing rates ($base)');
    }
    return rates.map((k, v) => MapEntry(k, (v as num).toDouble()));
  }
}
