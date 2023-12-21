import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:my_taraji/core/theme/my_color.dart';
import 'compagnie_card.dart';
import 'compagnie_list.dart';

class ListCompagnes extends StatefulWidget {
  const ListCompagnes({Key? key}) : super(key: key);

  @override
  ListCompagnesState createState() => ListCompagnesState();
}

class ListCompagnesState extends State<ListCompagnes> {
  final List<Map<String, String>> newsDataList = [
    {
      'imagePath': 'images/pngs/compaigns1.jpg',
      'title': 'Gagner 200Mo de connexion internet',
      'subtitle':
          'Vous recevrez vos 200Mo directement sur votre numéro Orange et non sur JAYEG',
      'compagneName': 'Divertissement',
      'coins': '200',
    },
    {
      'imagePath': 'images/pngs/compaigns2.jpg',
      'title': 'Valider votre Email',
      'subtitle':
          'Activer votre compte et profitez de réductions sur chaque commande',
      'compagneName': 'Affaires et industrielle',
      'coins': '150',
    },
    {
      'imagePath': 'images/pngs/compaigns3.jpg',
      'title': 'Valider votre numéro de téléphone',
      'subtitle':
          'Activer votre compte et profitez de réductions sur chaque commande',
      'compagneName': 'Affaires et industrielle',
      'coins': '100',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          color: MyColors.transparent,
          padding: const EdgeInsets.all(15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Compagnes',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 20.0,
                  color: MyColors.yellow,
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AllCompagnesPage(
                        compagnes: newsDataList,
                      ),
                    ),
                  );
                },
                child: const Text(
                  'VOIR TOUS',
                  style: TextStyle(
                    backgroundColor: MyColors.transparent,
                    fontSize: 12.0,
                    fontWeight: FontWeight.w500,
                    color: MyColors.grey,
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.zero,
          child: CarouselSlider(
            options: CarouselOptions(
              // height: 195,
              enlargeCenterPage: true,
              autoPlay: true,
              autoPlayInterval: const Duration(milliseconds: 3000),
              enlargeFactor: 0.2,
            ),
            items: [
              for (final newsData in newsDataList)
                CompaignCard(
                  context: context,
                  compagneName: newsData['compagneName']!,
                  title: newsData['title']!,
                  subtitle: newsData['subtitle']!,
                  imagePath: newsData['imagePath']!,
                  coins: newsData['coins']!,
                  titleFontSize: 15.0,
                  subtitleFontSize: 12.0,
                  isLister: false,
                ),
            ],
          ),
        ),
      ],
    );
  }
}
