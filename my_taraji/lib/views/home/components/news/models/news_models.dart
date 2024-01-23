class News {
  int id;
  String? imagePath;
  String title;
  String? citation;
  String date;
  String admin;
  List<NewsDetailsModel> content;
  Social? social;

  News({
    required this.id,
    this.imagePath,
    required this.title,
    this.citation,
    required this.date,
    required this.admin,
    required this.content,
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

    return News(
      id: json['id'] ?? 0,
      imagePath: imagePath,
      title: json['title'] ?? '',
      date: json['newsPublishDate'] ?? '',
      admin: json['createdBy'] ?? '',
      content: fromJsonListNewsModel(json['details']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'imageUri': imagePath,
      'title': title,
      'date': date,
      'admin': admin,
      // 'texts': content,
      'social': social?.toJson(),
    };
  }
}

class NewsDetailsModel {
  int id;
  String detailHTML;
  String detailValue;

  NewsDetailsModel({
    required this.id,
    required this.detailHTML,
    required this.detailValue,
  });

  factory NewsDetailsModel.fromJson(Map<String, dynamic> json) {
    return NewsDetailsModel(
      id: json['id'] ?? 0,
      detailHTML: json['detailHTML'] ?? '',
      detailValue: json['detailValue'] ?? '',
    );
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

List<News> fromJsonListNews(List<dynamic>? jsonList) {
  if (jsonList == null || jsonList.isEmpty) {
    return [];
  } else {
    return jsonList.map((json) => News.fromJson(json)).toList();
  }
}

List<NewsDetailsModel> fromJsonListNewsModel(dynamic jsonList) {
  List<NewsDetailsModel> news = [];

  if (jsonList != null && jsonList is List) {
    for (var jsonItem in jsonList) {
      if (jsonItem != null && jsonItem is Map<String, dynamic>) {
        try {
          news.add(NewsDetailsModel.fromJson(jsonItem));
        } catch (e) {
          throw ("fromJsonListNewsModel error : $e");
        }
      }
    }
  }

  return news;
}
