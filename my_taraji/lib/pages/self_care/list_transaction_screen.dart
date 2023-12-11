import 'package:flutter/material.dart';
import 'package:my_taraji/pages/components/my_color.dart';

void main() {
  runApp(const MaterialApp(
    home: ListTransactionScreen(),
  ));
}

class ListTransactionScreen extends StatefulWidget {
  const ListTransactionScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _ListTransactionScreenState createState() => _ListTransactionScreenState();
}

class _ListTransactionScreenState extends State<ListTransactionScreen> {
  // Sample data for cards
  List<Map<String, String>> cardData = [
    {
      'imageName': 'Recharge',
      'title': 'Taraji Store',
      'description': '3:02 PM . Aug 22,2022',
      'xpText': 'XP : +300',
      'coin': 'COINS : -1000 DT'
    },
    {
      'imageName': 'Paypal',
      'title': 'Recharge',
      'description': '15:02 PM . Aug 02,2022',
      'xpText': 'XP : +100',
      'coin': 'COINS : -10.000 DT'
    },
    {
      'imageName': 'Don',
      'title': 'Don',
      'description': '18:12 PM . Juin, 15,2022',
      'xpText': 'XP : +200',
      'coin': 'COINS : -15.000 DT'
    },
    {
      'imageName': 'transfer',
      'title': 'Transfer',
      'description': '11:26 PM . Mai 12,2022',
      'xpText': 'XP : +500',
      'coin': 'COINS : -20.000 DT'
    },
    {
      'imageName': 'Recharge',
      'title': 'Taraji Store',
      'description': '3:02 PM . Aug 22,2022',
      'xpText': 'XP : +300',
      'coin': 'COINS : -1000 DT'
    },
    {
      'imageName': 'Paypal',
      'title': 'Recharge',
      'description': '15:02 PM . Aug 02,2022',
      'xpText': 'XP : +100',
      'coin': 'COINS : -10.000 DT'
    },
    {
      'imageName': 'Don',
      'title': 'Don',
      'description': '18:12 PM . Juin, 15,2022',
      'xpText': 'XP : +200',
      'coin': 'COINS : -15.000 DT'
    },
    {
      'imageName': 'transfer',
      'title': 'Transfer',
      'description': '11:26 PM . Mai 12,2022',
      'xpText': 'XP : +500',
      'coin': 'COINS : -20.000 DT'
    },
    {
      'imageName': 'Recharge',
      'title': 'Taraji Store',
      'description': '3:02 PM . Aug 22,2022',
      'xpText': 'XP : +300',
      'coin': 'COINS : -1000 DT'
    },
    {
      'imageName': 'Paypal',
      'title': 'Recharge',
      'description': '15:02 PM . Aug 02,2022',
      'xpText': 'XP : +100',
      'coin': 'COINS : -10.000 DT'
    },
    {
      'imageName': 'Don',
      'title': 'Don',
      'description': '18:12 PM . Juin, 15,2022',
      'xpText': 'XP : +200',
      'coin': 'COINS : -15.000 DT'
    },
    {
      'imageName': 'transfer',
      'title': 'Transfer',
      'description': '11:26 PM . Mai 12,2022',
      'xpText': 'XP : +500',
      'coin': 'COINS : -20.000 DT'
    },
    // Add more data as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
              color: Colors.white,
              padding:
                  const EdgeInsets.only(top: 9.0, left: 15.0, bottom: 15.0),
              child: const Text(
                'Mes Transactions',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                  color: MyColors.black,
                ),
              )),
          Expanded(
            child: Container(
              margin: EdgeInsets.zero,
              child: ListView.builder(
                itemCount: cardData.length,
                itemBuilder: (context, index) {
                  return buildCard(
                    cardData[index]['imageName']!,
                    cardData[index]['title']!,
                    cardData[index]['description']!,
                    cardData[index]['xpText']!,
                    cardData[index]['coin']!,
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildCard(String imageName, String title, String description,
      String xpText, String coin) {
    return Card(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            // Section 1: Image (Replace 'Image.network' with your image source)
            Image.asset(
              'images/$imageName.png',
              fit: BoxFit.cover,
            ),
            const SizedBox(width: 8.0),
            // Section 2: Text 1
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
                Text(description),
              ],
            ),
            // Section 3: Text 2
            const Spacer(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  xpText,
                  style: const TextStyle(
                    //fontWeight: FontWeight.bold,
                    fontSize: 12.0,
                    color: Colors.green,
                  ),
                ),
                Text(
                    style: const TextStyle(
                      //fontWeight: FontWeight.bold,
                      fontSize: 12.0,
                      color: Colors.red,
                    ),
                    coin),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
