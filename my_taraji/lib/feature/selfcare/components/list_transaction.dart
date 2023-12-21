import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../core/theme/my_color.dart';

class ListTransaction extends StatefulWidget {
  const ListTransaction({Key? key}) : super(key: key);

  @override
  ListTransactionState createState() => ListTransactionState();
}

class ListTransactionState extends State<ListTransaction> {
  List<Map<String, String>> cardData = [
    {
      'imageName': 'Recharge',
      'title': 'Taraji Store',
      'description': '3:02 PM • Aug 22,2022',
      'xpText': 'XP : +300',
      'coin': 'COINS : -1000 DT'
    },
    {
      'imageName': 'Paypal',
      'title': 'Recharge',
      'description': '15:02 PM • Aug 02,2022',
      'xpText': 'XP : +100',
      'coin': 'COINS : -10.000 DT'
    },
    {
      'imageName': 'Don',
      'title': 'Don',
      'description': '18:12 PM • Juin, 15,2022',
      'xpText': 'XP : +200',
      'coin': 'COINS : -15.000 DT'
    },
    {
      'imageName': 'transfer',
      'title': 'Transfer',
      'description': '11:26 PM • Mai 12,2022',
      'xpText': 'XP : +500',
      'coin': 'COINS : -20.000 DT'
    },
    {
      'imageName': 'Recharge',
      'title': 'Taraji Store',
      'description': '3:02 PM • Aug 22,2022',
      'xpText': 'XP : +300',
      'coin': 'COINS : -1000 DT'
    },
    {
      'imageName': 'Paypal',
      'title': 'Recharge',
      'description': '15:02 PM • Aug 02,2022',
      'xpText': 'XP : +100',
      'coin': 'COINS : -10.000 DT'
    },
    {
      'imageName': 'Don',
      'title': 'Don',
      'description': '18:12 PM • Juin, 15,2022',
      'xpText': 'XP : +200',
      'coin': 'COINS : -15.000 DT'
    },
    {
      'imageName': 'transfer',
      'title': 'Transfer',
      'description': '11:26 PM • Mai 12,2022',
      'xpText': 'XP : +500',
      'coin': 'COINS : -20.000 DT'
    },
    {
      'imageName': 'Recharge',
      'title': 'Taraji Store',
      'description': '3:02 PM • Aug 22,2022',
      'xpText': 'XP : +300',
      'coin': 'COINS : -1000 DT'
    },
    {
      'imageName': 'Paypal',
      'title': 'Recharge',
      'description': '15:02 PM • Aug 02,2022',
      'xpText': 'XP : +100',
      'coin': 'COINS : -10.000 DT'
    },
    {
      'imageName': 'Don',
      'title': 'Don',
      'description': '18:12 PM • Juin, 15,2022',
      'xpText': 'XP : +200',
      'coin': 'COINS : -15.000 DT'
    },
    {
      'imageName': 'transfer',
      'title': 'Transfer',
      'description': '11:26 PM • Mai 12,2022',
      'xpText': 'XP : +500',
      'coin': 'COINS : -20.000 DT'
    },
    // Add more data as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 20),
        SvgPicture.asset(
          'images/icons/drag.svg',
          height: 5,
          width: 5,
        ),
        const SizedBox(height: 20),
        const Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Mes Transactions',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
                color: MyColors.black,
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: cardData.length,
          padding: const EdgeInsets.all(8.0),
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
      ],
    );
  }

  Widget buildCard(String imageName, String title, String description,
      String xpText, String coin) {
    return Column(
      children: [
        Row(
          children: [
            Image.asset(
              'images/pngs/$imageName.png',
              fit: BoxFit.cover,
            ),
            const SizedBox(width: 8.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 15.0,
                  ),
                ),
                Text(
                    style: const TextStyle(
                      fontSize: 10.0,
                      color: Colors.grey,
                    ),
                    description),
              ],
            ),
            const Spacer(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  xpText,
                  style: const TextStyle(
                    fontSize: 13.0,
                    color: Colors.green,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                    style: const TextStyle(
                      fontSize: 13.0,
                      color: Colors.red,
                      fontWeight: FontWeight.w500,
                    ),
                    coin),
              ],
            ),
          ],
        ),
        const SizedBox(
          height: 40.0,
          child: Divider(
            color: MyColors.grey,
            thickness: .3,
          ),
        ),
      ],
    );
  }
}
