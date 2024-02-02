import 'dart:convert';

import 'package:geolocator/geolocator.dart';
import 'package:my_taraji/views/init/models/user.dart';
import 'package:my_taraji/services/user_service.dart';
import 'package:my_taraji/views/home/import.dart';

class HomeProvider with ChangeNotifier {
  int _currentCardIndex = 0;
  UserService userService = UserService();
  int get currentCardIndex => _currentCardIndex;

  void setCurrentCardIndex(int value) {
    // _currentCardIndex = value;
    notifyListeners();
  }

// Mohamed Ben Halima récupération des données de l'utilisateur
  Future<User?> getUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    const key = 'user';

    final value = prefs.getString(key);
    // if (value == null) {
    //   return null;
    // }

    Map<String, dynamic> userDataMap = jsonDecode(value ?? '') ?? {};

    User userData = User.fromJson(userDataMap);
    return userData;
  }

  Future<void> setUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    const key = 'user';
    await userService.getUserData().then((value) {
      if (value.isSuccess == false) {
        getUserData().then((value) {
          if (value == null) {
            return;
          }
          prefs.setString(key, jsonEncode(value.toMap()));
        });
      } else {
        prefs.setString(key, jsonEncode(value.data?.toMap()));
      }
    });
  }

  setCurrentLocation() async {
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

  void init() {
    _currentCardIndex = 0;
    notifyListeners();
  }
}
