import 'package:my_taraji/views/init/models/address.dart';
import 'package:my_taraji/views/init/models/gamifications.dart';
import 'package:my_taraji/views/init/models/level.dart';
import 'package:my_taraji/views/init/models/rewards.dart';

class User {
  final String? id;
  final MyRewards? myRewards;
  final MyGamification? myGamification;
  final String? pseudo;
  final String? phone;
  final String? currentToken;
  final String? birthday;
  final Level? level;
  final Address? address;
  bool? wallet = false;
  bool? isIzi = false;

  User({
    required this.id,
    required this.myRewards,
    required this.myGamification,
    required this.pseudo,
    required this.phone,
    required this.currentToken,
    required this.birthday,
    required this.level,
    required this.address,
    required this.wallet,
    required this.isIzi,
  });

  factory User.fromJson(Map<String, dynamic>? json) {
    Map<String, dynamic>? jsonRewards = json?['user']?['myRewards'];
    Map<String, dynamic>? jsonGamification = json?['user']?['myGamification'];
    Map<String, dynamic>? jsonLevel = json?['user']?['level'];
    Map<String, dynamic>? jsonAddress = json?['user']?['address'];

    return User(
      id: json?['user']?['_id'] ?? json?['id'],
      currentToken: json?['user']?['currentToken'] ?? json?['currentToken'],
      myRewards: MyRewards.fromJson(jsonRewards ?? json?['myRewards'] ?? {}),
      myGamification: MyGamification.fromJson(
          jsonGamification ?? json?['myGamification'] ?? {}),
      pseudo: json?['user']?['pseudo'] ?? json?['pseudo'] ?? '',
      phone: json?['user']?['phone'] ?? json?['phone'] ?? '',
      birthday: json?['user']?['birthday'] ?? json?['birthday'] ?? '',
      level: Level.fromJson(jsonLevel ?? json?['level'] ?? {}),
      address: Address.fromJson(jsonAddress ?? json?['address'] ?? {}),
      wallet: json?['wallet'] ?? false,
      isIzi: json?['isIzi'] ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'currentToken': currentToken,
      'myRewards': myRewards?.toMap(),
      'myGamification': myGamification?.toMap(),
      'pseudo': pseudo,
      'phone': phone,
      'birthday': birthday,
      'level': level?.toMap(),
      'address': address?.toMap(),
      'wallet': wallet,
      'isIzi': isIzi,
    };
  }
}
