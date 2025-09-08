import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trinkgeld_app/providers/_providers.dart';

class CurrencyToggle extends ConsumerWidget {
  const CurrencyToggle({required this.localCode, super.key});
  final String localCode;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mode = ref.watch(displayCurrencyModeProvider);
    return SegmentedButton<DisplayCurrency>(
      segments: [
        ButtonSegment(value: DisplayCurrency.local, label: Text(localCode)),
        const ButtonSegment(value: DisplayCurrency.usd, label: Text('USD')),
      ],
      selected: {mode},
      onSelectionChanged: (s) {
        ref.read(displayCurrencyModeProvider.notifier).state = s.first;
      },
    );
  }
}
