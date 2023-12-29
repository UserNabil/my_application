import 'package:flutter/material.dart';
import 'package:my_taraji/core/models/challenge_model.dart';
import 'package:my_taraji/core/models/compaign_model.dart';
// import 'package:my_taraji/services/service_api.dart';
import 'package:my_taraji/views/home/components/challenges/challenge_carousel.dart';
// import 'package:shared_preferences/shared_preferences.dart';
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
  List<Challenge> challenges = [
    Challenge(
        imagePath: "images/pngs/imagetaraji2.png",
        title: "Gagner des coins pour la coupe d'Afrique",
        subtitle: "Subtitle for Challenge 1",
        challengeName: "Quiz Coupe d'Afrique 2024",
        coins: "100"),
    Challenge(
        imagePath: "images/pngs/imagetaraji1.png",
        title: "Gagner des cadeaux pour le réveillon",
        subtitle: "Subtitle for Challenge 2",
        challengeName: "Quiz Réveillon 2024",
        coins: "200"),
  ];

  @override
  void initState() {
    super.initState();
    _loadCampaigns();
  }

  void _loadCampaigns() async {
    List<Campaign> loadedCampaigns = await getCampaigns();
    setState(() {
      compagnes = loadedCampaigns;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> widgetsToDisplay = [
      const TopScreen(),
      ListCompagnes(campagnes: compagnes),
      ListChallenges(challenges: challenges),
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
}
