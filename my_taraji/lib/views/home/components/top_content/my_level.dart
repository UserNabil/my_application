import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/theme/my_color.dart';
import 'my_progress.dart';

class MyCardLevel extends StatelessWidget {
  const MyCardLevel({Key? key}) : super(key: key);

  Future<Map<String, String>> _getUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String xp = prefs.getString('xp') ?? 'Error';

    return {
      'xp': xp,
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
        return buildGamification(userData);
      },
    );
  }

  Widget buildGamification(Map<String, String> userData) {
    final String xp = userData['xp']!;

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        //Top
        const Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("MyTaraji",
                    style: TextStyle(fontSize: 11, color: MyColors.yellow))
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Programme de fidélité",
                    style: TextStyle(
                        fontSize: 17,
                        color: MyColors.black,
                        fontWeight: FontWeight.w600))
              ],
            )
          ],
        ),
        // Middle
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Niveau actuel",
                    style: TextStyle(fontSize: 11, color: MyColors.grey)),
                Text(int.parse(xp) < 100 ? "SILVER" : "GOLD",
                    style: const TextStyle(
                        fontSize: 25,
                        color: MyColors.grey,
                        fontWeight: FontWeight.w700)),
              ],
            ),
            Column(
              children: [
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("Points",
                                style: TextStyle(
                                    fontSize: 11, color: MyColors.red)),
                            Text(xp,
                                style: const TextStyle(
                                    fontSize: 18,
                                    color: MyColors.red,
                                    fontWeight: FontWeight.w700)),
                          ]),
                      const SizedBox(width: 10),
                      const Image(
                          image: AssetImage("images/pngs/taraji.png"),
                          width: 50),
                    ]),
              ],
            )
          ],
        ),
        // Bottom
        Column(
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Silver",
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 11,
                        color: MyColors.black)),
                Text("Gold",
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 11,
                        color: MyColors.black))
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MyProgressBar(
                    value: calculateXp(int.parse(xp), 100) / 100,
                    width: 285,
                    height: 15),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("XP:" + xp + "/100",
                    style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 11,
                        color: MyColors.black)),
                Text(
                  calculateXp(int.parse(xp), 100).toString() + " %",
                  style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 11,
                      color: MyColors.black),
                )
              ],
            ),
          ],
        )
      ],
    );
  }
}

class MyLevel extends StatelessWidget {
  const MyLevel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: MyColors.transparent,
      ),
      child: const MyCardLevel(),
    );
  }
}
