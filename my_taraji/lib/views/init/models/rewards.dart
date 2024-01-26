class MyRewards {
  final int coins;

  MyRewards({
    required this.coins,
  });

  factory MyRewards.fromJson(Map<String, dynamic>? json) {
    return MyRewards(
      coins: json?['coins'] ?? 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'coins': coins,
    };
  }
}
