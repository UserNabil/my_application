class News {
  String id;
  String? imagePath;
  String title;
  String? citation;
  String date;
  String admin;
  List<String> texts;
  Social? social;

  News({
    required this.id,
    this.imagePath,
    required this.title,
    this.citation,
    required this.date,
    required this.admin,
    required this.texts,
    this.social,
  });

  factory News.fromJson(Map<String, dynamic> json) {
    List<Detail> details = (json['details'] as List<dynamic>)
        .map((detailJson) => Detail.fromJson(detailJson))
        .toList();

    String imagePath = details
        .firstWhere((detail) => detail.detailHTML == "src",
            orElse: () => Detail(detailHTML: "", detailValue: ""))
        .detailValue;

    String citation = details
        .firstWhere((detail) => detail.detailHTML == "em",
            orElse: () => Detail(detailHTML: "", detailValue: ""))
        .detailValue;

    List<String> texts = details
        .where((detail) => detail.detailHTML == "p")
        .map((detail) => detail.detailValue)
        .toList();

    return News(
      id: json['itemSourceId'] ?? '',
      imagePath: imagePath,
      title: json['title'] ?? '',
      citation: citation,
      date: json['newsPublishDate'] ?? '',
      admin: json['createdBy'] ?? '',
      texts: texts,
      social: json['social'] != null ? Social.fromJson(json['social']) : null,
    );
  }

  factory News.fromMap(Map<String, dynamic> map) {
    return News(
      id: map['id'] ?? '',
      imagePath: map['imageUri'] ?? '',
      title: map['title'] ?? '',
      date: map['date'] ?? '',
      admin: map['admin'] ?? '',
      texts: map['texts'] != null ? List<String>.from(map['texts']) : [],
      social: map['social'] != null ? Social.fromJson(map['social']) : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'imageUri': imagePath,
      'title': title,
      'date': date,
      'admin': admin,
      'texts': texts,
      'social': social?.toJson(),
    };
  }
}

class Detail {
  String detailHTML;
  String detailValue;

  Detail({
    required this.detailHTML,
    required this.detailValue,
  });

  factory Detail.fromJson(Map<String, dynamic> json) {
    return Detail(
      detailHTML: json['detailHTML'] ?? '',
      detailValue: json['detailValue'] ?? '',
    );
  }
}

class Social {
  String? like;
  String? comment;
  String? views;
  String? imgAuthor;

  Social({
    this.like,
    this.comment,
    this.views,
    this.imgAuthor,
  });

  factory Social.fromJson(Map<String, dynamic> json) {
    return Social(
      like: json['like'] ?? '',
      comment: json['comment'] ?? '',
      views: json['views'] ?? '',
      imgAuthor: json['imgAuthor'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'like': like,
      'comment': comment,
      'views': views,
      'imgAuthor': imgAuthor,
    };
  }
}

List<News> fromJsonListNews(dynamic jsonList) {
  List<News> news = [];

  if (jsonList != null && jsonList is List) {
    for (var jsonItem in jsonList) {
      if (jsonItem != null && jsonItem is Map<String, dynamic>) {
        news.add(News.fromJson(jsonItem));
      }
    }
  }

  return news;
}
