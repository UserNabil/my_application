import 'package:my_taraji/views/fanpay/imports.dart';

import '../../import.dart';

class MyCardLevel extends StatelessWidget {
  const MyCardLevel({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: context.read<HomeProvider>().getUserData(),
      builder: (context, AsyncSnapshot<User?> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SizedBox(
            height: 100,
            child: Center(
              child: CircularProgressIndicator(color: MyColors.yellow),
            ),
          );
        }

        if (snapshot.hasError) {
          return Container();
        }
        final userData = snapshot.data;
        return buildGamification(userData);
      },
    );
  }

  Widget buildGamification(User? userData) {
    String xp = userData?.myGamification?.expPoints.toString() ?? '0';
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
                Text(
                  "Programme de fidélité",
                  style: TextStyle(
                    fontSize: 17,
                    color: MyColors.black,
                    fontWeight: FontWeight.w600,
                  ),
                ),
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
                Text(userData?.level?.currentLevel.nameFR ?? "",
                    style: TextStyle(
                        fontSize: 25,
                        color: int.parse(xp) <
                                double.parse(
                                  (userData?.level?.nextLevel.pointsMax ?? 0)
                                      .toString(),
                                )
                            ? MyColors.grey
                            : MyColors.yellow,
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  userData?.level?.currentLevel.nameFR ?? "",
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 11,
                    color: MyColors.black,
                  ),
                ),
                Text(
                  userData?.level?.nextLevel.nameFR ?? "",
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 11,
                    color: MyColors.black,
                  ),
                )
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MyProgressBar(
                  value: double.parse(
                    ((userData?.level?.currentPercentage ?? 0) / 100)
                        .toString(),
                  ),
                  width: 285,
                  height: 15,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "XP: $xp / ${userData?.level?.nextLevel.pointsMax}",
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 11,
                    color: MyColors.black,
                  ),
                ),
                Text(
                  "${userData?.level?.currentPercentage} %",
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 11,
                    color: MyColors.black,
                  ),
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
  const MyLevel({super.key});

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
