/// Abstrakte Klasse Language, die als Schnittstelle für verschiedene Sprachen dient.
abstract class Language {
  // const Language._();
  ///auf Deutsch: "Trinkgeld App" und auf English: "Tipping App".
  String get title;

  ///auf Deutsch: "Sprache" und auf English: "language"
  String get language;

  ///auf Deutsch: "Deutsch" und auf English:  "English"
  String get ownName;

  ///auf Deutsch: "Rechnungsbetrag" und auf English: "Your bill amount"
  String get amount;

  ///auf Deutsch: "Einstellungen" und auf English: "Settings"
  String get settings;

  ///auf Deutsch: "Bewerten!" und auf English: "Please rate the service!"
  String get rating;

  ///auf Deutsch: "Eigenes Tringeld %" und auf English: "Custom Tipping %"
  String get ownTipping;

  ///auf Deutsch: "Fehler melden!" und auf English: "Report a bug!"
  String get bugReport;

  ///auf Deutsch: "Einstellung" und auf English: "Settings"
  String get bottomButtonSettings;

  ///auf Deutsch: "Rechnen" und auf English: "Calculate"
  String get bottomButtonCalculate;

  ///auf Deutsch: "Trinkgeld Betrag" und auf English: "Tip Amount"
  String get tippAmount;

  ///auf Deutsch: "Zuzahlende Betrag" und auf English: "Total"
  String get totalAmount;

  ///auf Deutsch: "Qualität hoch" und auf English: "quality high"
  String get ownQualityLevelHigh;

  ///auf Deutsch: "Qualität mitte" und auf English: "quality mid"
  String get ownQualityLevelmid;

  ///auf Deutsch: "Qualität niedrig" und auf English: "quality low"
  String get ownQualityLevellow;

  ///auf Deutsch: "Eigentrinkgeld Eingabe" und auf English: "own tipp setting"
  String get ownTippSettingButton;

  ///auf Deutsch: "Fehlermeldung Formular" und auf English: "Bug Report Form"
  String get bugReportAppBarTitle;

  ///auf Deutsch: "Geben Sie Ihre E-Mail ein" und auf English: "Your E-Mail"
  String get eMailInput;

  ///auf Deutsch: "Bitte den Fehler beschreiben!" und auf English: "Please describe the bug!"
  String get describeTheBug;

  ///auf Deutsch: "Geben Sie Ihre Email ein" und auf English: "Your Email"
  String get eMailValidationFieldText;

  ///auf Deutsch: "Email correct" und auf English: "Email correct"
  String get emailValidConfirmationValid;

  ///auf Deutsch: "Falsche Email" und auf English: "Invalid Email"
  String get emailValidConfirmationInvalid;
}

/// Konkrete Implementierung für die deutsche Sprache.
class German implements Language {
  ///Die Variable German, die die Überschriften und etc. im Deutschen speichert.
  const German();

  @override
  @override
  String get eMailValidationFieldText => 'Geben Sie Ihre Email ein';

  @override
  String get describeTheBug => 'Bitte den Fehler beschreiben!';

  @override
  String get bugReportAppBarTitle => 'Fehlermeldung Formular';

  @override
  String get eMailInput => 'Geben Sie Ihre E-Mail ein';

  @override
  String get title => 'Trinkgeld App';

  @override
  String get language => 'Sprache';

  @override
  String get ownName => 'Deutsch';

  @override
  String get amount => 'Rechnungsbetrag';

  @override
  String get settings => 'Einstellungen';

  @override
  String get rating => 'Bewerten!';

  @override
  String get ownTipping => 'Eigenes Tringeld %';

  @override
  String get bugReport => 'Fehler melden!';

  @override
  String get bottomButtonSettings => 'Einstellung';

  @override
  String get bottomButtonCalculate => 'Rechnen';

  @override
  String get tippAmount => 'Trinkgeld Betrag';

  @override
  String get totalAmount => 'Zuzahlende Betrag';

  @override
  String get ownQualityLevelHigh => 'Qualität hoch';

  @override
  String get ownQualityLevelmid => 'Qualität mitte';

  @override
  String get ownQualityLevellow => 'Qualität niedrig';

  @override
  String get ownTippSettingButton => 'Eigentrinkgeld Eingabe';

  @override
  String get emailValidConfirmationValid => 'Email correct';

  @override
  String get emailValidConfirmationInvalid => 'Falsche Email';
}

/// Konkrete Implementierung für die englische Sprache.
class English implements Language {
  ///Die Variable English, die die Überschriften und etc. im Deutschen speichert.

  const English();

  @override
  String get eMailValidationFieldText => 'Your Email';

  @override
  String get describeTheBug => 'Please describe the bug!';

  @override
  String get bugReportAppBarTitle => 'Bug Report Form';

  @override
  String get eMailInput => 'Your E-Mail';

  @override
  String get title => 'Tipping App';

  @override
  String get language => 'Language';

  @override
  String get ownName => 'English';

  @override
  String get amount => 'Your bill amount';

  @override
  String get settings => 'Settings';

  @override
  String get rating => 'Please rate the service!';

