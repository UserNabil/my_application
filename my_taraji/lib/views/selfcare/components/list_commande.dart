import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_taraji/core/assets/images_svg.dart';
import 'package:my_taraji/views/selfcare/models/fakedata.dart';

import '../../../core/theme/my_color.dart';

class ListCommande extends StatelessWidget {
  const ListCommande({super.key});

  // buildContent(BuildContext context) {
  //   List<Map<String, String>> cardData = [
  //     {
  //       'imageName': 'commandeicon',
  //       'title': '120,07 DT',
  //       'description': 'TOTAL : 4 ARTICLES',
  //       'numCommande': 'N°10309876532568',
  //       'date': 'Nov 22,2023',
  //       'etat': 'Expédiée'
  //     },
  //     {
  //       'imageName': 'commandeicon',
  //       'title': '202,43 DT',
  //       'description': 'TOTAL : 2 ARTICLES',
  //       'numCommande': 'N°10309876532563',
  //       'date': 'Sep 11,2023',
  //       'etat': 'Livrée'
  //     },
  //     {
  //       'imageName': 'commandeicon',
  //       'title': '114,90 DT',
  //       'description': 'TOTAL : 2 ARTICLES',
  //       'numCommande': 'N°10309876532565',
  //       'date': 'Aout 02,2023',
  //       'etat': 'Annulée'
  //     },
  //     {
  //       'imageName': 'commandeicon',
  //       'title': '136,07 DT',
  //       'description': 'TOTAL : 3 ARTICLES',
  //       'numCommande': 'N°10309876532564',
  //       'date': 'Juil 22,2023',
  //       'etat': 'Livrée'
  //     },
  //     {
  //       'imageName': 'commandeicon',
  //       'title': '200,65 DT',
  //       'description': 'TOTAL : 4 ARTICLES',
  //       'numCommande': 'N°10309876532565',
  //       'date': 'Juin 12,2023',
  //       'etat': 'Livrée'
  //     },
  //     {
  //       'imageName': 'commandeicon',
  //       'title': '50,00 DT',
  //       'description': 'TOTAL : 2 ARTICLES',
  //       'numCommande': 'N°10309876532562',
  //       'date': 'Juin 12,2023',
  //       'etat': 'Annulée'
  //     },
  //     {
  //       'imageName': 'commandeicon',
  //       'title': '136,07 DT',
  //       'description': 'TOTAL : 3 ARTICLES',
  //       'numCommande': 'N°10309876532564',
  //       'date': 'Juil 22,2023',
  //       'etat': 'Livrée'
  //     },
  //     {
  //       'imageName': 'commandeicon',
  //       'title': '200,65 DT',
  //       'description': 'TOTAL : 4 ARTICLES',
  //       'numCommande': 'N°10309876532567',
  //       'date': 'Juin 12,2023',
  //       'etat': 'Livrée'
  //     },
  //     {
  //       'imageName': 'commandeicon',
  //       'title': '50,00 DT',
  //       'description': 'TOTAL : 2 ARTICLES',
  //       'numCommande': 'N°10309876532563',
  //       'date': 'Juin 12,2023',
  //       'etat': 'Annulée'
  //     }
  //   ];
  //   var screenSize = MediaQuery.of(context).size;
  //   return Column(
  //     children: [
  //       // const SizedBox(height: 20),
  //       SvgPicture.asset(
  //         dividerGreySVG,
  //         height: 5,
  //         width: 5,
  //       ),
  //       // const SizedBox(height: 20),
  //       const Align(
  //         alignment: Alignment.centerLeft,
  //         child: Padding(
  //           padding: EdgeInsets.only(left: 15.0),
  //           child: Text(
  //             'Mes Commandes',
  //             style: TextStyle(
  //               fontWeight: FontWeight.bold,
  //               fontSize: 18.0,
  //               color: MyColors.black,
  //             ),
  //           ),
  //         ),
  //       ),
  //       // const SizedBox(height: 20),
  //       SizedBox(
  //         // height: screenSize.height - 659,
  //         child: MediaQuery.removePadding(
  //           context: context,
  //           removeTop: true,
  //           removeBottom: true,
  //           child: ListView.builder(
  //             shrinkWrap: true,
  //             itemCount: cardData.length,
  //             // padding: const EdgeInsets.all(30.0),
  //             itemBuilder: (context, index) {
  //               return buildCard(
  //                 cardData[index]['imageName']!,
  //                 cardData[index]['title']!,
  //                 cardData[index]['description']!,
  //                 cardData[index]['numCommande']!,
  //                 cardData[index]['date']!,
  //                 cardData[index]['etat']!,
  //               );
  //             },
  //           ),
  //         ),
  //       ),
  //     ],
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    // return buildContent(context);
    SelfcareFakeData fakeData = SelfcareFakeData();
    var screenSize = MediaQuery.of(context).size;
    return Column(
      children: [
        const SizedBox(height: 20),
        SvgPicture.asset(
          dividerGreySVG,
          height: 5,
          width: 5,
        ),
        const SizedBox(height: 20),
        const Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: EdgeInsets.only(left: 15.0, right: 15.0),
            child: Text(
              'Mes Transactions',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
                color: MyColors.black,
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),
        SizedBox(
          height: screenSize.height - 315,
          child: MediaQuery.removePadding(
            context: context,
            removeTop: true,
            child: Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20.0),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: fakeData.cardData.length,
                itemBuilder: (context, index) {
                  return buildCard2(
                    fakeData.cardData[index]['imageName'] ?? '',
                    fakeData.cardData[index]['title'] ?? '',
                    fakeData.cardData[index]['description'] ?? '',
                    fakeData.cardData[index]['xpText'] ?? '',
                    fakeData.cardData[index]['coin'] ?? '',
                  );
                },
              ),
            ),
          ),
        ),
      ],
    );
  }

  buildCard2(String imageName, String title, String description, String xpText,
      String coin) {
    Column(
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
                  coin,
                ),
              ],
            ),
          ],
        ),
        const SizedBox(
          height: 40.0,
          child: Divider(
            color: MyColors.grey,
          ),
        ),
      ],
    );
  }

  // Widget buildCard(String imageName, String title, String description,
  //     String numCommande, String date, String etat) {
  //   return Column(
  //     children: [
  //       Row(
  //         children: [
  //           Image.asset(
  //             'images/pngs/$imageName.png',
  //             fit: BoxFit.cover,
  //           ),
  //           // const SizedBox(width: 8.0),
  //           Column(
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: [
  //               Text(
  //                 title,
  //                 style: const TextStyle(
  //                   fontWeight: FontWeight.w500,
  //                   fontSize: 15.0,
  //                 ),
  //               ),
  //               Text(
  //                 description,
  //                 style: const TextStyle(
  //                   fontSize: 10.0,
  //                   color: Colors.grey,
  //                 ),
  //               ),
  //               Text(
  //                 numCommande,
  //                 style: const TextStyle(
  //                   fontSize: 10.0,
  //                   color: Colors.grey,
  //                 ),
  //               ),
  //             ],
  //           ),
  //           // const Spacer(),
  //           Column(
  //             children: [
  //               Row(
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 children: [
  //                   Text(
  //                     date,
  //                     style: const TextStyle(
  //                       fontSize: 13.0,
  //                       color: Colors.green,
  //                       fontWeight: FontWeight.w500,
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //               Row(
  //                 crossAxisAlignment: CrossAxisAlignment.end,
  //                 children: [
  //                   // const SizedBox(width: 18.0),
  //                   Text(
  //                     style: const TextStyle(
  //                       fontSize: 13.0,
  //                       color: Colors.red,
  //                       fontWeight: FontWeight.w500,
  //                     ),
  //                     etat,
  //                   ),
  //                 ],
  //               ),
  //             ],
  //           ),
  //         ],
  //       ),
  //       // const SizedBox(
  //       //   height: 40.0,
  //       //   child: Divider(
  //       //     color: MyColors.grey,
  //       //     thickness: .3,
  //       //   ),
  //       // ),
  //     ],
  //   );
  // }
}
