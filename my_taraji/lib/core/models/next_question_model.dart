class ChallengeQuestionResult {
  NextQuestion nextQuestion;

  ChallengeQuestionResult({required this.nextQuestion});

  factory ChallengeQuestionResult.fromJson(Map<String, dynamic> jsonApi) {
    Map<String, dynamic> json = jsonApi;
    return ChallengeQuestionResult(
      nextQuestion: NextQuestion.fromMap(json['nextQuestion']),
    );
  }

  factory ChallengeQuestionResult.fromMap(Map<String, dynamic> map) {
    return ChallengeQuestionResult(
      nextQuestion: NextQuestion.fromMap(map['nextQuestion']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'nextQuestion': nextQuestion.toMap(),
    };
  }
}

class NextQuestion {
  String title;
  String description;
  int counterTime;
  int rewardPoints;
  List<ChallengeQuestionChoiceItem> choices;
  String id;
  String createdAt;
  String updatedAt;
  NextQuestion({
    required this.title,
    required this.description,
    required this.counterTime,
    required this.rewardPoints,
    required this.choices,
    required this.id,
    required this.createdAt,
    required this.updatedAt,
  });

  factory NextQuestion.fromMap(Map<String, dynamic> jsonApi) {
    Map<String, dynamic> json = jsonApi;
    return NextQuestion(
      id: json['_id'],
      title: json['title'],
      description: json['description'],
      counterTime: json['counterTime'],
      rewardPoints: json['rewardPoints'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      choices: List<ChallengeQuestionChoiceItem>.from(
          json['choices']?.map((x) => ChallengeQuestionChoiceItem.fromMap(x)) ??
              []),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'title': title,
      'description': description,
      'counterTime': counterTime,
      'rewardPoints': rewardPoints,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'choices': choices,
    };
  }
}

class ChallengeQuestionChoiceItem {
  String id;
  String value;
  ChallengeQuestionChoiceItem({required this.id, required this.value});
  factory ChallengeQuestionChoiceItem.fromMap(Map<String, dynamic> map) {
    return ChallengeQuestionChoiceItem(id: map['_id'], value: map['value']);
  }
  Map<String, dynamic> toMap() {
    return {'_id': id, 'value': value};
  }
}
