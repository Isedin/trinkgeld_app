import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trinkgeld_app/models/quality.dart';
import 'package:trinkgeld_app/presentation/home_view/widgets/amounts_display.dart';
import 'package:trinkgeld_app/presentation/home_view/widgets/currency_toggle.dart';
import 'package:trinkgeld_app/presentation/home_view/widgets/my_text_field.dart';
import 'package:trinkgeld_app/presentation/shared/header_card.dart';
import 'package:trinkgeld_app/providers/_providers.dart';

/// Klasse für eine Eingabe-Sektion, erweitert von ConsumerWidget
class InputSection extends ConsumerWidget {
  /// Konstruktor für die InputSection-Klasse mit optionalem Schlüssel
  const InputSection({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appstate = ref.watch(refAppState);
    final translate = appstate.selectedLanguage;
    final appstateProvider = ref.read(
      refAppState.notifier,
    );

    final localCurrencyCode = appstate.selectedCountryObject.currencyCode;

    // we take the localized name
    final countryName = appstate.selectedCountryObject
        .localizedName(translate.languageCode); // ← uses extension

    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: HeaderCard(
            title: translate.title,
            subtitle: countryName,
            trailing: CurrencyToggle(localCode: localCurrencyCode),
          ),
        ),

        // Amount input
        SliverToBoxAdapter(
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(translate.amount,
                      style: Theme.of(context).textTheme.titleMedium),
                  const SizedBox(height: 8),
                  MyTextfield(
                    labelText: translate.amount,
                    decoration: const InputDecoration(hintText: '0'),
                    textInputType: TextInputType.number,
                    onChanged: (value) {
                      final intValue = int.tryParse(value);
                      if (intValue == null) {
                        appstateProvider.resetNet();
                        return;
                      }
                      appstateProvider.setNet(intValue);
                      log('net=${appstate.net} gros=${appstate.gros}');
                    },
                  ),
                ],
              ),
            ),
          ),
        ),

        // Service rating
        SliverToBoxAdapter(
          child: Card(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
              child: Column(
                children: [
                  Text(translate.rating,
                      style: Theme.of(context).textTheme.titleMedium),
                  const SizedBox(height: 8),
                  RatingBar.builder(
                    minRating: 1,
                    maxRating: 3,
                    itemCount: 3,
                    initialRating: appstate.quality.stars.toDouble(),
                    itemPadding: const EdgeInsets.symmetric(horizontal: 6),
                    itemBuilder: (context, _) => const Icon(Icons.star),
                    updateOnDrag: true,
                    onRatingUpdate: (rating) =>
                        appstateProvider.setQualityByStars(rating.toInt()),
                  ),
                ],
              ),
            ),
          ),
        ),

        // Results (tip + total) — with subtle animation
        SliverToBoxAdapter(
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 220),
                transitionBuilder: (c, a) =>
                    FadeTransition(opacity: a, child: c),
                child: const AmountsDisplay(key: ValueKey('amounts')),
              ),
            ),
          ),
        ),
        const SliverPadding(padding: EdgeInsets.only(bottom: 24)),
      ],
    );
  }
}
