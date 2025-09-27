import 'package:trinkgeld_app/models/country.dart';
import 'package:trinkgeld_app/models/language.dart';
// Minimal Vocabulary for Country Localizations
const Map<String, Map<String, String>> _countryNamesByIso = {
  'DE': {'de': 'Deutschland', 'en': 'Germany'},
  'US': {'de': 'USA', 'en': 'United States'},
  'BA': {'de': 'Bosnien und Herzegowina', 'en': 'Bosnia and Herzegovina'},
  'TR': {'de': 'Türkei', 'en': 'Turkey'},
  'CN': {'de': 'China', 'en': 'China'},
  'FR': {'de': 'Frankreich', 'en': 'France'},
  'GB': {'de': 'Vereinigtes Königreich', 'en': 'United Kingdom'},
  'IT': {'de': 'Italien', 'en': 'Italy'},
  'ES': {'de': 'Spanien', 'en': 'Spain'},
  'HR': {'de': 'Kroatien', 'en': 'Croatia'},
  'AT': {'de': 'Österreich', 'en': 'Austria'},
  'CH': {'de': 'Schweiz', 'en': 'Switzerland'},
  'NL': {'de': 'Niederlande', 'en': 'Netherlands'},
  'BE': {'de': 'Belgien', 'en': 'Belgium'},
  'CA': {'de': 'Kanada', 'en': 'Canada'},
  'AU': {'de': 'Australien', 'en': 'Australia'},
  'JP': {'de': 'Japan', 'en': 'Japan'},
  'NO': {'de': 'Norwegen', 'en': 'Norway'},
  'SE': {'de': 'Schweden', 'en': 'Sweden'},
  'DK': {'de': 'Dänemark', 'en': 'Denmark'},
  'FI': {'de': 'Finnland', 'en': 'Finland'},
  'IE': {'de': 'Irland', 'en': 'Ireland'},
  'PT': {'de': 'Portugal', 'en': 'Portugal'},
  'GR': {'de': 'Griechenland', 'en': 'Greece'},
  'PL': {'de': 'Polen', 'en': 'Poland'},
  'CZ': {'de': 'Tschechien', 'en': 'Czechia'},
  'HU': {'de': 'Ungarn', 'en': 'Hungary'},
  'RO': {'de': 'Rumänien', 'en': 'Romania'},
  'BG': {'de': 'Bulgarien', 'en': 'Bulgaria'},
  'RU': {'de': 'Russland', 'en': 'Russia'},
  'IN': {'de': 'Indien', 'en': 'India'},
  'ZA': {'de': 'Südafrika', 'en': 'South Africa'},
  'MX': {'de': 'Mexiko', 'en': 'Mexico'},
  'AR': {'de': 'Argentinien', 'en': 'Argentina'},
  'CL': {'de': 'Chile', 'en': 'Chile'},
  'CO': {'de': 'Kolumbien', 'en': 'Colombia'},
  'PE': {'de': 'Peru', 'en': 'Peru'},
  'VE': {'de': 'Venezuela', 'en': 'Venezuela'},
  'EG': {'de': 'Ägypten', 'en': 'Egypt'},
  'AE': {'de': 'Vereinigte Arabische Emirate', 'en': 'United Arab Emirates'},
  'SA': {'de': 'Saudi-Arabien', 'en': 'Saudi Arabia'},
  'SI': {'de': 'Slowenien', 'en': 'Slovenia'},
  'SK': {'de': 'Slowakei', 'en': 'Slovakia'},
  'LU': {'de': 'Luxemburg', 'en': 'Luxembourg'},
  'MDV': {'de': 'Maldiven', 'en': 'Maldives'},
  'NZ': {'de': 'Neuseeland', 'en': 'New Zealand'},
  'SG': {'de': 'Singapur', 'en': 'Singapore'},
  'HK': {'de': 'Hongkong', 'en': 'Hong Kong'},
  'BRA': {'de': 'Brasilien', 'en': 'Brazil'},
  'TH': {'de': 'Thailand', 'en': 'Thailand'},
  'ID': {'de': 'Indonesien', 'en': 'Indonesia'},
  'PH': {'de': 'Philippinen', 'en': 'Philippines'},
  'PK': {'de': 'Pakistan', 'en': 'Pakistan'},
  'BD': {'de': 'Bangladesch', 'en': 'Bangladesh'},
  'LK': {'de': 'Sri Lanka', 'en': 'Sri Lanka'},
  'VN': {'de': 'Vietnam', 'en': 'Vietnam'},
  'MC': {'de': 'Monaco', 'en': 'Monaco'},
  'IS': {'de': 'Island', 'en': 'Iceland'},
  'AL': {'de': 'Albanien', 'en': 'Albania'},
  'RS': {'de': 'Serbien', 'en': 'Serbia'},
  'ME': {'de': 'Montenegro', 'en': 'Montenegro'},
  'MK': {'de': 'Nordmazedonien', 'en': 'North Macedonia'},
  'XK': {'de': 'Kosovo', 'en': 'Kosovo'},
  'BY': {'de': 'Weißrussland', 'en': 'Belarus'},
};


// Add Language object code ('de'/'en') without touching existing class
extension LanguageCodeX on Language {
  String get languageCode {
    if (this is German) return 'de';
    if (this is English) return 'en';
    return 'en'; // fallback
  }
}

/// Add localized name method to Country object without touching existing class
extension CountryI18nX on Country {
  String localizedName(String langCode) =>
      _countryNamesByIso[iso]?[langCode] ?? name;
}