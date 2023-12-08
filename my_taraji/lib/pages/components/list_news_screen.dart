import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:my_taraji/pages/components/my_color.dart';

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
      'views': '125,908 vues . 12.03.2023',
      'admin': 'Admin 1',
    },
    {
      'imagePath': 'images/imagetaraji2.png',
      'title':
          'L\'espérance passe au demi-final de league au final pour jouer avec Le club africain au stade rades',
      'views': '50,000 vues . 13.03.2023',
      'admin': 'Admin 2',
    },
    {
      'imagePath': 'images/imagetaraji1.png',
      'title':
          'L\'espérance passe au demi-final de league au final pour jouer avec Le club africain au stade rades',
      'views': '30,000 vues . 14.03.2023',
      'admin': 'Admin 3',
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
              padding: const EdgeInsets.only(top: 9.0, left: 15.0, bottom: 0.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Latest News',
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
                      'VOIR TOUT',
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
              //  padding: const EdgeInsets.only(top: 0.0, left: 15.0, bottom: 0.0),
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
                      newsData['views']!,
                      newsData['admin']!,
                    ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildCarouselItem(
      String imagePath, String title, String views, String admin) {
    return Row(
      children: [
        // Section 1 : Contient une image
        Container(
          margin: EdgeInsets.zero,
          width: 140.0,
          height: 100.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            image: DecorationImage(
              image: AssetImage(imagePath),
              fit: BoxFit.cover,
            ),
          ),
        ),
        // Section 2 : Contient du texte
        Expanded(
          child: Container(
            width: 250.0,
            height: 100.0,
            padding: const EdgeInsets.only(left: 9.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ExpandableText(
                  title,
                  textStyle: const TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold,
                    color: MyColors.blue,
                  ),
                ),
                const SizedBox(height: 6.0),
                Text(
                  views,
                  style: const TextStyle(fontSize: 12.0, color: MyColors.grey),
                ),
                const SizedBox(height: 6.0),
                Text(
                  admin,
                  style: const TextStyle(fontSize: 13.0, color: MyColors.grey),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}

class ExpandableText extends StatefulWidget {
  final String text;
  final int maxLines;
  final TextStyle textStyle;

  const ExpandableText(this.text,
      {Key? key, this.maxLines = 2, this.textStyle = const TextStyle()})
      : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _ExpandableTextState createState() => _ExpandableTextState();
}

class _ExpandableTextState extends State<ExpandableText> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        isExpanded
            ? Text(widget.text, style: widget.textStyle)
            : Text(
                widget.text,
                maxLines: widget.maxLines,
                overflow: TextOverflow.ellipsis,
                style: widget.textStyle,
              ),
      ],
    );
  }
}
