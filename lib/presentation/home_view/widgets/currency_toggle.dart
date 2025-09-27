import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trinkgeld_app/providers/_providers.dart';

class CurrencyToggle extends ConsumerWidget {
  const CurrencyToggle({required this.localCode, super.key});
  final String localCode;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mode = ref.watch(displayCurrencyModeProvider);

    return ConstrainedBox(
      constraints: const BoxConstraints(minWidth: 120), // da ne bude preusko
      child: FittedBox( // ako baš nema prostora, skaliraj prema dolje
        fit: BoxFit.scaleDown,
        child: SegmentedButton<DisplayCurrency>(
          style: const ButtonStyle(
            padding: WidgetStatePropertyAll(EdgeInsets.symmetric(horizontal: 8)),
          ),
          segments: [
            ButtonSegment(
              value: DisplayCurrency.local,
              label: Text(localCode, softWrap: false, maxLines: 1),
            ),
            const ButtonSegment(
              value: DisplayCurrency.usd,
              label: Text('USD', softWrap: false, maxLines: 1),
            ),
          ],
          selected: {mode},
          onSelectionChanged: (s) {
            ref.read(displayCurrencyModeProvider.notifier).state = s.first;
          },
        ),
      ),
    );
  }
}

