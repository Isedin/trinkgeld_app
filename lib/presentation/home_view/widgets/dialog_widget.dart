import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_emoji/flutter_emoji.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trinkgeld_app/main.dart';
import 'package:trinkgeld_app/models/country.dart';

import 'macard.dart';

class DialogWidget extends StatefulWidget {
  final WidgetRef ref;
  const DialogWidget({super.key, required this.ref});

  @override
  State<DialogWidget> createState() => _DialogWidgetState();
}

class _DialogWidgetState extends State<DialogWidget> {
  bool isInitialized = false;
  double _sliderValueMin = 5;
  double _sliderValueMid = 10;
  double _sliderValueHigh = 20;
  // double? lowPercentensios;
  // double? midPercentensios;
  // double? highPercentensios;
  final emojiLibrary = EmojiParser();
  @override
  Widget build(BuildContext context) {
    final appstate = widget.ref.watch(refAppState);
    final appstateProvider = widget.ref.read(refAppState.notifier);
    final translate = appstate.selectedLanguage;
    if (!isInitialized) {
      setState(() {
        _sliderValueMin =
            appstate.selectedCountryObject!.percentageLow.toDouble();
        _sliderValueMid =
            appstate.selectedCountryObject!.percentageMid.toDouble();
        _sliderValueHigh =
            appstate.selectedCountryObject!.percentageHigh.toDouble();
        isInitialized = true;
      });
      log('${appstate.selectedCountryObject!.name} ${appstate.selectedCountryObject!.percentageLow}');
    }
    return Padding(
      padding: const EdgeInsets.only(
        top: 100,
        bottom: 100,
        left: 20,
        right: 20,
      ),
      child: MACard(
        color: Colors.blueGrey,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: DropdownButtonFormField(
                value: appstate.selectedCountryObject,
                items: appstate.countries
                    .map((country) => DropdownMenuItem(
                          value: country,
                          child: Text(
                            emojiLibrary.emojify(country.flag),
                          ),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _sliderValueMin = value!.percentageLow.toDouble();
                  });
                  appstateProvider.changeCountry(value!);
                },
                decoration: InputDecoration(
                    hintText: appstate.selectedCountryObject?.name ??
                        'wähle ein Land'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text(translate.ownQualityLevellow),
                  Slider(
                    activeColor: Colors.purple,
                    inactiveColor: Colors.pinkAccent.shade200,
                    onChanged: (newvalue) {
                      setState(() {
                        _sliderValueMin = newvalue;
                      });
                      // lowPercentensios = newvalue;
                      log('$newvalue');
                      // log('new lowPercentensios$lowPercentensios');
                    },
                    min: 0.0,
                    max: 100.0,
                    divisions: 20,
                    value: _sliderValueMin,
                    label: _sliderValueMin.round().toString(),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text(translate.ownQualityLevelmid),
                  Slider(
                    activeColor: Colors.purple,
                    inactiveColor: Colors.pinkAccent.shade200,
                    onChanged: (newvalue) {
                      setState(() {
                        _sliderValueMid = newvalue;
                      });
                      // midPercentensios = newvalue;
                      log('$newvalue');
                    },
                    min: 0.0,
                    max: 100.0,
                    divisions: 20,
                    value: _sliderValueMid,
                    label: _sliderValueMid.round().toString(),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text(translate.ownQualityLevelHigh),
                  Slider(
                    activeColor: Colors.purple,
                    inactiveColor: Colors.pinkAccent.shade200,
                    onChanged: (newvalue) {
                      setState(() {
                        _sliderValueHigh = newvalue;
                      });
                      // highPercentensios = newvalue;
                      log('$newvalue');
                    },
                    min: 0.0,
                    max: 100.0,
                    divisions: 20,
                    value: _sliderValueHigh,
                    label: _sliderValueHigh.round().toString(),
                  ),
                ],
              ),
            ),
            const Padding(padding: EdgeInsets.all(30)),
            IconButton(
                onPressed: () {
                  // lowPercentensios; //min %
                  if (appstate.selectedCountryObject != null) {
                    log('start write override');
                    appstateProvider.changeOwnTippProfile(
                        country: appstate.selectedCountryObject!,
                        high: _sliderValueHigh.round(),
                        mid: _sliderValueMid.round(),
                        min: _sliderValueMin.round());
                  }
                  log('edit own tip object!');
                  Navigator.of(context).pop();
                },
                icon: const Icon(Icons.accessibility_sharp))
          ],
        ),
      ),
    );
  }
}
