class CampaignType {
  String id;
  int expPoints;
  String image;
  List<QuestionType> questionTypes;

  CampaignType({
    required this.id,
    required this.expPoints,
    required this.image,
    required this.questionTypes,
  });

  factory CampaignType.fromJson(Map<String, dynamic> json) {
    return CampaignType(
      id: json['Id'] ?? '',
      expPoints: json['ExpPoints'] ?? 0,
      image: json['Image'] ?? '',
      questionTypes: fromJsonListQuestionType(json['QuestionTypes']),
    );
  }
}

class QuestionType {
  String id;
  String questionType;
  String image;

  QuestionType({
    required this.id,
    required this.questionType,
    required this.image,
  });

  factory QuestionType.fromJson(Map<String, dynamic> json) {
    return QuestionType(
      id: json['Id'] ?? '',
      questionType: json['QuestionType'] ?? '',
      image: json['Image'] ?? '',
    );
  }
}

List<QuestionType> fromJsonListQuestionType(List<dynamic>? jsonList) {
  if (jsonList == null || jsonList.isEmpty) {
    return [];
  } else {
    return jsonList.map((json) => QuestionType.fromJson(json)).toList();
  }
}

class QuestionCampaign {
  String id;
  String name;
  String description;
  String questionType;
  bool required;
  String nextButtonLabel;
  int order;
  List<Meta> metas;
  List<Option> options;

  QuestionCampaign({
    required this.id,
    required this.questionType,
    required this.metas,
    required this.options,
    required this.name,
    required this.description,
    required this.required,
    required this.nextButtonLabel,
    required this.order,
  });

  factory QuestionCampaign.fromJson(Map<String, dynamic> json) {
    RegExp exp = RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true);
    String desc = json['Description'].toString().replaceAll(exp, '');
    return QuestionCampaign(
      id: json['Id'] ?? '',
      questionType: json['QuestionType'] ?? '',
      metas: fromJsonListMeta(json['ObjectMetas']),
      options: fromJsonListOption(json['QuestionOptions']),
      name: json['Name'] ?? '',
      description: desc,
      required: json['Required'] ?? false,
      nextButtonLabel: json['NextButtonLabel'] ?? '',
      order: json['Order'] ?? 0,
    );
  }
}

List<QuestionCampaign> fromJsonListQuestion(List<dynamic>? jsonList) {
  if (jsonList == null || jsonList.isEmpty) {
    return [];
  } else {
    return jsonList.map((json) => QuestionCampaign.fromJson(json)).toList();
  }
}

class Meta {
  String id;
  String name;
  String type;
  String value;

  Meta({
    required this.id,
    required this.name,
    required this.type,
    required this.value,
  });

  factory Meta.fromJson(Map<String, dynamic> json) {
    return Meta(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      type: json['type'] ?? '',
      value: json['value'] ?? '',
    );
  }
}

List<Meta> fromJsonListMeta(List<dynamic>? jsonList) {
  if (jsonList == null || jsonList.isEmpty) {
    return [];
  } else {
    return jsonList.map((json) => Meta.fromJson(json)).toList();
  }
}

class Option {
  String id;
  String name;
  String value;

  Option({
    required this.id,
    required this.name,
    required this.value,
  });

  factory Option.fromJson(Map<String, dynamic> json) {
    return Option(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      value: json['value'] ?? '',
    );
  }
}

List<Option> fromJsonListOption(List<dynamic>? jsonList) {
  if (jsonList == null || jsonList.isEmpty) {
    return [];
  } else {
    return jsonList.map((json) => Option.fromJson(json)).toList();
  }
}

class Media {
  String id;
  String name;
  String url;
  String type;

  Media({
    required this.id,
    required this.name,
    required this.url,
    required this.type,
  });

  factory Media.fromJson(Map<String, dynamic> json) {
    return Media(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      url: json['url'] ?? '',
      type: json['type'] ?? '',
    );
  }
}

List<Media> fromJsonListMedia(List<dynamic>? jsonList) {
  if (jsonList == null || jsonList.isEmpty) {
    return [];
  } else {
    return jsonList.map((json) => Media.fromJson(json)).toList();
  }
}
