import '../import.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static const routeName = '/home';

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  Future<AllDataContent> _loadCampaigns() async {
    var challengeService = ChallengeService();
    var campaignService = CampaignService();
    List<Campaign> loadedCampaigns = await campaignService.getAllCampaigns();
    List<Challenge> loadedChallenges =
        await challengeService.getAllChallenges();

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

  @override
  Widget build(BuildContext context) {
    List<Widget> widgetsToDisplay = [
      const TopScreen(),
      selectContent(context),
      const ListNews(),
      const ListPartenaire(),
    ];

    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: widgetsToDisplay.length,
                  itemBuilder: (context, index) {
                    return widgetsToDisplay[index];
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget selectContent(BuildContext context) {
    return FutureBuilder(
      future: _loadCampaigns(),
      builder: (context, AsyncSnapshot<AllDataContent> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SizedBox(
            height: 100,
            child: Center(
              child: CircularProgressIndicator(
                color: MyColors.yellow,
              ),
            ),
          );
        }

        if (snapshot.hasError) {
          return SizedBox(
            height: 100,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: MyColors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                    onPressed: () {
                      setState(() {});
                    },
                    child: const Icon(
                      TablerIcons.refresh,
                      color: MyColors.red,
                    ),
                  ),
                ],
              ),
            ),
          );
        }

        AllDataContent allDataContent = snapshot.data!;
        if (allDataContent.campagnes.isNotEmpty &&
            allDataContent.challenges.isNotEmpty) {
          return AllContent(
            campagnes: allDataContent.campagnes,
            challenges: allDataContent.challenges,
          );
        } else {
          return Column(
            children: [
              ListCarouselCompagnes(campagnes: allDataContent.campagnes),
              ListCarouselChallenges(challenges: allDataContent.challenges),
            ],
          );
        }
      },
    );
  }
}

class AllDataContent {
  final List<Campaign> campagnes;
  final List<Challenge> challenges;
  AllDataContent({required this.campagnes, required this.challenges});
}
