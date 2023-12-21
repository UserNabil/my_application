import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/theme/my_color.dart';

class ListCommande extends StatefulWidget {
  const ListCommande({Key? key}) : super(key: key);

  @override
  ListCommandeState createState() => ListCommandeState();
}

class ListCommandeState extends State<ListCommande> {
  List<Map<String, String>> cardData = [
    {
      'imageName': 'commandeicon',
      'title': '120,07 DT',
      'description': 'TOTAL : 4 ARTICLES',
      'numCommande': 'N°10309876532568',
      'date': 'Nov 22,2023',
      'etat': 'Expédiée'
    },
    {
      'imageName': 'commandeicon',
      'title': '202,43 DT',
      'description': 'TOTAL : 2 ARTICLES',
      'numCommande': 'N°10309876532563',
      'date': 'Sep 11,2023',
      'etat': 'Livrée'
    },
    {
      'imageName': 'commandeicon',
      'title': '114,90 DT',
      'description': 'TOTAL : 2 ARTICLES',
      'numCommande': 'N°10309876532565',
      'date': 'Aout 02,2023',
      'etat': 'Annulée'
    },
    {
      'imageName': 'commandeicon',
      'title': '136,07 DT',
      'description': 'TOTAL : 3 ARTICLES',
      'numCommande': 'N°10309876532564',
      'date': 'Juil 22,2023',
      'etat': 'Livrée'
    },
    {
      'imageName': 'commandeicon',
      'title': '200,65 DT',
      'description': 'TOTAL : 4 ARTICLES',
      'numCommande': 'N°10309876532565',
      'date': 'Juin 12,2023',
      'etat': 'Livrée'
    },
    {
      'imageName': 'commandeicon',
      'title': '50,00 DT',
      'description': 'TOTAL : 2 ARTICLES',
      'numCommande': 'N°10309876532562',
      'date': 'Juin 12,2023',
      'etat': 'Annulée'
    },
    {
      'imageName': 'commandeicon',
      'title': '136,07 DT',
      'description': 'TOTAL : 3 ARTICLES',
      'numCommande': 'N°10309876532564',
      'date': 'Juil 22,2023',
      'etat': 'Livrée'
    },
    {
      'imageName': 'commandeicon',
      'title': '200,65 DT',
      'description': 'TOTAL : 4 ARTICLES',
      'numCommande': 'N°10309876532567',
      'date': 'Juin 12,2023',
      'etat': 'Livrée'
    },
    {
      'imageName': 'commandeicon',
      'title': '50,00 DT',
      'description': 'TOTAL : 2 ARTICLES',
      'numCommande': 'N°10309876532563',
      'date': 'Juin 12,2023',
      'etat': 'Annulée'
    }
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
              'Mes Commandes',
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
              cardData[index]['numCommande']!,
              cardData[index]['date']!,
              cardData[index]['etat']!,
            );
          },
        ),
      ],
    );
  }

  Widget buildCard(String imageName, String title, String description,
      String numCommande, String date, String etat) {
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
                  description,
                  style: const TextStyle(
                    fontSize: 10.0,
                    color: Colors.grey,
                  ),
                ),
                Text(
                  numCommande,
                  style: const TextStyle(
                    fontSize: 10.0,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            const Spacer(),
            Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      date,
                      style: const TextStyle(
                        fontSize: 13.0,
                        color: Colors.green,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const SizedBox(width: 18.0),
                    Text(
                        style: const TextStyle(
                          fontSize: 13.0,
                          color: Colors.red,
                          fontWeight: FontWeight.w500,
                        ),
                        etat),
                  ],
                ),
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
