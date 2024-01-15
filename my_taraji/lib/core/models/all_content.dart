import 'package:my_taraji/core/models/challenge_model.dart';
import 'package:my_taraji/core/models/compaign_model.dart';

class AllDataContent {
  final List<Campaign> campagnes;
  final List<Challenge> challenges;
  AllDataContent({required this.campagnes, required this.challenges});
}
