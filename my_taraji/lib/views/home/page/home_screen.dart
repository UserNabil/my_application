import 'package:flutter/material.dart';
import 'package:my_taraji/core/models/challenge_model.dart';
import 'package:my_taraji/core/models/compaign_model.dart';
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
  late List<Campaign> compagnes = [];
  late List<Challenge> challenges = [];

  @override
  void initState() {
    super.initState();
    _loadCampaigns();
  }

  void _loadCampaigns() async {
    List<Campaign> loadedCampaigns = await getCampaigns();
    List<Challenge> loadedChallenges = await getChallenges();

    setState(() {
      compagnes = loadedCampaigns;
      challenges = loadedChallenges;
    });
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
    if (compagnes.isNotEmpty && challenges.isNotEmpty) {
      return AllContent(
        campagnes: compagnes,
        challenges: challenges,
      );
    } else {
      return Column(
        children: [
          if (compagnes.isNotEmpty) ListCompagnes(campagnes: compagnes),
          if (challenges.isNotEmpty) ListChallenges(challenges: challenges),
        ],
      );
    }
  }
}
