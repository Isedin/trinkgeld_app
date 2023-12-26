class Country {
  final String id;
  final String name;
  final int percentageLow;
  final int percentageMid;
  final int percentageHigh;
  final int afterComma;
  final String flag;
  // int ownTippingAmount;

  const Country({
    required this.id,
    required this.name,
    required this.percentageLow,
    required this.percentageMid,
    required this.percentageHigh,
    required this.afterComma,
    required this.flag,
    // required this.ownTippingAmount,
  });

  Country copyWith({
    String? id,
    String? name,
    int? percentageLow,
    int? percentageMid,
    int? percentageHigh,
    int? afterComma,
    String? flag,
    // int? ownTippingAmount,
  }) {
    return Country(
      id: id ?? this.id,
      name: name ?? this.name,
      percentageLow: percentageLow ?? this.percentageLow,
      percentageMid: percentageMid ?? this.percentageMid,
      percentageHigh: percentageHigh ?? this.percentageHigh,
      afterComma: afterComma ?? this.afterComma,
      flag: flag ?? this.flag,
      // ownTippingAmount: ownTippingAmount ?? this.ownTippingAmount,
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
      // 'ownTippingAmount': ownTippingAmount,
    };
  }

  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(
      id: json['id'] as String,
      name: json['name'] as String,
      percentageLow: json['percentageLow'] as int,
      percentageMid: json['percentageMid'] as int,
      percentageHigh: json['percentageHigh'] as int,
      afterComma: json['afterComma'] as int,
      flag: json['flag'] as String,
      // ownTippingAmount: json['ownTippingAmount']
    );
  }
  @override
  String toString() {
    return 'Country{id: $id, name: $name, percentageLow: $percentageLow, percentageMid: $percentageMid, percentageHigh: $percentageHigh, afterComma: $afterComma, flag: $flag}';
  }
}
