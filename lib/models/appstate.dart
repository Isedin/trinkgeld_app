import 'dart:developer';
import 'country.dart';
import 'language.dart';
import 'override.dart';
import 'quality.dart';

/// Klasse, die den Zustand der App repräsentiert
class Appstate {
  /// Liste von Ländern
  final List<Country> countries;

  /// Liste von individuellen Trinkgeldprofil-Überschreibungen
  final List<TippOverride> overrides;

  ///Nettobetrag
  final int net;

  /// Qualität des Service
  final Quality quality;

  /// ID des ausgewählten Landes
  final String selectedCountry;

  /// Dunkelmodus aktiviert oder deaktiviert
  final bool darkMode;

  /// Ausgewählte Sprache
  final Language selectedLanguage;

  /// Individueller Trinkgeldbetrag
  final int ownTippingAmount;

  /// Konstruktor für die Initialisierung des Zustands
  const Appstate({
    required this.countries,
    required this.net,
    required this.quality,
    required this.selectedCountry,
    required this.darkMode,
    required this.overrides,
    required this.selectedLanguage,
    required this.ownTippingAmount,
  });

  /// Methode zum Erstellen einer Kopie des Zustands mit möglichen Änderungen
  Appstate copyWith({
    List<Country>? countries,
    int? net,
    Quality? quality,
    String? selectedCountry,
    bool? darkMode,
    List<TippOverride>? overrides,
    Language? selectedLanguage,
    int? ownTippingAmount,
  }) => Appstate(
    countries: countries ?? this.countries,
    net: net ?? this.net,
    quality: quality ?? this.quality,
    selectedCountry: selectedCountry ?? this.selectedCountry,
    darkMode: darkMode ?? this.darkMode,
    overrides: overrides ?? this.overrides,
    selectedLanguage: selectedLanguage ?? this.selectedLanguage,
    ownTippingAmount: ownTippingAmount ?? this.ownTippingAmount,
  );

  /// Methode zur Rückgabe des ausgewählten Landes als Objekt
  Country get selectedCountryObject {
    for (final c in countries) {
      if (c.id == selectedCountry) return c;
    }
    // Fallback, falls Liste leer/ID nicht vorhanden ist
    return countries.isNotEmpty
        ? countries.first
        : const Country(
            id: '0',
            name: '—',
            iso: '—',
            percentageLow: 0,
            percentageMid: 0,
            percentageHigh: 0,
            afterComma: 2,
            flag: ':grey_question:',
          );
  }

  /// Methode zur Berechnung des Bruttobetrags (Nettobetrag + Trinkgeld)
  int get gros => net + tipp;

  /// Methode zur Überprüfung, ob es eine individuelle Trinkgeldprofil-Überschreibung für die ausgewählte Qualität gibt
  int? overridePercentage(Quality quality) {
    final fittingOverrides = overrides
        .where((o) => o.id == selectedCountry && o.quality == quality)
        .toList();
    if (fittingOverrides.isNotEmpty) {
      return fittingOverrides.first.percentage;
    }
    return null;
  }

  /// Methode zur Berechnung des Trinkgelds basierend auf der ausgewählten Qualität und individuellen Überschreibungen
  int get tipp {
    final int percentage;
    final oPercentage = overridePercentage(quality);
    if (oPercentage != null) {
      percentage = oPercentage;
    } else {
      if (quality == Quality.low) {
        percentage = selectedCountryObject.percentageLow;
      } else if (quality == Quality.mid) {
        percentage = selectedCountryObject.percentageMid;
      } else {
        percentage = selectedCountryObject.percentageHigh;
      }
    }

    final tippDouble = net * percentage / 100;
    final tipp = tippDouble.toInt();

    return tipp;
  }

  /// Methode zur Rückgabe des tatsächlichen Trinkgeldprozentsatzes für ein bestimmtes Land und Qualität
  int getRealTipPercentage(Country country, Quality quality) {
    final applicablwOverrides = overrides.where(
      (o) => o.id == country.id && o.quality == quality,
    );
    if (applicablwOverrides.isNotEmpty) {
      log(applicablwOverrides.first.id);
      log('${applicablwOverrides.first.quality}');
      log('${applicablwOverrides.first.percentage}');
      return applicablwOverrides.first.percentage;
    }
    if (quality == Quality.low) {
      return country.percentageLow;
    } else if (quality == Quality.mid) {
      return country.percentageMid;
    }
    return country.percentageHigh;
  }
}
