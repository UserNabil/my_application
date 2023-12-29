import 'package:flutter/material.dart';
import 'package:my_taraji/core/models/challenge_model.dart';
import 'package:my_taraji/core/models/compaign_model.dart';
import 'package:my_taraji/views/home/components/challenges/challenge_carousel.dart';
import '../components/top_content/my_top.dart';
import '../components/compagnies/compagnie_carousel.dart';
import '../components/list_news_screen.dart';
import '../components/list_partenaire_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  static const routeName = '/home';

  @override
  Widget build(BuildContext context) {
    List<Campaign> compagnes = [
      // Campaign(
      //   id: '1',
      //   imagePath: 'images/pngs/compaigns1.jpg',
      //   title: 'Gagner 200Mo de connexion internet',
      //   subtitle:
      //       'Vous recevrez vos 200Mo directement sur votre numéro Orange et non sur JAYEG',
      //   description: '',
      //   coins: "200",
      //   compagneName: 'Divertissement',
      // ),
      // Campaign(
      //   id: '2',
      //   imagePath: 'images/pngs/compaigns2.jpg',
      //   title: 'Valider votre Email',
      //   subtitle:
      //       'Activer votre compte et profitez de réductions sur chaque commande',
      //   description: '',
      //   coins: "150",
      //   compagneName: 'Affaires et industrielle',
      // ),
      // Campaign(
      //   id: '3',
      //   imagePath: 'images/pngs/compaigns3.jpg',
      //   title: 'Valider votre numéro de téléphone',
      //   subtitle:
      //       'Activer votre compte et profitez de réductions sur chaque commande',
      //   description: '',
      //   coins: "100",
      //   compagneName: 'Affaires et industrielle',
      // )
    ];
    List<Challenge> challenges = [
      Challenge(
          imagePath: "images/pngs/imagetaraji2.png",
          title: "Challenge Jeu Coin",
          subtitle: "Subtitle for Challenge 1",
          challengeName: "Challenge Jeu Coin",
          coins: "100"),
      Challenge(
          imagePath: "images/pngs/imagetaraji1.png",
          title: "Challenge 2",
          subtitle: "Subtitle for Challenge 2",
          challengeName: "Challenge 2 Name",
          coins: "100"),
    ];
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
