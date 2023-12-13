import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:my_taraji/pages/core/my_color.dart';

void main() {
  runApp(const MaterialApp(
    home: ListNewsScreen(),
  ));
}

class ListNewsScreen extends StatefulWidget {
  const ListNewsScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _ListNewsScreenState createState() => _ListNewsScreenState();
}

class _ListNewsScreenState extends State<ListNewsScreen> {
  final List<Map<String, String>> newsDataList = [
    {
      'imagePath': 'images/tarajinews1.png',
      'title':
          'L\'espérance passe au demi-final de league au final pour jouer avec Le club africain au stade rades',
      'views': '125,908 vues • 12.03.2023',
      'admin': 'Admin 1',
    },
    {
      'imagePath': 'images/imagetaraji2.png',
      'title':
          'L\'espérance passe au demi-final de league au final pour jouer avec Le club africain au stade rades',
      'views': '50,000 vues • 13.03.2023',
      'admin': 'Admin 2',
    },
    {
      'imagePath': 'images/imagetaraji1.png',
      'title':
          'L\'espérance passe au demi-final de league au final pour jouer avec Le club africain au stade rades',
      'views': '30,000 vues • 14.03.2023',
      'admin': 'Admin 3',
    },
  ];
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
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
                'Latest News',
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
          width: width,
          transform: Matrix4.translationValues(-width / 25, 0, 0),
          child: buildCarousel(),
        ),
      ],
    );
  }

  Widget buildCarouselItem(
      String imagePath, String title, String views, String admin) {
    return Row(
      children: [
        Container(
          margin: const EdgeInsets.only(left: 30.0, right: 10.0),
          width: 140.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            image: DecorationImage(
              image: AssetImage(imagePath),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                title,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style: const TextStyle(
                  fontSize: 15.0,
                  fontWeight: FontWeight.w600,
                  color: MyColors.red,
                ),
              ),
              const SizedBox(height: 6.0),
              Text(
                views,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 12.0, color: MyColors.grey),
              ),
              const SizedBox(height: 6.0),
              Text(
                admin,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 13.0, color: MyColors.grey),
              ),
            ],
          ),
        )
      ],
    );
  }

  CarouselSlider buildCarousel() {
    return CarouselSlider(
      options: CarouselOptions(
        aspectRatio: double.infinity,
        height: 100.0,
        enlargeCenterPage: false,
        autoPlay: true,
        autoPlayInterval: const Duration(milliseconds: 3000),
        viewportFraction: 0.95,
      ),
      items: [
        for (final newsData in newsDataList)
          buildCarouselItem(
            newsData['imagePath']!,
            newsData['title']!,
            newsData['views']!,
            newsData['admin']!,
          ),
      ],
    );
  }
}
