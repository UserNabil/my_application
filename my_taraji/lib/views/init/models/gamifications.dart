class MyGamification {
  final int expPoints;

  MyGamification({
    required this.expPoints,
  });

  factory MyGamification.fromJson(Map<String, dynamic>? json) {
    return MyGamification(
      expPoints: json?['expPoints'] ?? 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'expPoints': expPoints,
    };
  }
}
