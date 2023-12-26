import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trinkgeld_app/models/quality.dart';
import 'package:trinkgeld_app/providers/_providers.dart';

import 'macard.dart';

/// Die Klasse DialogWidget repräsentiert ein StatefulWidget für die Anzeige von Dialogen.
class DialogWidget extends ConsumerStatefulWidget {
  /// WidgetRef ist eine Instanz, die verwendet wird, um auf den Zustand und die Services des Widgets zuzugreifen.
  final WidgetRef ref;

  /// Konstruktor für die Initialisierung von Instanzvariablen.
  const DialogWidget({required this.ref, super.key});

  @override
  ConsumerState<DialogWidget> createState() => _DialogWidgetState();
}

class _DialogWidgetState extends ConsumerState<DialogWidget> {
  bool isInitialized = false;
  double _sliderValueMin = 5;
  double _sliderValueMid = 10;
  double _sliderValueHigh = 20;

  @override
  Widget build(BuildContext context) {
    final emojiParser = ref.watch(refEmojiParser);
    final appstate = widget.ref.watch(refAppState);
    final appstateProvider = widget.ref.read(refAppState.notifier);
    final translate = appstate.selectedLanguage;
    if (!isInitialized) {
      setState(() {
        _sliderValueMin = appstate.overridePercentage(Quality.low)?.toDouble() ??
            appstate.selectedCountryObject.percentageLow.toDouble();
        _sliderValueMid = appstate.overridePercentage(Quality.mid)?.toDouble() ??
            appstate.selectedCountryObject.percentageMid.toDouble();
        _sliderValueHigh = appstate.overridePercentage(Quality.high)?.toDouble() ??
            appstate.selectedCountryObject.percentageHigh.toDouble();
        isInitialized = true;
      });
      log('${appstate.selectedCountryObject.name} ${appstate.selectedCountryObject.percentageLow}');
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
                          child: Row(
                            children: [
                              Text(
                                emojiParser.emojify(country.flag),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 3.0),
                                child: Text(
                                  country.iso,
                                  style: const TextStyle(
                                    fontSize: 14.0,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _sliderValueMin = value!.percentageLow.toDouble();
                  });
                  appstateProvider.changeCountry(value!);
                },
                decoration: InputDecoration(hintText: appstate.selectedCountryObject.name),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text(translate.ownQualityLevellow),
                  Slider(
                    activeColor: Colors.purple,
                    inactiveColor: Colors.green,
                    onChanged: (newvalue) {
                      setState(() {
                        _sliderValueMin = newvalue;
                      });
                      // lowPercentensios = newvalue;
                      log('$newvalue');
                    },
                    max: 25.0,
                    divisions: 5,
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
                    inactiveColor: Colors.green,
                    onChanged: (newvalue) {
                      setState(() {
                        _sliderValueMid = newvalue;
                      });
                      log('$newvalue');
                    },
                    max: 50.0,
                    divisions: 10,
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
                    inactiveColor: Colors.green,
                    onChanged: (newvalue) {
                      setState(() {
                        _sliderValueHigh = newvalue;
                      });
                      log('$newvalue');
                    },
                    max: 100.0,
                    divisions: 10,
                    value: _sliderValueHigh,
                    label: _sliderValueHigh.round().toString(),
                  ),
                ],
              ),
            ),
            const Padding(padding: EdgeInsets.all(30)),
            IconButton(
              color: Colors.green,
              iconSize: 35,
              hoverColor: Colors.lightGreen,
              onPressed: () {
                log('start write override');
                appstateProvider.changeOwnTippProfile(
                    country: appstate.selectedCountryObject,
                    high: _sliderValueHigh.round(),
                    mid: _sliderValueMid.round(),
                    min: _sliderValueMin.round());
                log('edit own tip object!');
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.play_arrow),
            ),
          ],
        ),
      ),
    );
  }
}
