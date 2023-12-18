import 'dart:developer';
import 'package:trinkgeld_app/models/country.dart';
import 'package:trinkgeld_app/models/language.dart';
import 'package:trinkgeld_app/models/override.dart';
import 'package:trinkgeld_app/models/quality.dart';
///Root der App.
class Appstate {
  ///Country List.
  List<Country> countries;
  List<TippOverride> overrides;
  ///netto Wert.
  int net;
  ///Qualität
  Quality quality;
  ///Variable die das ausgewählte Land speichert.
  String selectedCountry;
  ///Boolische Variable, die ob Hintergrund der App dark oder light ist speichert.
  bool darkMode;
  ///Ausgewählte Sprache.
  Language selectedLanguage;
  ///Trinkgeldbetrag, den der User selbe eintragen kann.
  int ownTippingAmount;
///Appstate daten
  Appstate({
    required this.countries,
    required this.net,
    required this.quality,
    required this.selectedCountry,
    required this.darkMode,
    required this.overrides,
    required this.selectedLanguage,
    required this.ownTippingAmount,
    required int gros,
  });
///copyWith Methode, die die Daten von Appstate herauszieht.
  Appstate copyWith({
    List<Country>? countries,
    int? net,
    int? gros,
    Quality? quality,
    String? selectedCountry,
    bool? darkMode,
    List<TippOverride>? overrides,
    Language? selectedLanguage,
    int? ownTippingAmount,
  }) => Appstate(
      countries: countries ?? this.countries,
      net: net ?? this.net,
      gros: gros ?? this.gros,
      quality: quality ?? this.quality,
      selectedCountry: selectedCountry ?? this.selectedCountry,
      darkMode: darkMode ?? this.darkMode,
      overrides: overrides ?? this.overrides,
      selectedLanguage: selectedLanguage ?? this.selectedLanguage,
      ownTippingAmount: ownTippingAmount ?? this.ownTippingAmount,
    );
///Objekt des ausgewähltes Land
  Country get selectedCountryObject {
    for (final c in countries) {
      if (c.id == selectedCountry) {
        return c;
      }
    }
    return countries.first;
  }
/// gros ist die Variagle, die den Bruttowert von Trinkgeld Betrag ergibt. 
  int get gros => net + tipp;

  int? overridePercentage(Quality quality) {
    final fittingOverrides = overrides
        .where((o) => o.id == selectedCountry && o.quality == quality)
        .toList();
    if (fittingOverrides.isNotEmpty) {
      return fittingOverrides.first.percentage;
    }
    return null;
  }
/// tipp Variable speichert den Wert von durch die Formel ausgerechnete Trinkgeld
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

  int getRealTipPercentage(Country country, Quality quality) {
    final applicablwOverrides =
        overrides.where((o) => o.id == country.id && o.quality == quality);
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
