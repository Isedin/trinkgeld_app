import 'dart:convert';

import 'package:http/http.dart' as http;

abstract class ExchangeRatesRepo {
  Future<double> getRate({required String from, required String to});
}

class HttpExchangeRatesRepo implements ExchangeRatesRepo {
  final _cache = <String, double>{};
  final Duration timeout;

  HttpExchangeRatesRepo({this.timeout = const Duration(seconds: 5)});

  @override
  Future<double> getRate({required String from, required String to}) async {
    if (from == to) return 1.0;
    final key = '$from->$to';
    if (_cache.containsKey(key)) return _cache[key]!;

    final uri = Uri.parse(
        'https://api.exchangerate.host/latest?base=$from&symbols=$to');
    final res = await http.get(uri).timeout(timeout);
    if (res.statusCode != 200) {
      throw Exception('Rate fetch failed (${res.statusCode})');
    }
    final json = jsonDecode(res.body) as Map<String, dynamic>;
    final rates = (json['rates'] as Map)[to] as num;
    final rate = rates.toDouble();
    _cache[key] = rate;
    return rate;
  }
}
