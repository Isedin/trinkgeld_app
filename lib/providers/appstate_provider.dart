import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';

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

  static const _example = Appstate(
    countries: [
      Country(
        id: '1',
        name: 'Deutschland',
        iso: 'DE',
        percentageLow: 0,
        percentageMid: 10,
        percentageHigh: 15,
        afterComma: 2,
        flag: ':flag-de:',
      ),
      Country(
        id: '2',
        name: 'USA',
        iso: 'USA',
        percentageLow: 25,
        percentageMid: 30,
        percentageHigh: 35,
        afterComma: 2,
        flag: ':flag-us:',
      ),
      Country(
        id: '3',
        name: 'Türkei',
        iso: 'TR',
        percentageLow: 10,
        percentageMid: 20,
        percentageHigh: 30,
        afterComma: 0,
        flag: ':flag-tr:',
      ),
      Country(
        id: '4',
        name: 'China',
        iso: 'CHN',
        percentageLow: 5,
        percentageMid: 10,
        percentageHigh: 15,
        afterComma: 0,
        flag: ':flag-cn:',
      ),
      Country(
        id: '5',
        name: 'Frankreich',
        iso: 'FR',
        percentageLow: 8,
        percentageMid: 12,
        percentageHigh: 15,
        afterComma: 2,
        flag: ':flag-fr:',
      ),
      Country(
        id: '6',
        name: 'Italien',
        iso: 'IT',
        percentageLow: 8,
        percentageMid: 12,
        percentageHigh: 15,
        afterComma: 2,
        flag: ':flag-it:',
      ),
      Country(
        id: '7',
        name: 'Spanien',
        iso: 'ESP',
        percentageLow: 8,
        percentageMid: 12,
        percentageHigh: 15,
        afterComma: 2,
        flag: ':flag-es:',
      ),
      Country(
        id: '8',
        name: 'Kroatien',
        iso: 'CRO',
        percentageLow: 8,
        percentageMid: 12,
        percentageHigh: 15,
        afterComma: 2,
        flag: ':flag-hr:',
      ),
      Country(
        id: '9',
        name: 'Großbritannien',
        iso: 'GBR',
        percentageLow: 8,
        percentageMid: 12,
        percentageHigh: 15,
        afterComma: 2,
        flag: ':flag-gb:',
      ),
      Country(
        id: '10',
        name: 'Österreich',
        iso: 'AUT',
        percentageLow: 8,
        percentageMid: 12,
        percentageHigh: 15,
        afterComma: 2,
        flag: ':flag-at:',
      ),
      Country(
        id: '11',
        name: 'Bosnien und Herzegowina',
        iso: 'BIH',
        percentageLow: 10,
        percentageMid: 15,
        percentageHigh: 20,
        afterComma: 2,
        flag: ':flag-ba:',
      ),
      Country(
        id: '12',
        name: 'Kanada',
        iso: 'CAN',
        percentageLow: 15,
        percentageMid: 25,
        percentageHigh: 35,
        afterComma: 2,
        flag: ':flag-ca:',
      ),
      Country(
        id: '13',
        name: 'Schweiz',
        iso: 'CH',
        percentageLow: 15,
        percentageMid: 25,
        percentageHigh: 35,
        afterComma: 2,
        flag: ':flag-ch:',
      ),
      Country(
        id: '14',
        name: 'Australien',
        iso: 'AUS',
        percentageLow: 10,
        percentageMid: 15,
        percentageHigh: 20,
        afterComma: 2,
        flag: ':flag-au:',
      ),
      Country(
        id: '15',
        name: 'Griechenland',
        iso: 'GR',
        percentageLow: 15,
        percentageMid: 25,
        percentageHigh: 35,
        afterComma: 2,
        flag: ':flag-gr:',
      ),
      Country(
        id: '16',
        name: 'Vereinigte Arabische Emirate',
        iso: 'AE',
        percentageLow: 25,
        percentageMid: 35,
        percentageHigh: 50,
        afterComma: 2,
        flag: ':flag-ae:',
      ),
      Country(
        id: '17',
        name: 'Slowenien',
        iso: 'SI',
        percentageLow: 5,
        percentageMid: 10,
        percentageHigh: 15,
        afterComma: 2,
        flag: ':flag-si:',
      ),
      Country(
        id: '18',
        name: 'Malediven',
        iso: 'MDV',
        percentageLow: 10,
        percentageMid: 20,
        percentageHigh: 30,
        afterComma: 2,
        flag: ':flag-mv:',
      ),
      Country(
        id: '19',
        name: 'Brasilien',
        iso: 'BRA',
        percentageLow: 15,
        percentageMid: 25,
        percentageHigh: 35,
        afterComma: 2,
        flag: ':flag-br:',
      ),
      Country(
        id: '20',
        name: 'Ägypten',
        iso: 'EGY',
        percentageLow: 10,
        percentageMid: 15,
        percentageHigh: 20,
        afterComma: 2,
        flag: ':flag-eg:',
      ),
    ],
    net: 100,
    quality: Quality.mid,
    selectedCountry: '1',
    darkMode: false,
    overrides: [TippOverride(id: 'de', quality: Quality.high, percentage: 20)],
    ownTippingAmount: 20,
    selectedLanguage: German(),
  );
}
