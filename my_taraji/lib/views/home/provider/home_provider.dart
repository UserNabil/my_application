import 'package:geolocator/geolocator.dart';
import 'package:my_taraji/core/models/user_model.dart';
import 'package:my_taraji/services/user_service.dart';
import 'package:my_taraji/views/home/import.dart';

class HomeProvider with ChangeNotifier {
  int _currentCardIndex = 1;
  final UserService userService = UserService();
  int get currentCardIndex => _currentCardIndex;

  void setCurrentCardIndex(int value) {
    _currentCardIndex = value;
    notifyListeners();
  }

  Future<UserData> getUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    UserData userData = UserData(
      id: prefs.getString('id') ?? '',
      pseudo: prefs.getString('name') ?? '',
      phone: prefs.getString('phone') ?? '',
      myRewards: MyRewards(coins: int.parse(prefs.getString('coins') ?? '0')),
      myGamification: MyGamification(
        id: prefs.getString('id') ?? '',
        expPoints: int.parse(prefs.getString('xp') ?? '0'),
        expPointsHistory: [],
        createdAt: '',
        updatedAt: '',
      ),
      iziAccount: prefs.getBool('iziAccount'),
    );

    return userData;
  }

  Future<void> setUserData() async {
    UserData userData = await getUserData();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    UserData userDataFromApi = await userService.getUserData().then((value) {
      return value.data ?? userData;
    });
    prefs.setBool('iziAccount', false);
    prefs.setString('id', userDataFromApi.id);
    prefs.setString('name', userDataFromApi.pseudo);
    prefs.setString('phone', userDataFromApi.phone);
    prefs.setString('coins', userDataFromApi.myRewards.coins.toString());
    prefs.setString('xp', userDataFromApi.myGamification.expPoints.toString());
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
    setUserData();

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
