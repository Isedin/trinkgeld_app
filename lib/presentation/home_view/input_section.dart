import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_emoji/flutter_emoji.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trinkgeld_app/main.dart';
import 'package:trinkgeld_app/models/my_text_field.dart';
import 'package:trinkgeld_app/models/quality.dart';

class InputSection extends ConsumerWidget {
  const InputSection({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const borderMainSide = OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(30)),
      borderSide: BorderSide(
        width: 2.0,
        style: BorderStyle.solid,
      ),
    );
    var parser = EmojiParser();
    final appstate = ref.watch(refAppState);
    final translate = appstate.selectedLanguage;
    final appstateProvider = ref.read(
      refAppState.notifier,
    );
    return Expanded(
      child: SingleChildScrollView(
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
                decoration: const InputDecoration(
                  border: borderMainSide,
                  labelStyle: TextStyle(
                    color: Color.fromARGB(227, 217, 59, 59),
                  ),
                  suffixIcon: Icon(Icons.euro),
                  suffixIconColor: Colors.black,
                  focusedBorder: borderMainSide,
                  enabledBorder: borderMainSide,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: SizedBox(child: Text(appstate.net.toString())),
            ),
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
            // ignore: prefer_const_constructors
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    appstate.quality == Quality.low
                        ? parser.emojify(":disappointed:")
                        : appstate.quality == Quality.mid
                            ? parser.emojify(":neutral_face:")
                            : appstate.quality == Quality.high
                                ? parser.emojify(":sunglasses:")
                                : '???'
                                    '${parser.emojify(":unamused:")}',
                    style: const TextStyle(fontSize: 42),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: SizedBox(
                // height: 50,
                child: Text(
                  '${translate.tippAmount}: ${appstate.gros - appstate.net}',
                  style: const TextStyle(
                    fontSize: 25,
                  ),
                ),
              ),
            ),
            Text(
              translate.totalAmount,
              style: const TextStyle(
                fontSize: 25,
              ),
            ),
            Text(appstate.gros.toString()),
          ],
        ),
      ),
    );
  }
}
