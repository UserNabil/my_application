import 'package:my_taraji/views/fanpay/imports.dart';
import 'package:my_taraji/views/init/models/level.dart';
import '../../home/components/top_content/my_progress.dart';

class MonStatus extends StatefulWidget {
  const MonStatus({super.key});

  @override
  MonStatusState createState() => MonStatusState();
}

class MonStatusState extends State<MonStatus> {
  double calculateXp(int xp, int total) {
    return (xp / total) * 100;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: context.read<HomeProvider>().getUserData(),
      builder: (context, AsyncSnapshot<User?> snapshot) {
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

  Widget buildStatut(User userData) {
    final String xp = userData.myGamification?.expPoints.toString() ?? '0';
    final String name = userData.pseudo ?? '';
    final String coins = userData.myRewards?.coins.toString() ?? '';
    final String phone = userData.phone ?? '';
    final Level? level = userData.level;
    String profileImagePath =
        'https://e-s-tunis.com/images/news/2023/03/03/1677831592_img.jpg';
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
                Text(level?.currentLevel.nameFR ?? '',
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
                Text(
                  level?.currentLevel.nameFR ?? '',
                  style: const TextStyle(
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
                    Text(level?.nextLevel.pointsMax.toString() ?? '0',
                        style: const TextStyle(fontSize: 9.0)),
                  ],
                ),
                MyProgressBar(
                    value: (level?.currentPercentage ?? 0) / 100,
                    width: 180,
                    height: 15),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("${(level?.currentPercentage ?? "0")}%",
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
                Text(
                  level?.nextLevel.nameFR ?? '',
                  style: const TextStyle(
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
