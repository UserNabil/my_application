import 'package:flutter/material.dart';
import 'package:my_taraji/core/models/challenge_model.dart';
import 'package:my_taraji/core/models/compaign_model.dart';
import 'package:my_taraji/core/theme/my_color.dart';
import 'package:my_taraji/services/campaign_service.dart';
import 'package:my_taraji/services/challenge_service.dart';
import 'package:my_taraji/views/home/components/challenges/challenge_carousel.dart';
import 'package:my_taraji/views/home/components/all_content_home/list_campagnies_challenge.dart';
import '../components/top_content/my_top.dart';
import '../components/campagnies/compagnie_carousel.dart';
import '../components/list_news_screen.dart';
import '../components/list_partenaire_screen.dart';

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
          return const SizedBox(
            height: 100,
            child: Center(
              child: Text(
                'Erreur de connexion',
                style: TextStyle(
                  color: MyColors.red,
                  fontSize: 20,
                ),
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
