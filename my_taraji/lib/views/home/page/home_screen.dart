import 'package:flutter/material.dart';
import 'package:my_taraji/core/models/challenge_model.dart';
import 'package:my_taraji/core/models/compaign_model.dart';
import 'package:my_taraji/services/service_api.dart';
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

  Future<void> onInitData() async {
    String baseUrl = 'http://localhost:5074';
    var apiService = ApiService(baseUrl);

    try {
      final List<Campaign> campaigns = await apiService
          .getAllCampaigns('api/v1/campaigns/targetedAudience?Page=0&Limit=10');

      if (mounted) {
        setState(() {
          compagnes = campaigns;
        });
      }

      saveCampaigns(campaigns);
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    onInitData();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> widgetsToDisplay = [
      const TopScreen(),
      ListCompagnes(compagnes: compagnes),
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
