import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trinkgeld_app/models/quality.dart';
import 'package:trinkgeld_app/presentation/home_view/widgets/amounts_display.dart';
import 'package:trinkgeld_app/presentation/home_view/widgets/currency_suffix.dart';
import 'package:trinkgeld_app/presentation/home_view/widgets/my_text_field.dart';
import 'package:trinkgeld_app/providers/_providers.dart';

// import '../../models/appstate.dart';

// import '../../providers/_providers.dart';

/// Klasse für eine Eingabe-Sektion, erweitert von ConsumerWidget
class InputSection extends ConsumerWidget {
  /// Konstruktor für die InputSection-Klasse mit optionalem Schlüssel
  const InputSection({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mode = ref.watch(displayCurrencyModeProvider);
    const borderMainSide = OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(30)),
      borderSide: BorderSide(
        width: 2.0,
      ),
    );
    final parser = ref.watch(refEmojiParser);
    final appstate = ref.watch(refAppState);
    final translate = appstate.selectedLanguage;
    final appstateProvider = ref.read(
      refAppState.notifier,
    );

    final localCurrencyCode = appstate.selectedCountryObject.currencyCode;

    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 3,
              vertical: 15,
            ),
            child: MyTextfield(
              onChanged: (value) {
                final intValue = int.tryParse(value);
                if (intValue == null) {
                  appstateProvider.resetNet();
                  return;
                }
                appstateProvider.setNet(intValue);
                log('list of overrides: ${appstate.overrides.length}');
                log('net: ${appstate.net},  gros: ${appstate.gros}');
              },
              labelText: translate.amount,
              textInputType: TextInputType.number,
              decoration: InputDecoration(
                border: borderMainSide,
                labelStyle: const TextStyle(
                  color: Color.fromARGB(227, 217, 59, 59),
                ),
                suffixIcon:
                    CurrencySuffix(localCurrencyCode: localCurrencyCode),
                suffixIconColor: Colors.black,
                focusedBorder: borderMainSide,
                enabledBorder: borderMainSide,
                fillColor: const Color.fromARGB(255, 193, 209, 174),
                filled: true,
                labelText: translate.amount,
                hintStyle: TextStyle(color: Colors.grey[500]),
              ),
            ),
          ),

          // === RATING ===
          Text(
            translate.rating,
            style: const TextStyle(
              fontSize: 25,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 15,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RatingBar.builder(
                  minRating: 1,
                  maxRating: 3,
                  itemCount: 3,
                  initialRating: appstate.quality.stars.toDouble(),
                  itemSize: 50,
                  itemPadding: const EdgeInsets.symmetric(horizontal: 5),
                  itemBuilder: (context, _) => const Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  updateOnDrag: true,
                  onRatingUpdate: (rating) {
                    appstateProvider.setQualityByStars(rating.toInt());
                  },
                ),
              ],
            ),
          ),

          // === EMOJI ===
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  switch (appstate.quality) {
                    Quality.low => parser.emojify(':neutral_face:'),
                    Quality.mid => parser.emojify(':wink:'),
                    Quality.high => parser.emojify(':sunglasses:'),
                  },
                  style: const TextStyle(fontSize: 42),
                ),
              ],
            ),
          ),
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          //   child: SizedBox(
          //     // height: 50,
          //     child: Text(
          //       '${translate.tippAmount}: ${appstate.tippFormatted}',
          //       style: const TextStyle(fontSize: 25),
          //     ),
          //   ),
          // ),
          // Text(
          //   translate.totalAmount,
          //   style: const TextStyle(
          //     fontSize: 25,
          //   ),
          // ),
          // Text(
          //   appstate.grossFormatted,
          //   style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          // ),
          AmountsDisplay(
            key: ValueKey(mode),
          ),
        ],
      ),
    );
  }
}
