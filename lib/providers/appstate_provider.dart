// ignore: unused_import
import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trinkgeld_app/models/appstate.dart';
import 'package:trinkgeld_app/models/country.dart';
import 'package:trinkgeld_app/models/language.dart';
import 'package:trinkgeld_app/models/override.dart';
import 'package:trinkgeld_app/models/quality.dart';

class AppstateProvider extends Notifier<Appstate> {
  @override
  Appstate build() {
    return Appstate(
        countries: [
          Country(
            id: '1',
            name: 'Deutschland',
            percentageLow: 0,
            percentageMid: 10,
            percentageHigh: 15,
            afterComma: 2,
            flag: ':flag-de:',
          ),
          Country(
            id: '2',
            name: 'USA',
            percentageLow: 25,
            percentageMid: 30,
            percentageHigh: 35,
            afterComma: 2,
            flag: ':flag-us:',
          ),
          Country(
            id: '3',
            name: 'Türkei',
            percentageLow: 10,
            percentageMid: 20,
            percentageHigh: 30,
            afterComma: 0,
            flag: ':flag-tr:',
          ),
          Country(
            id: '4',
            name: 'China',
            percentageLow: 5,
            percentageMid: 10,
            percentageHigh: 15,
            afterComma: 0,
            flag: ':flag-cn:',
          ),
          Country(
            id: '5',
            name: 'Frankreich',
            percentageLow: 8,
            percentageMid: 12,
            percentageHigh: 15,
            afterComma: 2,
            flag: ':flag-fr:',
          ),
          Country(
            id: '6',
            name: 'Italien',
            percentageLow: 8,
            percentageMid: 12,
            percentageHigh: 15,
            afterComma: 2,
            flag: ':flag-it:',
          ),
          Country(
            id: '7',
            name: 'Spanien',
            percentageLow: 8,
            percentageMid: 12,
            percentageHigh: 15,
            afterComma: 2,
            flag: ':flag-es:',
          ),
          Country(
            id: '8',
            name: 'Kroatien',
            percentageLow: 8,
            percentageMid: 12,
            percentageHigh: 15,
            afterComma: 2,
            flag: ':flag-hr:',
          ),
          Country(
            id: '9',
            name: 'Großbritannien',
            percentageLow: 8,
            percentageMid: 12,
            percentageHigh: 15,
            afterComma: 2,
            flag: ':flag-gb:',
          ),
          Country(
            id: '10',
            name: 'Österreich',
            percentageLow: 8,
            percentageMid: 12,
            percentageHigh: 15,
            afterComma: 2,
            flag: ':flag-at:',
          ),
        ],
        net: 0,
        gros: 0,
        quality: Quality.mid,
        selectedCountry: '1',
        darkMode: false,
        overrides: [],
        ownTippingAmount: 20,
        selectedLanguage: const German());
  }

  // ignore: body_might_complete_normally_nullable
  Country? getCountryById(String id) {
    for (final country in state.countries) {
      if (country.id == id) {
        return country;
      }
    }
  }

  void setQuality(Quality quality) {
    state = state.copyWith(quality: quality);
  }

  void changeOwnTippProfile({
    required Country country,
    required int min,
    required int mid,
    required int high,
  }) {
    //TODO: wir bekomen nicht mehr als ein land
    final newOverrides = [...state.overrides.where((x) => x.id != country.id)];
    if (min != country.percentageLow) {
      newOverrides.add(
          TippOverride(id: country.id, quality: Quality.low, percentage: min));
    }
    if (mid != country.percentageMid) {
      newOverrides.add(
          TippOverride(id: country.id, quality: Quality.mid, percentage: mid));
    }
    if (high != country.percentageHigh) {
      newOverrides.add(TippOverride(
          id: country.id, quality: Quality.high, percentage: high));
    }
    final newState = state.copyWith(
      overrides: newOverrides,
    );

    state = newState;
    log('done');
  }

  void changeLanguage(Language newLanguage) {
    log('newLanguage: $newLanguage');
    state = state.copyWith(selectedLanguage: newLanguage);
  }

  void changeCountry(Country newCountry) {
    log('newCountry: $newCountry');
    state = state.copyWith(selectedCountry: newCountry.id);
  }

  //   Die gegebene Codezeile definiert eine Funktion namens "setQuality", die einen Parameter vom Typ "Quality" erwartet. Diese Funktion aktualisiert den Wert der Eigenschaft "quality" des aktuellen Zustands (state) der Anwendung.

// Die Funktion verwendet die Methode "copyWith" des aktuellen Zustands (state), um eine Kopie des aktuellen Zustands zu erstellen und dabei den neuen Wert für die Eigenschaft "quality" zu setzen. Die Methode "copyWith" wird aufgerufen, indem der neue Wert für die Eigenschaft "quality" als Argument übergeben wird.

// Nachdem die Kopie des Zustands mit dem aktualisierten Wert erstellt wurde, wird der aktuelle Zustand (state) durch die neue Kopie ersetzt. Dadurch wird der Wert der Eigenschaft "quality" im aktuellen Zustand aktualisiert.

// Insgesamt ermöglicht diese Codezeile das Aktualisieren des Werts der Eigenschaft "quality" im aktuellen Zustand der Anwendung durch Zuweisen einer neuen Qualität.

  void switchDarkmode() {
    state = state.copyWith(darkMode: !state.darkMode);
  }
//   Die gegebene Codezeile definiert eine Funktion namens "switchDarkmode", die keinen Parameter erwartet. Diese Funktion wechselt den Wert der Eigenschaft "darkMode" im aktuellen Zustand (state) der Anwendung.

// Die Funktion verwendet die Methode "copyWith" des aktuellen Zustands (state), um eine Kopie des aktuellen Zustands zu erstellen und dabei den negierten Wert für die Eigenschaft "darkMode" zu setzen. Der negierte Wert wird durch den Ausdruck "!state.darkMode" erreicht, der den aktuellen Wert von "darkMode" umkehrt.

// Nachdem die Kopie des Zustands mit dem aktualisierten Wert erstellt wurde, wird der aktuelle Zustand (state) durch die neue Kopie ersetzt. Dadurch wird der Wert der Eigenschaft "darkMode" im aktuellen Zustand aktualisiert.

// Insgesamt ermöglicht diese Codezeile das Umschalten des Werts der Eigenschaft "darkMode" im aktuellen Zustand der Anwendung zwischen true und false.

  void setQualityByStars(int stars) {
    final quality = QualityExtension.fromStars(stars);
    setQuality(quality);
  }

  void setNet(int intValue) {
    final quality = state.quality;
    final selectedCountry = state.selectedCountryObject;
    //TODO: check if null here.
    if (selectedCountry == null) {
      resetNet();
      return;
    }
    final int percentage = state.getRealTipPercentage(selectedCountry, quality);
    log('percentage: $percentage');
    final tippDouble = intValue * percentage / 100;
    final tipp = tippDouble.toInt();
    state = state.copyWith(
      net: intValue,
      gros: intValue + tipp,
    );
    log('${state.gros}, ${state.net} state  values}');
  }

  void resetNet() {
    state = state.copyWith(
      net: 0,
      gros: 0,
    );
  }
}
