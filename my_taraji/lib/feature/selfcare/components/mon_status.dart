import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../core/theme/my_color.dart';
import '../../home/components/top_content/my_progress.dart';

class MonStatus extends StatefulWidget {
  const MonStatus({Key? key}) : super(key: key);

  @override
  MonStatusState createState() => MonStatusState();
}

class MonStatusState extends State<MonStatus> {
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
              'Mon Status',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
                color: MyColors.black,
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipOval(
              child: Image.asset(
                'images/pngs/user.png',
                fit: BoxFit.cover,
                width: 60.0,
                height: 60.0,
              ),
            ),
            const SizedBox(width: 13.0),
            // Text
            const Column(
              children: [
                Text('Alise Ramond',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 15.0),
                Text('+216 20 789 245'),
              ],
            ),
            const SizedBox(width: 13.0),
            // Text
            const Column(
              children: [
                Text('605 Coins', style: TextStyle(color: Colors.green)),
                SizedBox(height: 15.0),
                Text('Silver', style: TextStyle(color: MyColors.red)),
              ],
            ),
          ],
        ),
        const SizedBox(height: 20),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                Image.asset('images/pngs/trophesilver.png', fit: BoxFit.cover),
                const Text(
                  'Silver',
                  style: TextStyle(
                      color: MyColors.grey, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text('605', style: TextStyle(fontSize: 9.0)),
                    SizedBox(width: 140.0),
                    Text('1000', style: TextStyle(fontSize: 9.0)),
                  ],
                ),
                MyProgressBar(value: 75, width: 180, height: 15),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text('65%', style: TextStyle(fontSize: 9.0)),
                    SizedBox(width: 140.0),
                    Text('100%', style: TextStyle(fontSize: 9.0)),
                  ],
                ),
              ],
            ),
            Column(
              children: [
                Image.asset('images/pngs/trophegold.png', fit: BoxFit.cover),
                const Text(
                  'Gold',
                  style: TextStyle(
                      color: MyColors.yellow, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 20),
        Card(
          color: MyColors.grey,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 10.0, bottom: 8.0),
                  child: const Text(
                    'Avantages Actuels',
                    style: TextStyle(
                        color: MyColors.red,
                        fontWeight: FontWeight.bold,
                        fontSize: 15),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 15.0),
                  child: RichText(
                    text: const TextSpan(
                      children: [
                        WidgetSpan(
                          alignment: PlaceholderAlignment.middle,
                          child: Icon(
                            Icons.circle,
                            color: MyColors.white,
                            size: 8.0,
                          ),
                        ),
                        TextSpan(
                          text: ' Récompenses améliorées\n',
                          style: TextStyle(fontSize: 14),
                        ),
                        WidgetSpan(
                          alignment: PlaceholderAlignment.middle,
                          child: Icon(
                            Icons.circle,
                            color: MyColors.white,
                            size: 8.0,
                          ),
                        ),
                        TextSpan(
                            text: ' Accès à des fonctionnalités exclusives\n',
                            style: TextStyle(fontSize: 14)),
                        WidgetSpan(
                          alignment: PlaceholderAlignment.middle,
                          child: Icon(
                            Icons.circle,
                            color: MyColors.white,
                            size: 8.0,
                          ),
                        ),
                        TextSpan(
                          text: ' Priorité dans le support client\n',
                          style: TextStyle(fontSize: 14),
                        ),
                        WidgetSpan(
                          alignment: PlaceholderAlignment.middle,
                          child: Icon(
                            Icons.circle,
                            color: MyColors.white,
                            size: 8.0,
                          ),
                        ),
                        TextSpan(
                          text: ' Participation à des événements exclusifs',
                          style: TextStyle(fontSize: 14),
                        ),
                      ],
                      style: TextStyle(color: MyColors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 20),
        Card(
          color: MyColors.yellow,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 10.0, bottom: 8.0),
                  child: const Text(
                    'Avantages A Venir',
                    style: TextStyle(
                        color: MyColors.red,
                        fontWeight: FontWeight.bold,
                        fontSize: 15),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 15.0),
                  child: RichText(
                    text: const TextSpan(
                      children: [
                        WidgetSpan(
                          alignment: PlaceholderAlignment.middle,
                          child: Icon(
                            Icons.circle,
                            color: MyColors.white,
                            size: 8.0,
                          ),
                        ),
                        TextSpan(
                          text: ' Réductions ou Offres Exclusives\n',
                          style: TextStyle(fontSize: 14),
                        ),
                        WidgetSpan(
                          alignment: PlaceholderAlignment.middle,
                          child: Icon(
                            Icons.circle,
                            color: MyColors.white,
                            size: 8.0,
                          ),
                        ),
                        TextSpan(
                            text: ' Personnalisation Avancée\n',
                            style: TextStyle(fontSize: 14)),
                        WidgetSpan(
                          alignment: PlaceholderAlignment.middle,
                          child: Icon(
                            Icons.circle,
                            color: MyColors.white,
                            size: 8.0,
                          ),
                        ),
                        TextSpan(
                          text: ' Accès à des Événements VIP\n',
                          style: TextStyle(fontSize: 14),
                        ),
                        WidgetSpan(
                          alignment: PlaceholderAlignment.middle,
                          child: Icon(
                            Icons.circle,
                            color: MyColors.white,
                            size: 8.0,
                          ),
                        ),
                        TextSpan(
                          text: ' Avantages Sociaux',
                          style: TextStyle(fontSize: 14),
                        ),
                      ],
                      style: TextStyle(color: MyColors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 80),
      ],
    );
  }
}
