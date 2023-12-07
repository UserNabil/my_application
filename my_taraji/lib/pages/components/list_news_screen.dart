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
  bool showAllCards = false;
  List<CardItem> allCardItems = [
    CardItem(
        'Taraji Mobile',
        'Timeless elegance meets vintage charm in ou hhhhhhhdbbdbvbb jjjjjjj hvhhbhhhhj nhjhjjjj',
        'imagetaraji1',
        '200 XP'),
    CardItem(
        'Taraji Store',
        'Timeless elegance meets vintage charm in ou hhhhhhhdbbdbvbb jjjjjjj hvhhbhhhhj nhjhjjjj',
        'imagetaraji2',
        '300 XP'),
    CardItem(
        'Tunisie Télécom',
        'Timeless elegance meets vintage charm in ou hhhhhhhdbbdbvbb jjjjjjj hvhhbhhhhj nhjhjjjj',
        'imagetaraji3',
        '400 XP'),
    CardItem(
        'Délice Danone',
        'Timeless elegance meets vintage charm in ou hhhhhhdbbdbvbb jjjjjjj hvhhbhhhhj nhjhjjjj',
        'imagetaraji4',
        '500 XP'),
    CardItem(
        'Taraji Mobile',
        'Timeless elegance meets vintage charm in ou hhhhhhhdbbdbvbb jjjjjjj hvhhbhhhhj nhjhjjjj',
        'imagetaraji1',
        '200 XP'),
    CardItem(
        'Taraji Store',
        'Timeless elegance meets vintage charm in ou hhhhhhhdbbdbvbb jjjjjjj hvhhbhhhhj nhjhjjjj',
        'imagetaraji2',
        '300 XP'),
    CardItem(
        'Tunisie Télécom',
        'Timeless elegance meets vintage charm in ou hhhhhhhdbbdbvbb jjjjjjj hvhhbhhhhj nhjhjjjj',
        'imagetaraji3',
        '400 XP'),
    CardItem(
        'Délice Danone',
        'Timeless elegance meets vintage charm in ou hhhhhhhdbbdbvbb jjjjjjj hvhhbhhhhj nhjhjjjj',
        'imagetaraji4',
        '500 XP'),
  ];
  @override
  Widget build(BuildContext context) {
    //List<CardItem> displayedCards = showAllCards ? allCardItems : allCardItems.take(4).toList();

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              color: Colors.white,
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Lates News',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                      color: MyColors.yellow,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        showAllCards = !showAllCards;
                        // if (!showAllCards) {
                        //   displayedCards = allCardItems.take(4).toList();
                        // }
                      });
                    },
                    child: Text(
                      showAllCards ? 'VOIR MOINS' : 'VOIR TOUT',
                      style: const TextStyle(
                        color: MyColors.grey,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CardItem {
  final String title;
  final String description;
  final String imageName;
  final String xpText;

  CardItem(this.title, this.description, this.imageName, this.xpText);
}
