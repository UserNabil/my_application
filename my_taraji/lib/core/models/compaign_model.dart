class Campaign {
  String id;
  String imageUri;
  String description;
  int score;
  String theme;

  Campaign({
    required this.id,
    required this.imageUri,
    required this.description,
    required this.score,
    required this.theme,
  });

  factory Campaign.fromMap(Map<String, dynamic> map) {
    return Campaign(
      id: map['_id'],
      imageUri: map['imageUrl'],
      description: map['description'],
      score: map['reward']?['coins'] ?? map['reward'],
      theme: (map['tag'] as List<dynamic>?)?.isNotEmpty ?? false
          ? map['tag'][0]
          : '',
    );
  }
}
