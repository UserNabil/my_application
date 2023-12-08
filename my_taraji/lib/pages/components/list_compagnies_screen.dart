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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              color: Colors.white,
              padding:
                  const EdgeInsets.only(top: 9.0, left: 15.0, bottom: 15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Compagnes',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                      color: MyColors.yellow,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {});
                    },
                    child: const Text(
                      'VOIR TOUS',
                      style: TextStyle(
                        color: MyColors.grey,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.zero,
              height: 200.0,
              child: CarouselSlider(
                options: CarouselOptions(
                  height: 200.0,
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
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildCarouselItem(
      String imagePath, String title, String subtitle, String comagneName) {
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
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  FractionallySizedBox(
                    alignment: Alignment.topLeft,
                    widthFactor: 0.6,
                    child: Container(
                      height: 30,
                      padding: const EdgeInsets.only(
                        left: 0.0,
                        right: 0.0,
                        top: 0.0,
                        bottom: 0.0,
                      ),
                      decoration: const BoxDecoration(
                        color: MyColors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15.0),
                          topRight: Radius.circular(15.0),
                          bottomLeft: Radius.circular(15.0),
                          bottomRight: Radius.circular(15.0),
                        ),
                      ),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          comagneName,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 25.0),
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 14.0,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
