import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/theme/my_color.dart';
import '../../home/components/top_content/my_progress.dart';

class MonStatus extends StatefulWidget {
  const MonStatus({super.key});

  @override
  MonStatusState createState() => MonStatusState();
}

class MonStatusState extends State<MonStatus> {
  Future<Map<String, String>> _getUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String xp = prefs.getString('xp') ?? 'Error';
    final String name = prefs.getString("name") ?? 'Error';
    final String coins = prefs.getString("coins") ?? 'Error';
    final String profileImagePath = prefs.getString('profileImagePath') ??
        'https://e-s-tunis.com/images/news/2023/03/03/1677831592_img.jpg';
    final String phone = prefs.getString('phone') ?? 'Error';

    return {
      'xp': xp,
      'name': name,
      'coins': coins,
      'profileImagePath': profileImagePath,
      'phone': phone,
    };
  }

  double calculateXp(int xp, int total) {
    return (xp / total) * 100;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _getUserData(),
      builder: (context, AsyncSnapshot<Map<String, String>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }

        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }
        final userData = snapshot.data!;
        return buildStatut(userData);
      },
    );
  }

  Widget buildStatut(Map<String, String> userData) {
    final String xp = userData['xp']!;
    final String name = userData['name']!;
    final String coins = userData['coins']!;
    final String profileImagePath = userData['profileImagePath']!;
    final String phone = userData['phone']!;
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
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ClipOval(
              child: Image(
                image: NetworkImage(profileImagePath),
                fit: BoxFit.cover,
                width: 60.0,
                height: 60.0,
              ),
            ),
            const SizedBox(width: 13.0),
            // Text
            Column(
              children: [
                Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 15.0),
                Text(phone),
              ],
            ),
            const SizedBox(width: 13.0),
            // Text
            Column(
              children: [
                Text('$coins Coins',
                    style: const TextStyle(color: Colors.green)),
                const SizedBox(height: 15.0),
                Text(int.parse(xp) < 100 ? 'Silver' : 'gold',
                    style: const TextStyle(color: MyColors.red)),
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
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(xp, style: const TextStyle(fontSize: 9.0)),
                    const SizedBox(width: 140.0),
                    const Text('100', style: TextStyle(fontSize: 9.0)),
                  ],
                ),
                MyProgressBar(
                    value: calculateXp(int.parse(xp), 100) / 100,
                    width: 180,
                    height: 15),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(calculateXp(int.parse(xp), 100).toString(),
                        style: const TextStyle(fontSize: 9.0)),
                    const SizedBox(width: 140.0),
                    const Text('100%', style: TextStyle(fontSize: 9.0)),
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
