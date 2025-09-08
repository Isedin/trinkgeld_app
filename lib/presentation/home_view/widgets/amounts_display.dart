import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:trinkgeld_app/providers/_providers.dart';
import 'package:trinkgeld_app/utils/safe_locale.dart';

/// Widget to display calculated tip and total amounts
class AmountsDisplay extends ConsumerWidget {
  /// Constructor for AmountsDisplay widget
  const AmountsDisplay({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appstate = ref.watch(refAppState);
    final translate = appstate.selectedLanguage;

    final localCode = appstate.selectedCountryObject.currencyCode;
    final localLocale = appstate.selectedCountryObject.locale;

    final mode = ref.watch(displayCurrencyModeProvider);
    final targetCode = mode == DisplayCurrency.usd ? 'USD' : localCode;
    final targetLocale =
        safeLocale(targetCode == 'USD' ? 'en_US' : localLocale);
    final localSafe = safeLocale(localLocale);

    final fmtTarget =
        NumberFormat.simpleCurrency(name: targetCode, locale: targetLocale);
    final fmtLocal =
        NumberFormat.simpleCurrency(name: localCode, locale: localSafe);

// debug:
    print('[ui] targetCode=$targetCode, local=$localCode');

    // take converted amounts from provider
    final amounts = ref.watch(selectedDisplayAmountsProvider);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: amounts.when(
        data: (a) => Column(
          children: [
            Text(
              '${translate.tippAmount}: ${fmtTarget.format(a.tipp)}',
              style: const TextStyle(fontSize: 25),
            ),
            const SizedBox(height: 8),
            Text(
              translate.totalAmount,
              style: const TextStyle(fontSize: 25),
            ),
            Text(
              fmtTarget.format(a.gross),
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 6),
            Text(
              '↳ ${a.from} → ${a.to} @ ${a.rate.toStringAsFixed(6)}',
              style: const TextStyle(
                  fontSize: 12,
                  fontStyle: FontStyle.italic,
                  color: Colors.grey),
            ),
            if (targetCode != localCode) ...[
              const SizedBox(height: 6),
              Text(
                '≈ ${fmtLocal.format(appstate.grossRounded)} local',
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ],
          ],
        ),
        loading: () => const Padding(
          padding: EdgeInsets.all(8.0),
          child: CircularProgressIndicator.adaptive(strokeWidth: 2),
        ),
        // Fallback: local format in case of an error
        error: (err, stack) {
          // ignore: avoid_print
          print('[AmountsDisplay][error] $err\n$stack');
          return Column(
            children: [
              Text(
                '${translate.tippAmount}: ${appstate.tippFormatted}',
                style: const TextStyle(fontSize: 25),
              ),
              const SizedBox(height: 8),
              Text(
                translate.totalAmount,
                style: const TextStyle(fontSize: 25),
              ),
              Text(
                appstate.grossFormatted,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 6),
              const Text(
                'Fallback (local currency) caused by an error',
                style: TextStyle(fontSize: 12, color: Colors.redAccent),
              ),
            ],
          );
        },
      ),
    );
  }
}
