/// Die Klasse Country repräsentiert ein Datenmodell für Länder.
class Country {
  /// Instanzvariablen zur Speicherung von Länderinformationen:
  /// id
  String id;

  ///Name
  String name;

  ///iso Zeichen von dem einzelnen Land
  String iso;

  ///das niedrigste Prozent
  int percentageLow;

  ///das mittlere Prozent
  int percentageMid;

  ///das höchste Prozent
  int percentageHigh;

  ///Nachkomma Stellen
  int afterComma;

  ///Flagge des Landes
  String flag;

  /// Konstruktor für die Initialisierung von Instanzvariablen.
  Country({
    required this.id,
    required this.name,
    required this.iso,
    required this.percentageLow,
    required this.percentageMid,
    required this.percentageHigh,
    required this.afterComma,
    required this.flag,
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
      };

  /// Factory-Methode zum Erstellen eines Country-Objekts aus JSON-Daten.
  factory Country.fromJson(Map<String, dynamic> json) => Country(
        id: json['id'],
        name: json['name'],
        iso: json['iso'],
        percentageLow: json['percentageLow'],
        percentageMid: json['percentageMid'],
        percentageHigh: json['percentageHigh'],
        afterComma: json['afterComma'],
        flag: json['flag'],
      );
  @override
  String toString() =>
      'Country{id: $id, name: $name, percentageLow: $percentageLow, percentageMid: $percentageMid, percentageHigh: $percentageHigh, afterComma: $afterComma, flag: $flag}';
}
