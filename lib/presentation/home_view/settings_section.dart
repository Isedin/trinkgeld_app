// ignore_for_file: unused_local_variable

import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_emoji/flutter_emoji.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trinkgeld_app/main.dart';
import 'package:trinkgeld_app/models/language.dart';
import 'package:trinkgeld_app/presentation/home_view/widgets/dialog_widget.dart';

class SettingsSection extends ConsumerWidget {
  const SettingsSection({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const settingsButtonsBorder = OutlineInputBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(
          30,
        ),
      ),
    );
    final emojiLibrary = EmojiParser();
    final appstate = ref.watch(refAppState);
    final translate = appstate.selectedLanguage;
    final appstateProvider = ref.read(
      refAppState.notifier,
    );
    //appstate.countries
    //     .firstWhere((element) => element.id == appstate.selectedCountry);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: DropdownButtonFormField(
            decoration: InputDecoration(
              border: settingsButtonsBorder,
              label: Text(appstate.selectedLanguage.ownName),
            ),
            //     child: DropdownButtonHideUnderline(
            //       child: DropdownButton(
            //         value: appstate.selectedLanguage,
            //         // items: [],
            //         items: globalLanguageLibrary
            //             .map(
            //               (e) => DropdownMenuItem(
            //                 value: e,
            //                 child: Text(e.ownName),
            //               ),
            //             )
            //             .toList(),
            //         onChanged: (value) {
            //           log('onChanged Language $value');
            //           if (value != null) {
            //             // appstateProvider.changeLanguage(value);
            //           }
            //         },
            //       ),
            //     ),
            // ),
            //   ),
            //   );
            // },
            items: [German(), English()]
                .map(
                  (e) => DropdownMenuItem(
                    value: e,
                    child: Text(e.ownName),
                  ),
                )
                .toList(),
            onChanged: (value) {
              log('onChanged Language $value');
              if (value != null) {
                appstateProvider.changeLanguage(value);
              }
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: TextFormField(
            decoration: InputDecoration(
              border: settingsButtonsBorder,
              labelText: translate.bugReport,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: TextFormField(
            decoration: const InputDecoration(
              border: settingsButtonsBorder,
              labelText: 'FAQ',
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child:
              // TextFormField(
              //   decoration: InputDecoration(
              //     border: settingsButtonsBorder,
              //     labelText: translate.ownTipping,
              //     // hintText: 5% 10% 15%,
              //   ),
              // ),
              TextButton(
            child: Text(translate.ownTippSettingButton),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => DialogWidget(
                  ref: ref,
                ),
                // Padding(
                //   padding: const EdgeInsets.only(
                //     top: 100,
                //     bottom: 100,
                //     left: 20,
                //     right: 20,
                //   ),
                //   child: MACard(
                //     color: Colors.blueGrey,
                //     child: Column(
                //       children: [
                //         Padding(
                //           padding: const EdgeInsets.all(8.0),
                //           child: DropdownButtonFormField(
                //             items: appstate.countries
                //                 .map((country) => DropdownMenuItem(
                //                       value: country,
                //                       child: Text(
                //                         emojiLibrary.emojify(country.flag),
                //                       ),
                //                     ))
                //                 .toList(),
                //             onChanged: (value) {
                //               Country? ausgewaehltesLand;
                //               ausgewaehltesLand = value;
                //               log(ausgewaehltesLand.toString());
                //             },
                //             decoration: const InputDecoration(
                //                 hintText: 'ausgewähltes Land'),
                //           ),
                //         ),
                //         Padding(
                //           padding: const EdgeInsets.all(8.0),
                //           child: Column(
                //             children: [
                //               const Text('qualitylow'),
                //               Slider(
                //                 activeColor: Colors.purple,
                //                 inactiveColor: Colors.pinkAccent.shade200,
                //                 onChanged: (newvalue) {
                //                   setState(() {
                //                     _currentSliderValue = newvalue;
                //                   });
                //                   lowPercentensios = newvalue;
                //                   log('$newvalue');
                //                 },
                //                 min: 0.0,
                //                 max: 15.0,
                //                 value: _currentSliderValue,
                //                 label: _currentSliderValue.round().toString(),
                //                 // ausgewaehltesLand?.percentageLow
                //                 //         .toDouble() ??
                //                 //     0.0,
                //               ),
                //             ],
                //           ),
                //         ),
                //         const Padding(padding: EdgeInsets.all(30)),
                //         IconButton(
                //             onPressed: () {
                //               lowPercentensios; //min %
                //               // appstateProvider.changeOwnTippProfile();
                //               log('edit own tip object!');
                //               Navigator.pop(context);
                //             },
                //             icon: const Icon(Icons.accessibility_sharp))
                //       ],
                //     ),
                //   ),
                // ),
              );
              log('message');
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 3,
          ),
          child: Container(
            // decoration: BoxDecoration(border: Border.all()),
            alignment: Alignment.center,
            height: 30,
            width: 70,
            child: IconButton(
              icon: const Icon(
                Icons.brightness_6,
                size: 50,
              ),
              onPressed: () {
                appstateProvider.switchDarkmode();
              },
            ),
          ),
        ),
      ],
    );
  }
}
