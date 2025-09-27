import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trinkgeld_app/data/countries.dart';

import '../models/appstate.dart';
import '../models/country.dart';
import '../models/language.dart';
import '../models/override.dart' show TippOverride;
import '../models/quality.dart';

/// Klasse für die Verwaltung des App-Zustands
class AppstateProvider extends Notifier<Appstate> {
  @override
  Appstate build() => _example;

  /// Diese Methode sucht nach einem Land anhand seiner ID in der Liste von Ländern im Zustand (state).
  Country? getCountryById(String id) {
    /// Iteriere durch die Liste von Ländern im Zustand.
    for (final country in state.countries) {
      /// Überprüfe, ob die ID des aktuellen Landes mit der gesuchten ID übereinstimmt.
      if (country.id == id) {
        /// Falls die ID übereinstimmt, gibt das Land zurück.
        return country;
      }
    }

    /// Wenn keine Übereinstimmung gefunden wurde, wird null zurückgegeben.
    return null;
  }

  /// Methode zum Festlegen der Qualität im App-Zustand
  void setQuality(Quality quality) {
    state = state.copyWith(quality: quality);
  }

  /// Methode zum Ändern des eigenen Trinkgeldprofils für ein bestimmtes Land
  void changeOwnTippProfile({
    required Country country,
    required int min,
    required int mid,
    required int high,
  }) {
    final newOverrides = [...state.overrides.where((x) => x.id != country.id)];
    if (min != country.percentageLow) {
      newOverrides.add(
        TippOverride(id: country.id, quality: Quality.low, percentage: min),
      );
    }
    if (mid != country.percentageMid) {
      newOverrides.add(
        TippOverride(id: country.id, quality: Quality.mid, percentage: mid),
      );
    }
    if (high != country.percentageHigh) {
      newOverrides.add(
        TippOverride(id: country.id, quality: Quality.high, percentage: high),
      );
    }
    final newState = state.copyWith(overrides: newOverrides);

    state = newState;
    log('done');
  }

  /// Methode zum Ändern der Anwendungssprache im App-Zustand
  void changeLanguage(Language newLanguage) {
    log('newLanguage: $newLanguage');
    state = state.copyWith(selectedLanguage: newLanguage);
  }

  /// Methode zum Ändern des ausgewählten Landes im App-Zustand
  void changeCountry(Country newCountry) {
    log('newCountry: $newCountry');
    state = state.copyWith(selectedCountry: newCountry.id);
  }

  /// Methode zum Umschalten des Dunkelmodus im App-Zustand
  void switchDarkmode() {
    state = state.copyWith(darkMode: !state.darkMode);
  }

  /// Methode zum Festlegen der Qualität basierend auf der Anzahl der Sterne
  void setQualityByStars(int stars) {
    final quality = QualityExtension.fromStars(stars);
    setQuality(quality);
  }

  /// Methode zum Festlegen des Nettobetrags im App-Zustand
  void setNet(int intValue) {
    state = state.copyWith(net: intValue);
  }

  /// Methode zum Zurücksetzen des Nettobetrags im App-Zustand
  void resetNet() {
    state = state.copyWith(net: 0);
  }

  void setDisplayCurrencyMode(DisplayCurrency mode) {
    state = state.copyWith(displayCurrencyMode: mode);
  }

  static const _example = Appstate(
    countries: countriesData,
    net: 0,
    quality: Quality.mid,
    selectedCountry: 'DE',
    darkMode: false,
    overrides: [TippOverride(id: '1', quality: Quality.high, percentage: 20)],
    ownTippingAmount: 20,
    selectedLanguage: German(),
    displayCurrencyMode: DisplayCurrency.local,
  );
}
