import 'package:flutter/material.dart';
import 'package:my_taraji/pages/components/my_color.dart';

void main() {
  runApp(MaterialApp(
    home: ListPartenaireScreen(),
  ));
} 

class ListPartenaireScreen extends StatefulWidget {
  const ListPartenaireScreen({Key? key}) : super(key: key);

  @override
  _ListPartenaireScreenState createState() => _ListPartenaireScreenState();
}

class _ListPartenaireScreenState extends State<ListPartenaireScreen> {
  List<CardItem> allCardItems = [
    CardItem('Taraji Mobile', 'Timeless elegance meets vintage charm in ou hhhhhhhdbbdbvbb jjjjjjj hvhhbhhhhj nhjhjjjj', 'imagetaraji1', '200 XP'),
    CardItem('Taraji Store', 'Timeless elegance meets vintage charm in ou hhhhhhhdbbdbvbb jjjjjjj hvhhbhhhhj nhjhjjjj', 'imagetaraji2', '300 XP'),
    CardItem('Tunisie Télécom', 'Timeless elegance meets vintage charm in ou hhhhhhhdbbdbvbb jjjjjjj hvhhbhhhhj nhjhjjjj', 'imagetaraji3', '400 XP'),
    CardItem('Délice Danone', 'Timeless elegance meets vintage charm in ou hhhhhhdbbdbvbb jjjjjjj hvhhbhhhhj nhjhjjjj', 'imagetaraji4', '500 XP'),
    CardItem('Taraji Mobile', 'Timeless elegance meets vintage charm in ou hhhhhhhdbbdbvbb jjjjjjj hvhhbhhhhj nhjhjjjj', 'imagetaraji1', '200 XP'),
    CardItem('Taraji Store', 'Timeless elegance meets vintage charm in ou hhhhhhhdbbdbvbb jjjjjjj hvhhbhhhhj nhjhjjjj', 'imagetaraji2', '300 XP'),
    CardItem('Tunisie Télécom', 'Timeless elegance meets vintage charm in ou hhhhhhhdbbdbvbb jjjjjjj hvhhbhhhhj nhjhjjjj', 'imagetaraji3', '400 XP'),
    CardItem('Délice Danone', 'Timeless elegance meets vintage charm in ou hhhhhhhdbbdbvbb jjjjjjj hvhhbhhhhj nhjhjjjj', 'imagetaraji4', '500 XP'),
  ];

  bool showAllCards = false;

  @override
  Widget build(BuildContext context) {
    List<CardItem> displayedCards = showAllCards ? allCardItems : allCardItems.take(4).toList();

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              color: Colors.white,
              padding: EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Partenaires',
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
                        if (!showAllCards) {
                          displayedCards = allCardItems.take(4).toList();
                        }
                      });
                    },
                    child: Text(
                     showAllCards ? 'VOIR MOINS' : 'VOIR TOUT',
                      style: TextStyle(
                        color: MyColors.grey,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(16.0),
              child: GridView.builder(
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16.0,
                  mainAxisSpacing: 16.0,
                  childAspectRatio: 0.6, 
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
      ),
    );
  }

  Widget buildCard(String title, String description, String imageName, String xpText) {
    return Container(
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15.0),
          child: ListView(
            shrinkWrap: true,
            children: [
              Image.asset(
                'images/$imageName.png',
                fit: BoxFit.cover,
              ),
              SizedBox(height: 8.0),
            Padding(
  padding: const EdgeInsets.only(left: 15.0),
 child : FractionallySizedBox(
    alignment: Alignment.topLeft,
    widthFactor: 0.45,
    child: Container(
    height: 30,
     padding: EdgeInsets.only(left: 0.0, right: 0.0, top: 2.0, bottom: 2.0),
        decoration: BoxDecoration(
    color: MyColors.yellow,
    borderRadius: BorderRadius.only(
        topLeft: Radius.circular(15.0),
        topRight: Radius.circular(15.0),
        bottomLeft: Radius.circular(15.0),
        bottomRight: Radius.circular(15.0),
    ),
        ),
    child:  Align(
                  alignment: Alignment.center,
                  child: Text(
                    xpText,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize : 10
                    ),
                  ),
                ),
  ),
 ),
            ),
  
            

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8.0),
                    ExpandableText(description),
                  ],
                ),
              ),
            ],
          ),
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
class ExpandableText extends StatefulWidget {
  final String text;
  final int maxLines;

  ExpandableText(this.text, {this.maxLines = 2});

  @override
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
            ? Text(widget.text)
            : Text(
                widget.text,
                maxLines: widget.maxLines,
                overflow: TextOverflow.ellipsis,
              ),
        InkWell(
          onTap: () {
            setState(() {
              isExpanded = !isExpanded;
            });
          },
          child: Text(
            isExpanded ? 'Voir moins' : 'Voir plus',
            style: TextStyle(
              color: Colors.blue,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}




