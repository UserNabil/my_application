class News {
  String id;
  String imagePath;
  String title;
  String date;
  String admin;
  List<String> texts;
  Social? social;

  News({
    required this.id,
    required this.imagePath,
    required this.title,
    required this.date,
    required this.admin,
    required this.texts,
    this.social,
  });
}

class Social {
  String id;
  String like;
  String comment;
  String views;
  String imgAuthor;

  Social({
    required this.id,
    required this.like,
    required this.comment,
    required this.views,
    required this.imgAuthor,
  });
}
