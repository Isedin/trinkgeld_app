import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trinkgeld_app/models/appstate.dart';
import 'package:trinkgeld_app/models/country.dart';
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
        ),
        Country(
          id: '2',
          name: 'USA',
          percentageLow: 25,
          percentageMid: 30,
          percentageHigh: 35,
          afterComma: 2,
        ),
        Country(
          id: '3',
          name: 'Türkei',
          percentageLow: 10,
          percentageMid: 20,
          percentageHigh: 30,
          afterComma: 0,
        ),
        Country(
          id: '4',
          name: 'China',
          percentageLow: 5,
          percentageMid: 10,
          percentageHigh: 15,
          afterComma: 0,
        ),
        Country(
          id: '5',
          name: 'Frankreich',
          percentageLow: 8,
          percentageMid: 12,
          percentageHigh: 15,
          afterComma: 2,
        ),
      ],
      net: 10000,
      gros: 11000,
      quality: Quality.mid,
      selectedCountry: '4',
      darkMode: false,
    );
  }

  // ignore: body_might_complete_normally_nullable
  Country? getCountryById(String id) {
    for (final c in state.countries) {
      if (c.id == id) {
        return c;
      }
    }
  }

  void setQuality(Quality quality) {
    state = state.copyWith(quality: quality);
  } //   Die gegebene Codezeile definiert eine Funktion namens "setQuality", die einen Parameter vom Typ "Quality" erwartet. Diese Funktion aktualisiert den Wert der Eigenschaft "quality" des aktuellen Zustands (state) der Anwendung.

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
    if (selectedCountry == null) {
      resetNet();
      return;
    }
    final int percentage;
    if (quality == Quality.low) {
      percentage = selectedCountry.percentageLow;
    } else if (quality == Quality.mid) {
      percentage = selectedCountry.percentageMid;
    } else {
      percentage = selectedCountry.percentageHigh;
    }
    final tippDouble = intValue * percentage / 100;
    final tipp = tippDouble.toInt();
    state = state.copyWith(
      net: intValue,
      gros: intValue + tipp,
    );
  }

  void resetNet() {
    state = state.copyWith(
      net: 0,
      gros: 0,
    );
  }
}
