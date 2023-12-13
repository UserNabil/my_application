import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:my_taraji/pages/core/my_color.dart';

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
                  setState(() {});
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
              height: 195,
              enlargeCenterPage: true,
              autoPlay: false,
              autoPlayInterval: const Duration(milliseconds: 3000),
              enlargeFactor: 0.2,
            ),
            items: [
              for (final newsData in newsDataList)
                buildCarouselItem(
                  newsData['imagePath']!,
                  newsData['title']!,
                  newsData['subtitle']!,
                  newsData['compagneName']!,
                  13,
                  10,
                ),
            ],
          ),
        ),
      ],
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
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5.0),
      constraints: const BoxConstraints.expand(),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        image: DecorationImage(
          image: AssetImage(imagePath),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        width: 100,
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          gradient: LinearGradient(
            begin: Alignment.centerRight,
            end: Alignment.centerLeft,
            colors: [
              MyColors.red.withOpacity(0.3),
              MyColors.red,
            ],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              padding:
                  const EdgeInsets.only(left: 20, right: 20, top: 5, bottom: 5),
              decoration: const BoxDecoration(
                color: MyColors.white,
                borderRadius: BorderRadius.all(Radius.circular(50.0)),
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
            SizedBox(
              width: 150,
              child: Text(
                title,
                overflow: TextOverflow.ellipsis,
                maxLines: 3,
                style: TextStyle(
                  fontSize: titleFontSize,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(
              width: 150,
              child: Text(
                subtitle,
                overflow: TextOverflow.ellipsis,
                maxLines: 3,
                style: TextStyle(
                  fontSize: subtitleFontSize,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
