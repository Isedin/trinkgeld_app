abstract class Language {
  // const Language._();
  String get title;
  String get language;
  String get ownName;
  String get amount;
  String get settings;
  String get rating;
  String get ownTipping;
  String get bugReport;
  String get bottomButtonSettings;
  String get bottomButtonCalculate;
  String get tippAmount;
  String get totalAmount;
  String get ownQualityLevelHigh;
  String get ownQualityLevelmid;
  String get ownQualityLevellow;
  String get ownTippSettingButton;
  String get bugReportAppBarTitle;
  String get eMailInput;
  String get describeTheBug;
  String get eMailValidationFieldText;
  String get emailValidConfirmValid;
  String get emailValidConfirmInvalid;
  // List get countryNames;
}

class German implements Language {
  const German();

  @override
  // List get countryNames => ['Deutschland', 'USA'];

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
  String get emailValidConfirmValid => 'Email correct';

  @override
  String get emailValidConfirmInvalid => 'Falsche Email';
}

class English implements Language {
  const English();

  List get countryNames => ['Germany', 'USA'];
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
  String get emailValidConfirmValid => 'Email correct';

  @override
  String get emailValidConfirmInvalid => 'Invalid Email';

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
