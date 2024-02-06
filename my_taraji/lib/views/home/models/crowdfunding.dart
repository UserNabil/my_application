class Crowdfunding {
  bool? enabled;
  bool? archived;
  int? targetAmount;
  int? totalAmountContributed;
  String title;
  String? imageUrl;
  String? description;
  String? status;
  int? audienceSize;
  // DateTime? startDate;
  // DateTime? endDate;
  String? startDate;
  String? endDate;
  String? company;
  String? creator;
  int? v;
  String? id;
  // DateTime? createdAt;
  // DateTime? updatedAt;
  String? createdAt;
  String? updatedAt;

  Crowdfunding({
    required this.enabled,
    required this.archived,
    required this.targetAmount,
    required this.totalAmountContributed,
    required this.title,
    required this.imageUrl,
    required this.description,
    required this.status,
    required this.audienceSize,
    required this.startDate,
    required this.endDate,
    required this.company,
    required this.creator,
    required this.v,
    required this.id,
    required this.createdAt,
    required this.updatedAt,
  });

  // Factory constructor for JSON deserialization
  factory Crowdfunding.fromJson(Map<String, dynamic> json) {
    return Crowdfunding(
      enabled: json['enabled'],
      archived: json['archived'],
      targetAmount: json['targetAmount'],
      totalAmountContributed: json['totalAmountContributed'],
      title: json['title'],
      imageUrl: json['imageUrl'],
      description: json['description'],
      status: json['status'],
      audienceSize: json['audienceSize'],
      startDate: json['startDate'], //DateTime.parse(json['startDate']),
      endDate: json['endDate'], //DateTime.parse(json['endDate']),
      company: json['company'],
      creator: json['creator'],
      v: json['__v'],
      id: json['_id'],
      createdAt: json['createdAt'], // DateTime.parse(json['createdAt']),
      updatedAt: json['updatedAt'], //DateTime.parse(json['updatedAt']),
    );
  }

  // Method for JSON serialization
  Map<String, dynamic> toJson() {
    return {
      'enabled': enabled,
      'archived': archived,
      'targetAmount': targetAmount,
      'totalAmountContributed': totalAmountContributed,
      'title': title,
      'imageUrl': imageUrl,
      'description': description,
      'status': status,
      'audienceSize': audienceSize,
      'startDate': startDate,
      'endDate': endDate,
      'company': company,
      'creator': creator,
      '__v': v,
      '_id': id,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}
