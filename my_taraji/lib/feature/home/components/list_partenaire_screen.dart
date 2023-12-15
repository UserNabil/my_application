import 'package:flutter/material.dart';
import 'package:my_taraji/core/theme/my_color.dart';

void main() {
  runApp(const MaterialApp(
    home: ListPartenaireScreen(),
  ));
}

class ListPartenaireScreen extends StatefulWidget {
  const ListPartenaireScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _ListPartenaireScreenState createState() => _ListPartenaireScreenState();
}

class _ListPartenaireScreenState extends State<ListPartenaireScreen> {
  List<CardItem> allCardItems = [
    CardItem(
        'Taraji Mobile',
        'Timeless elegance meets vintage charm in our refined collection of flats shoes. Find the perfect pair for every occasion and style.',
        'imagetaraji1',
        '200 XP'),
    CardItem(
        'Taraji Store',
        'Timeless elegance meets vintage charm in our refined collection of flats shoes. Find the perfect pair for every occasion and style.',
        'imagetaraji2',
        '300 XP'),
    CardItem(
        'Tunisie Télécom',
        'Timeless elegance meets vintage charm in our refined collection of flats shoes. Find the perfect pair for every occasion and style.',
        'imagetaraji3',
        '400 XP'),
    CardItem(
        'Délice Danone',
        'Timeless elegance meets vintage charm in our refined collection of flats shoes. Find the perfect pair for every occasion and style.',
        'imagetaraji4',
        '500 XP'),
    CardItem(
        'Taraji Mobile',
        'Timeless elegance meets vintage charm in our refined collection of flats shoes. Find the perfect pair for every occasion and style.',
        'imagetaraji1',
        '200 XP'),
    CardItem(
        'Taraji Store',
        'Timeless elegance meets vintage charm in our refined collection of flats shoes. Find the perfect pair for every occasion and style.',
        'imagetaraji2',
        '300 XP'),
    CardItem(
        'Tunisie Télécom',
        'Timeless elegance meets vintage charm in our refined collection of flats shoes. Find the perfect pair for every occasion and style.',
        'imagetaraji3',
        '400 XP'),
    CardItem(
        'Délice Danone',
        'Timeless elegance meets vintage charm in our refined collection of flats shoes. Find the perfect pair for every occasion and style.',
        'imagetaraji4',
        '500 XP'),
  ];

  bool showAllCards = false;
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double heightRatio = 1.85;
    double calculatedHeight = screenWidth * heightRatio;
    List<CardItem> displayedCards =
        showAllCards ? allCardItems : allCardItems.take(4).toList();

    return SizedBox(
      height: showAllCards ? calculatedHeight * 1.8 : calculatedHeight,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            color: MyColors.transparent,
            padding: const EdgeInsets.all(15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Partenaires',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 20.0,
                    color: MyColors.yellow,
                  ),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      showAllCards = !showAllCards;
                      if (!showAllCards) {
                        displayedCards = allCardItems.take(4).toList();
                      }
                    });
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
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 10.0,
                childAspectRatio: 0.67,
              ),
              itemCount: displayedCards.length,
              itemBuilder: (context, index) {
                return buildCard(
                  displayedCards[index].title,
                  displayedCards[index].description,
                  displayedCards[index].imageName,
                  displayedCards[index].xpText,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget buildCard(
      String title, String description, String imageName, String xpText) {
    return Card(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(15.0),
          topRight: Radius.circular(15.0),
        ),
        child: Image.asset(
          'images/$imageName.png',
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.cover,
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 15),
        child: Container(
          width: 70,
          padding: const EdgeInsets.only(
              left: 10.0, right: 10.0, top: 2.0, bottom: 2.0),
          decoration: const BoxDecoration(
            color: MyColors.yellow,
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
          child: Align(
            alignment: Alignment.center,
            child: Text(
              xpText,
              style: const TextStyle(
                fontWeight: FontWeight.w400,
                color: Colors.black,
                fontSize: 10,
              ),
            ),
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 15),
        child: Text(
          title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 15),
        child: Text(
          description,
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontSize: 12,
          ),
        ),
      ),
    ]));
  }
}

class CardItem {
  final String title;
  final String description;
  final String imageName;
  final String xpText;

  CardItem(this.title, this.description, this.imageName, this.xpText);
}
