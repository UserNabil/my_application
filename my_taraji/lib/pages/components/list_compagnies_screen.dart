import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:my_taraji/pages/components/my_color.dart';

void main() {
  runApp(const MaterialApp(
    home: ListCompagnesScreen(),
  ));
}

class ListCompagnesScreen extends StatefulWidget {
  const ListCompagnesScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _ListCompagnesScreenState createState() => _ListCompagnesScreenState();
}

class _ListCompagnesScreenState extends State<ListCompagnesScreen> {
  final List<Map<String, String>> newsDataList = [
    {
      'imagePath': 'images/tarajinews1.png',
      'title': 'Economisez votre argent sur chaque commande!',
      'subtitle':
          'Accumulez des points sur chaque commande et profitez de réductions',
      'compagneName': 'Compagne Taraji Store'
    },
    {
      'imagePath': 'images/imagetaraji2.png',
      'title': 'Economisez votre argent sur chaque commande!',
      'subtitle':
          'Accumulez des points sur chaque commande et profitez de réductions',
      'compagneName': 'Compagne Taraji Store'
    },
    {
      'imagePath': 'images/imagetaraji1.png',
      'title': 'Economisez votre argent sur chaque commande!',
      'subtitle':
          'Accumulez des points sur chaque commande et profitez de réductions',
      'compagneName': 'Compagne Taraji Store'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          double calculatedHeight = constraints.maxWidth * 0.6;
          double titleFontSize = constraints.maxWidth * 0.05;
          double subtitleFontSize = constraints.maxWidth * 0.035;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                color: Colors.white,
                padding:
                    const EdgeInsets.only(top: 9.0, left: 15.0, bottom: 15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Compagnes',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: titleFontSize,
                        color: MyColors.yellow,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {});
                      },
                      child: Text(
                        'VOIR TOUS',
                        style: TextStyle(
                          fontSize: subtitleFontSize,
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
                    height: calculatedHeight,
                    enlargeCenterPage: true,
                    autoPlay: true,
                    autoPlayInterval: const Duration(milliseconds: 3000),
                  ),
                  items: [
                    for (final newsData in newsDataList)
                      buildCarouselItem(
                        newsData['imagePath']!,
                        newsData['title']!,
                        newsData['subtitle']!,
                        newsData['compagneName']!,
                        titleFontSize,
                        subtitleFontSize,
                      ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget buildCarouselItem(
    String imagePath,
    String title,
    String subtitle,
    String comagneName,
    double titleFontSize,
    double subtitleFontSize,
  ) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          margin: const EdgeInsets.symmetric(horizontal: 5.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            image: DecorationImage(
              image: AssetImage(imagePath),
              fit: BoxFit.cover,
            ),
          ),
          child: Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  Colors.black.withOpacity(0.7),
                ],
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FractionallySizedBox(
                  alignment: Alignment.topLeft,
                  widthFactor: 0.5,
                  child: Container(
                    height: 30,
                    padding: const EdgeInsets.all(8.0),
                    decoration: const BoxDecoration(
                      color: MyColors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15.0),
                        topRight: Radius.circular(15.0),
                        bottomLeft: Radius.circular(15.0),
                        bottomRight: Radius.circular(15.0),
                      ),
                    ),
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        comagneName,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 25.0),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: titleFontSize,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8.0),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: subtitleFontSize,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
