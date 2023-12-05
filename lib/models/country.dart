class Country {
  String id;
  String name;
  int percentageLow;
  int percentageMid;
  int percentageHigh;
  int afterComma;
  String flag;

  Country({
    required this.id,
    required this.name,
    required this.percentageLow,
    required this.percentageMid,
    required this.percentageHigh,
    required this.afterComma,
    required this.flag,
  });

  Country copyWith({
    String? id,
    String? name,
    int? percentageLow,
    int? percentageMid,
    int? percentageHigh,
    int? afterComma,
    String? flag,
  }) {
    return Country(
      id: id ?? this.id,
      name: name ?? this.name,
      percentageLow: percentageLow ?? this.percentageLow,
      percentageMid: percentageMid ?? this.percentageMid,
      percentageHigh: percentageHigh ?? this.percentageHigh,
      afterComma: afterComma ?? this.afterComma,
      flag: flag ?? this.flag,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'percentageLow': percentageLow,
      'percentageMid': percentageMid,
      'percentageHigh': percentageHigh,
      'afterComma': afterComma,
      'flag': flag,
    };
  }

  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(
      id: json['id'],
      name: json['name'],
      percentageLow: json['percentageLow'],
      percentageMid: json['percentageMid'],
      percentageHigh: json['percentageHigh'],
      afterComma: json['afterComma'],
      flag: json['flag'],
    );
  }
  @override
  String toString() {
    return 'Country{id: $id, name: $name, percentageLow: $percentageLow, percentageMid: $percentageMid, percentageHigh: $percentageHigh, afterComma: $afterComma, flag: $flag}';
  }
}
