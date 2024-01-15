import '../../import.dart';

class MyCardLevel extends StatelessWidget {
  const MyCardLevel({super.key});

  Future<Map<String, String>> _getUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String xp = prefs.getString('xp') ?? '0';
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
          return const SizedBox(
            height: 100,
            child: Center(
              child: CircularProgressIndicator(color: MyColors.yellow),
            ),
          );
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
    String xp = userData['xp']!;
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
                    style: TextStyle(
                        fontSize: 25,
                        color: int.parse(xp) < 100
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
                Text(int.parse(xp) > 100 ? "Gold" : "Silver",
                    style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 11,
                        color: MyColors.black)),
                Text(int.parse(xp) > 100 ? "Diamond" : "Gold",
                    style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 11,
                        color: MyColors.black))
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MyProgressBar(
                    value: calculateXp(
                            int.parse(xp), int.parse(xp) > 100 ? 1000 : 100) /
                        100,
                    width: 285,
                    height: 15),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("XP:$xp/${int.parse(xp) > 100 ? 1000 : 100}",
                    style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 11,
                        color: MyColors.black)),
                Text(
                  "${calculateXp(int.parse(xp), int.parse(xp) > 100 ? 1000 : 100)} %",
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
