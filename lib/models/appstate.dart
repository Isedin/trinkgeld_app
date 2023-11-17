import 'package:trinkgeld_app/models/country.dart';
import 'package:trinkgeld_app/models/language.dart';
import 'package:trinkgeld_app/models/override.dart';
import 'package:trinkgeld_app/models/quality.dart';

class Appstate {
  List<Country> countries;
  List<TippOverride> overrides;
  int net;
  int gros;
  Quality quality;
  String selectedCountry;
  bool darkMode;
  Language selectedLanguage;
  int ownTippingAmount;

  Appstate(
      {required this.countries,
      required this.net,
      required this.gros,
      required this.quality,
      required this.selectedCountry,
      required this.darkMode,
      required this.overrides,
      required this.selectedLanguage,
      required this.ownTippingAmount,
      });

  Appstate copyWith(
      {List<Country>? countries,
      int? net,
      int? gros,
      Quality? quality,
      String? selectedCountry,
      bool? darkMode,
      List? override,
      Language? selectedLanguage,
      int? ownTippingAmount,
      }) {
    return Appstate(
      countries: countries ?? this.countries,
      net: net ?? this.net,
      gros: gros ?? this.gros,
      quality: quality ?? this.quality,
      selectedCountry: selectedCountry ?? this.selectedCountry,
      darkMode: darkMode ?? this.darkMode,
      overrides: overrides,
      selectedLanguage: selectedLanguage ?? this.selectedLanguage,
      ownTippingAmount: ownTippingAmount ?? this.ownTippingAmount,
    );
  }

  Country? get selectedCountryObject {
    for (final c in countries) {
      if (c.id == selectedCountry) {
        return c;
      }
    }
    return null;
  }
}
// Der oben gegebene Code definiert eine Klasse namens "Appstate". Diese Klasse hat folgende Eigenschaften:

// Eine Liste von Objekten des Typs "Country" mit dem Namen "countries".
// Zwei Ganzzahlen mit den Namen "net" und "gros".
// Ein Objekt des Typs "Quality" mit dem Namen "quality".
// Ein Zeichenkettenobjekt mit dem Namen "selectedCountry".
// Ein boolescher Wert mit dem Namen "darkMode".
// Die Klasse hat einen Konstruktor, der alle oben genannten Eigenschaften als erforderliche Parameter annimmt.

// Die Klasse hat auch eine Methode namens "copyWith", die ein neues Objekt vom Typ "Appstate" zurückgibt. Diese Methode akzeptiert optionale Parameter, die die oben genannten Eigenschaften der Klasse aktualisieren können. Wenn ein optionaler Parameter nicht angegeben ist, wird der aktuelle Wert beibehalten.

// Insgesamt ermöglicht dieser Code das Erstellen und Aktualisieren von Objekten vom Typ "Appstate" mit verschiedenen Werten für seine Eigenschaften.
