import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:trinkgeld_app/models/appstate.dart';
import 'package:trinkgeld_app/providers/_providers.dart';

/// Dropdown for selecting currency display mode (local/USD)
class CurrencySuffix extends ConsumerWidget {
  const CurrencySuffix({
    required this.localCurrencyCode,
    super.key,
  });

  /// local currency code, e.g. "EUR", "HRK", ...
  final String localCurrencyCode;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mode = ref.watch(displayCurrencyModeProvider);
    final selected = mode == DisplayCurrency.usd ? 'USD' : localCurrencyCode;

    final from = ref.watch(refAppState).selectedCountryObject.currencyCode;

    const disableUsdFor = {'MVR', 'EGP'};
    final usdEnabled = !disableUsdFor.contains(from);

    return DropdownButtonHideUnderline(
      child: DropdownButton<String>(
        isDense: true,
        value: selected,
        items: <String>{localCurrencyCode, 'USD'}.map((code) {
          final isUsd = code == 'USD';
          final enabled = isUsd ? usdEnabled : true;
          return DropdownMenuItem(
            value: code,
            enabled: enabled,
            child: Text(
              isUsd && !enabled ? 'USD (n/a)' : code,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          );
        }).toList(),
        onChanged: (code) {
          if (code == null) return;
          if (code == 'USD' && !usdEnabled) return;
          ref.read(displayCurrencyModeProvider.notifier).state =
              code == 'USD' ? DisplayCurrency.usd : DisplayCurrency.local;
        },
      ),
    );
  }
}
