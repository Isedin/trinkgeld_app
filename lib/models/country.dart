/// Die Klasse Country repräsentiert ein Datenmodell für Länder.
class Country {
  /// Instanzvariablen zur Speicherung von Länderinformationen:
  /// id
  final String id;

  ///Name
  final String name;

  ///iso Zeichen von dem einzelnen Land
  final String iso;

  ///das niedrigste Prozent
  final int percentageLow;

  ///das mittlere Prozent
  final int percentageMid;

  ///das höchste Prozent
  final int percentageHigh;

  ///Nachkomma Stellen
  final int afterComma;

  ///Flagge des Landes
  final String flag;

  /// Währung des Landes
  final String currencyCode;

  /// Lokaleinstellung des Landes
  final String locale;

  /// Konstruktor für die Initialisierung von Instanzvariablen.
  const Country({
    required this.id,
    required this.name,
    required this.iso,
    required this.percentageLow,
    required this.percentageMid,
    required this.percentageHigh,
    required this.afterComma,
    required this.flag,
    required this.currencyCode,
    required this.locale,
  });

  /// Methode, die eine Kopie des aktuellen Objekts mit optionalen Änderungen zurückgibt.
  Country copyWith({
    String? id,
    String? name,
    String? iso,
    int? percentageLow,
    int? percentageMid,
    int? percentageHigh,
    int? afterComma,
    String? flag,
    String? currencyCode,
    String? locale,
  }) =>
      Country(
        id: id ?? this.id,
        name: name ?? this.name,
        iso: iso ?? this.iso,
        percentageLow: percentageLow ?? this.percentageLow,
        percentageMid: percentageMid ?? this.percentageMid,
        percentageHigh: percentageHigh ?? this.percentageHigh,
        afterComma: afterComma ?? this.afterComma,
        flag: flag ?? this.flag,
        currencyCode: currencyCode ?? this.currencyCode,
        locale: locale ?? this.locale,
      );

  /// Methode zur Konvertierung des Objekts in ein JSON-Format.
  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'iso': iso,
        'percentageLow': percentageLow,
        'percentageMid': percentageMid,
        'percentageHigh': percentageHigh,
        'afterComma': afterComma,
        'flag': flag,
        'currencyCode': currencyCode,
        'locale': locale,
      };

  /// Factory-Methode zum Erstellen eines Country-Objekts aus JSON-Daten.
  factory Country.fromJson(Map<String, dynamic> json) => Country(
        id: json['id'] as String,
        name: json['name'] as String,
        iso: json['iso'] as String,
        percentageLow: json['percentageLow'] as int,
        percentageMid: json['percentageMid'] as int,
        percentageHigh: json['percentageHigh'] as int,
        afterComma: json['afterComma'] as int,
        flag: json['flag'] as String,
        currencyCode: json['currencyCode'] as String,
        locale: json['locale'] as String,
      );
  @override
  String toString() =>
      'Country{id: $id, name: $name, percentageLow: $percentageLow, percentageMid: $percentageMid, percentageHigh: $percentageHigh, afterComma: $afterComma, flag: $flag, currencyCode: $currencyCode, locale: $locale}';
}