  @override
  String get ownTipping => 'Custom Tipping %';

  @override
  String get bugReport => 'Report a bug!';

  @override
  String get bottomButtonSettings => 'Settings';

  @override
  String get bottomButtonCalculate => 'Calculate';

  @override
  String get tippAmount => 'Tip Amount';

  @override
  String get totalAmount => 'Total';

  @override
  String get ownQualityLevelHigh => 'quality high';

  @override
  String get ownQualityLevelmid => 'quality mid';

  @override
  String get ownQualityLevellow => 'quality low';

  @override
  String get ownTippSettingButton => 'own tipp setting';

  @override
  String get emailValidConfirmationValid => 'Email correct';

  @override
  String get emailValidConfirmationInvalid => 'Invalid Email';

// Language({
// required this.title,
// required this.language,
// required this.ownName,
// required this.amount,
// required this.settings,
// required this.rating,
// required this.ownTipping,
// required this.bugReport,
// required this.bottomButtonCalculate,
// required this.bottomButtonSettings,
// required this.tippAmount,
// required this.totalAmount,
// required this.ownQualityLevelHigh,
// required this.ownQualityLevelmid,
// required this.ownQualityLevellow,
// required this.ownTippSettingButton,
// });

// Language copyWith({
//   String? title,
//   String? language,
//   String? ownName,
//   String? amount,
//   String? settings,
//   String? rating,
//   String? ownTipping,
//   String? bugReport,
//   String? bottomButtonCalculate,
//   String? bottomButtonSettings,
//   String? tippAmount,
//   String? totalAmount,
//   String? ownQualityLevelHigh,
//   String? ownQualityLevelmid,
//   String? ownQualityLevellow,
//   String? ownTippSettingButton,
// }) {
//   return Language(
//     title: title ?? this.title,
//     language: language ?? this.language,
//     ownName: ownName ?? this.ownName,
//     amount: amount ?? this.amount,
//     settings: settings ?? this.settings,
//     rating: rating ?? this.rating,
//     ownTipping: ownTipping ?? this.ownTipping,
//     bugReport: bugReport ?? this.bugReport,
//     bottomButtonCalculate: bottomButtonCalculate ?? this.bottomButtonCalculate,
//     bottomButtonSettings: bottomButtonSettings ?? this.bottomButtonSettings,
//     tippAmount: tippAmount ?? this.tippAmount,
//     totalAmount: totalAmount ?? this.totalAmount,
//     ownQualityLevelHigh: ownQualityLevelHigh ?? this.ownQualityLevelHigh,
//     ownQualityLevelmid: ownQualityLevelmid ?? this.ownQualityLevelmid,
//     ownQualityLevellow: ownQualityLevellow ?? this.ownQualityLevellow,
//     ownTippSettingButton: ownTippSettingButton ?? this.ownTippSettingButton,
//   );
// }

//   Map<String, dynamic> toJson() {
//     return {
//       'title': title,
//       'language': language,
//       'ownName': ownName,
//       'amount': amount,
//       'settings': settings,
//       'rating': rating,
//       'ownTipping': ownTipping,
//       'bugReport': bugReport,
//       'bottomButtonCalculate': bottomButtonCalculate,
//       'bottomButtonSettings': bottomButtonSettings,
//       'tippAmount': tippAmount,
//       'totalAmount': totalAmount,
//       'ownQualityLevelHigh': ownQualityLevelHigh,
//       'ownQualityLevelmid': ownQualityLevelmid,
//       'ownQualityLevellow': ownQualityLevellow,
//       'ownTippSettingButton': ownTippSettingButton,
//     };
//   }

//   factory Language.fromJson(Map<String, dynamic> json) {
//     return Language(
//       title: json['title'],
//       language: json['language'],
//       ownName: json['ownName'],
//       amount: json['amount'],
//       settings: json['settings'],
//       rating: json['rating'],

//       ownTipping: json['ownTipping'],
//       bugReport: json['bugReport'],
//       bottomButtonCalculate: json['bottomButtonCalculate'],
//       bottomButtonSettings: json['bottomButtonSettings'],
//       tippAmount: json['tippAmount'],
//       totalAmount: json['totalAmount'],
//       ownQualityLevelHigh: json['ownQualityLevelHigh'],
//       ownQualityLevelmid: json['ownQualityLevelmid'],
//       ownQualityLevellow: json['ownQualityLevellow'],
//       ownTippSettingButton: json['ownTippSettingButton'],
//     );
//   }
//   @override
//   String toString() {
//     return 'Language{title: $title, language: $language, ownName: $ownName, amount: $amount, settings: $settings, rating: $rating, ownTipping: $ownTipping, bugReport: $bugReport, bottomButtonCalculate: $bottomButtonCalculate, bottomButtonSettings: $bottomButtonSettings, tippAmount: $tippAmount, totalAmount: $totalAmount, ownQualityLevelHigh: $ownQualityLevelHigh, ownQualityLevelmid: $ownQualityLevelmid, ownQualityLevellow: $ownQualityLevellow, ownTippSettingButton: $ownTippSettingButton}';
//   }
}
