import 'package:flutter_emoji/flutter_emoji.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trinkgeld_app/models/appstate.dart'
    show Appstate, DisplayCurrency;
import 'package:trinkgeld_app/providers/appstate_provider.dart';
import 'package:trinkgeld_app/services/http_exchange_rates_repo.dart';
export 'package:trinkgeld_app/models/appstate.dart' show DisplayCurrency;

// import '../models/appstate.dart';
// import 'appstate_provider.dart';

/// Definition eines NotifierProviders für den App-Zustand
final refAppState = NotifierProvider<AppstateProvider, Appstate>(
  () => AppstateProvider(),
);

/// Definition einer Instanz des Providers für den EmojiParser
final refEmojiParser = Provider<EmojiParser>((ref) => EmojiParser());

/// Definition eines Providers für den ExchangeRatesRepo
final exchangeRepoProvider =
    Provider<ExchangeRatesRepo>((ref) => HttpExchangeRatesRepo());

class _Amounts {
  const _Amounts({
    required this.tipp,
    required this.gross,
    required this.rate,
    required this.from,
    required this.to,
  });
  final double tipp;
  final double gross;
  final double rate;
  final String from;
  final String to;
}

/// Definition eines StateProviders für den Anzeigemodus der Währung (lokal/USD)
final displayCurrencyModeProvider =
    StateProvider<DisplayCurrency>((ref) => DisplayCurrency.local);

final selectedDisplayAmountsProvider = FutureProvider<_Amounts>((ref) async {
  final s = ref.watch(refAppState);
  final mode = ref.watch(displayCurrencyModeProvider);

  final from = s.selectedCountryObject.currencyCode;
  final to = (mode == DisplayCurrency.usd) ? 'USD' : from;

  // ignore: avoid_print
  print('[selected] from=$from to=$to');

  if (from == to) {
    return _Amounts(
      tipp: s.tippRounded.toDouble(),
      gross: s.grossRounded.toDouble(),
      rate: 1.0,
      from: from,
      to: to,
    );
  }

  final repo = ref.read(exchangeRepoProvider);
  final rate = await repo.getRate(from: from, to: to);

  final tipp = s.tippRounded * rate;
  final gross = s.grossRounded * rate;

  // ignore: avoid_print
  print('[selected] rate=$rate -> tipp=$tipp gross=$gross');

  return _Amounts(
    tipp: tipp,
    gross: gross,
    rate: rate,
    from: from,
    to: to,
  );
});
