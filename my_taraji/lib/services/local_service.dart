import 'dart:io';

import 'package:geolocator/geolocator.dart';
import 'package:my_taraji/core/models/all_content.dart';
import 'package:my_taraji/core/models/challenge_model.dart';
import 'package:my_taraji/core/models/compaign_model.dart';
import 'package:my_taraji/core/models/user_model.dart';
import 'package:my_taraji/services/campaign_service.dart';
import 'package:my_taraji/services/challenge_service.dart';
import 'package:my_taraji/services/user_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalService {
  LocalService();

  getCurrentLocation() async {
    final GeolocatorPlatform geolocator = GeolocatorPlatform.instance;
    SharedPreferences prefs = await SharedPreferences.getInstance();

    try {
      LocationSettings locationSettings =
          const LocationSettings(accuracy: LocationAccuracy.high);
      Position position = await geolocator.getCurrentPosition(
          locationSettings: locationSettings);

      prefs.setDouble('latitude', position.latitude);
      prefs.setDouble('longitude', position.longitude);
    } catch (e) {
      throw Exception('getCurrentLocation error : $e');
    }
  }

  getUserData() async {
    UserService userService = UserService();
    try {
      UserData userData =
          await userService.getUserData().then((value) => value.data!);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('id', userData.id);
      prefs.setString('coins', userData.myRewards.coins.toString());
      prefs.setString('name', userData.pseudo);
      prefs.setString('xp', userData.myGamification.expPoints.toString());
      prefs.setString('phone', userData.phone);
    } catch (e) {
      if (exitCode == 400) {
      } else {}
    }
  }

  Future<AllDataContent> loadCampaigns() async {
    var challengeService = ChallengeService();
    var campaignService = CampaignService();
    List<Campaign> loadedCampaigns = await campaignService
        .getAllCampaigns()
        .then((value) => value.data ?? []);
    List<Challenge> loadedChallenges = await challengeService
        .getAllChallenges()
        .then((value) => value.data ?? []);

    SharedPreferences prefs = await SharedPreferences.getInstance();
    for (var campaign in loadedCampaigns) {
      prefs.setBool(campaign.id, true);
    }
    saveCampaigns(loadedCampaigns);
    saveChallenges(loadedChallenges);

    AllDataContent allContent = AllDataContent(
      campagnes: loadedCampaigns,
      challenges: loadedChallenges,
    );
    return allContent;
  }
}
