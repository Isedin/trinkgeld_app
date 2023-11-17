class Country {
  String id;
  String name;
  int percentageLow;
  int percentageMid;
  int percentageHigh;
  int afterComma;
  String flag;
  // int ownTippingAmount;

  Country( {
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

  factory Country.fromJson(Map<String,dynamic> json) {
    return Country(
      id: json['id'], 
      name: json['name'], 
      percentageLow: json['percentageLow'], 
      percentageMid: json['percentageMid'], 
      percentageHigh: json['percentageHigh'], 
      afterComma: json['afterComma'],
      flag: json['flag'],
      // ownTippingAmount: json['ownTippingAmount']
    );
  }
}


