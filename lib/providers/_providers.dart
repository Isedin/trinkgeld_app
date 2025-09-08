import 'package:flutter_emoji/flutter_emoji.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trinkgeld_app/models/appstate.dart';
import 'package:trinkgeld_app/providers/appstate_provider.dart';
import 'package:trinkgeld_app/services/http_exchange_rates_repo.dart';

import '../models/appstate.dart';
import 'appstate_provider.dart';

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
  const _Amounts(this.tipp, this.gross);
  final double tipp;
  final double gross;
}

/// Definition eines FutureProviders, der umgerechnete Beträge basierend auf der Zielwährung bereitstellt
final convertedAmountsProvider =
    FutureProvider.family<_Amounts, String>((ref, targetCurrency) async {
  final s = ref.watch(refAppState);
  final repo = ref.read(exchangeRepoProvider);
  final from = s.selectedCountryObject.currencyCode;
  final rate = await repo.getRate(from: from, to: targetCurrency);
  final needConvert = from != targetCurrency;
  final tipp = needConvert ? s.tippRounded * rate : s.tippRounded;
  final gross = needConvert ? s.grossRounded * rate : s.grossRounded;
  return _Amounts(tipp, gross);
});
