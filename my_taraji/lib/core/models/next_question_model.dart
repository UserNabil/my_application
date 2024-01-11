class NextQuestion {
  // String title;
  // String description;
  // String imageUrl;
  // int stepNumber;
  // Company company;
  // List<CheckPoint> checkPoints;
  // List<WiningRank> winingRanks;
  // String id;

  NextQuestion(
      //{
      // required this.title,
      // required this.description,
      // required this.imageUrl,
      // required this.stepNumber,
      // required this.company,
      // required this.checkPoints,
      // required this.winingRanks,
      // required this.id,
      // }
      );

  factory NextQuestion.fromJson(Map<String, dynamic> jsonApi) {
    // Map<String, dynamic> json = jsonApi;
    return NextQuestion(
        // title: json['title'],
        // description: json['description'],
        // imageUrl: json['imageUrl'],
        // stepNumber: json['stepNumber'],
        // company: Company.fromMap(json['company']),
        // checkPoints: List<CheckPoint>.from(
        //     json['checkPoints']?.map((x) => CheckPoint.fromMap(x)) ?? []),
        // winingRanks: List<WiningRank>.from(
        //     json['winingRanks']?.map((x) => WiningRank.fromMap(x)) ?? []),
        // id: json['_id'],
        );
  }

  factory NextQuestion.fromMap(Map<String, dynamic> map) {
    return NextQuestion(
        // title: map['title'],
        // description: map['description'],
        // imageUrl: map['imageUrl'],
        // stepNumber: map['stepNumber'],
        // company: Company.fromMap(map['company']),
        // checkPoints: List<CheckPoint>.from(
        //     map['checkPoints']?.map((x) => CheckPoint.fromMap(x)) ?? []),
        // winingRanks: List<WiningRank>.from(
        //     map['winingRanks']?.map((x) => WiningRank.fromMap(x)) ?? []),
        // id: map['_id'],
        );
  }

  Map<String, dynamic> toMap() {
    return {
      // 'title': title,
      // 'description': description,
      // 'imageUrl': imageUrl,
      // 'stepNumber': stepNumber,
      // 'company': company.toMap(),
      // 'checkPoints': List<dynamic>.from(checkPoints.map((x) => x.toMap())),
      // 'winingRanks': List<dynamic>.from(winingRanks.map((x) => x.toMap())),
      // '_id': id,
    };
  }
}
