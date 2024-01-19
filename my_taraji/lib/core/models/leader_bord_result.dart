class LeaderBordResult {
  List<Rank>? ranks;
  Rank? userRank;
  Meta? meta;
  LeaderBordResult(
      {required this.ranks, required this.userRank, required this.meta});

  factory LeaderBordResult.fromJson(Map<String, dynamic> jsonApi) {
    Map<String, dynamic> json = jsonApi;
    return LeaderBordResult(
        ranks:
            List<Rank>.from(json['ranks']?.map((x) => Rank.fromMap(x)) ?? []),
        userRank: Rank.fromMap(json['userRank']),
        meta: Meta.fromMap(json['meta']));
  }

  factory LeaderBordResult.fromMap(Map<String, dynamic> map) {
    return LeaderBordResult(
        ranks: List<Rank>.from(map['ranks']?.map((x) => Rank.fromMap(x)) ?? []),
        userRank: Rank.fromMap(map['userRank']),
        meta: Meta.fromMap(map['meta']));
  }

  Map<String, dynamic> toMap() {
    return {
      'ranks': List<dynamic>.from(ranks?.map((x) => x.toMap()) ?? []),
      'userRank': userRank?.toMap(),
      'meta': meta?.toMap()
    };
  }
}

class Rank {
  String id;
  String? firstName;
  String? lastName;
  String? imageUrl;
  String pseudo;
  int score;
  int rank;
  Rank({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.imageUrl,
    required this.pseudo,
    required this.score,
    required this.rank,
  });

  factory Rank.fromMap(Map<String, dynamic> map) {
    return Rank(
        id: map['_id'],
        firstName: map['firstName'],
        lastName: map['lastName'],
        imageUrl: map['imageUrl'],
        pseudo: map['pseudo'],
        score: map['score'],
        rank: map['rank']);
  }

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'firstName': firstName,
      'lastName': lastName,
      'imageUrl': imageUrl,
      'pseudo': pseudo,
      'score': score,
      'rank': rank
    };
  }
}

class Meta {
  int total;
  int totalCount;
  int page;
  int limit;
  Meta(
      {required this.total,
      required this.totalCount,
      required this.page,
      required this.limit});

  factory Meta.fromMap(Map<String, dynamic> map) {
    return Meta(
        total: map['total'],
        totalCount: map['totalCount'],
        page: map['page'],
        limit: map['limit']);
  }

  Map<String, dynamic> toMap() {
    return {
      'total': total,
      'totalCount': totalCount,
      'page': page,
      'limit': limit
    };
  }
}
