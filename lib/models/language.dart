abstract class Language {
  const Language._();
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
}

class German extends Language {
  const German() : super._();
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
}

class English extends Language {
  const English() : super._();
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
}
