import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:my_taraji/core/models/leader_bord_result.dart';
import 'package:my_taraji/core/theme/my_color.dart';
import 'package:my_taraji/services/challenge_service.dart';
import 'package:my_taraji/views/challenge/components/step_one_coin_challenge_screen.dart';
import 'package:my_taraji/views/init/page/init_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:my_taraji/core/models/challenge_by_id_model.dart';
// void main() {
//   runApp(const MaterialApp(
//     home: LeaderBord(""),
//   ));
// }

class LeaderBord extends StatefulWidget {
  final String challengeId;
  const LeaderBord(this.challengeId, {super.key});

  @override
  LeaderBordState createState() =>
      // ignore: no_logic_in_create_state
      LeaderBordState(challengeid: challengeId);
}

class LeaderBordState extends State<LeaderBord> {
  final String challengeid;
  LeaderBordState({required this.challengeid});
  int currentSelectedIndex = 0;
  String profileImagePath = "";
  String xp = "";
  String coins = "";
  String firstPlaceBackgroundColor = "0xFFC1242D";
  String otherPlaceBackgroundColor = "0xFFFCC213";
  String firstPlacebackgroundColorValue = "0xFFFCC213";
  String otherPlacebackgroundColorValue = "0xFFC1242D";
  String firstPlaceImageColor = "#FCC213";
  String otherPlaceImageColor = "#C1242D";
  bool hasstep = true;
  ChallengeById? challenge;
  LeaderBordResult? leaderbord;
  ChallengeService challengeService = ChallengeService();
  bool isDataLoaded = false;

  @override
  void initState() {
    super.initState();
    getuserinfo();
    _loadChallenge();
  }

  Future<void> getuserinfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    profileImagePath = prefs.getString('profileImagePath') ??
        'https://e-s-tunis.com/images/news/2023/03/03/1677831592_img.jpg';
    coins = prefs.getString('coins') ?? '0';
    xp = prefs.getString('xp') ?? '0';
  }

  Future<void> loadLeaderBordInfo() async {
    try {
      if (!isDataLoaded) {
        LeaderBordResult? loadedLeaderBord = await challengeService
            .getLeaderBordInfoByChallengeId(challengeid)
            .then((value) => value.data);

        setState(() {
          leaderbord = loadedLeaderBord;
          isDataLoaded = true;
        });
        // ignore: avoid_print
        print('leader bord: ${leaderbord?.toMap()}');
      }
    } catch (e) {
      // ignore: avoid_print
      print('Failed to load leader bord data: $e');
    }
  }

  Future<void> _loadChallenge() async {
    try {
      var challengeService = ChallengeService();
      ChallengeById? loadedChallenge = await challengeService
          .getChallengeById(challengeid)
          .then((value) => value.data);
      if (loadedChallenge != null) {
        List<ChallengeStep> unfinishedSteps = loadedChallenge.steps
            .where((step) => step.status != "done")
            .toList();
        setState(() {
          if (unfinishedSteps.isEmpty) {
            hasstep = false;
          }
        });
      }
      // ignore: avoid_print
      print("has step $hasstep");
    } catch (e) {
      // ignore: avoid_print
      print('Failed to load challenge data by id: $e');
    }
  }

  void updateCurrentIndex(int index) {
    if (index != currentSelectedIndex) {
      setState(() {
        currentSelectedIndex = index;
      });
    }
  }

  Color hexToColor(String code) {
    return Color(int.parse(code.replaceAll('#', '0xFF')));
  }

  Widget buildColoredCard(
    String backgroundColor,
    int text1,
    String image1,
    String text2,
    String image2,
    int text3,
    String backgroundColorValue,
    String imageColor,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: Color(int.parse(backgroundColor)),
        borderRadius: BorderRadius.circular(10.0),
      ),
      padding: const EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                text1.toString(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14.0,
                  fontWeight: FontWeight.normal,
                  decoration: TextDecoration.none,
                ),
              ),
              const SizedBox(width: 10),
              SizedBox(
                height: 40, // Set a fixed height for the image container
                width: 40, // Set a fixed width for the image container
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: Image(
                    image: NetworkImage(profileImagePath),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Text(
                text2,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14.0,
                  fontWeight: FontWeight.normal,
                  decoration: TextDecoration.none,
                ),
              ),
              const SizedBox(width: 10),
              SizedBox(
                height: 20, // Set a fixed height for the image container
                width: 20,
                child: ColorFiltered(
                  colorFilter: ColorFilter.mode(
                    hexToColor(
                        imageColor), // Set the desired color (in this case, red)
                    BlendMode.srcIn,
                  ),
                  // Set a fixed width for the image container
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20.0),
                    child: Image.asset(
                      image2,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Container(
                decoration: BoxDecoration(
                  color: Color(int.parse(backgroundColorValue)),
                  borderRadius: BorderRadius.circular(6.0),
                ),
                padding: const EdgeInsets.all(6),
                child: Text(
                  text3.toString(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.none,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: loadLeaderBordInfo(),
      builder: (context, AsyncSnapshot<void> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SizedBox(
            height: 100,
            child: Center(
              child: CircularProgressIndicator(
                color: MyColors.yellow,
              ),
            ),
          );
        }
        if (snapshot.hasError) {
          return SizedBox(
            height: 100,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: MyColors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                    onPressed: () {
                      setState(() {});
                    },
                    child: const Icon(
                      TablerIcons.refresh,
                      color: MyColors.red,
                    ),
                  ),
                ],
              ),
            ),
          );
        }

        // if (snapshot.connectionState == ConnectionState.done) {
        return buildContent(context);
        // }

        // return Container();
      },
    );
  }

  Widget buildContent(BuildContext context) {
    //var width = MediaQuery.of(context).size.width;
    // if (leaderbord != null) {
    //   return const SizedBox(
    //     height: 100,
    //     child: Center(
    //       child: CircularProgressIndicator(
    //         color: MyColors.yellow,
    //       ),
    //     ),
    //   );
    // }
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomRight,
            end: Alignment.topLeft,
            colors: [MyColors.redDarker, MyColors.red],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(top: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            child: ClipOval(
                              child: Image(
                                image: NetworkImage(profileImagePath),
                                fit: BoxFit.cover,
                                width: 60.0,
                                height: 60.0,
                              ),
                            ),
                          ),
                          const SizedBox(width: 20),
                          // Expanded(
                          //   child: SizedBox(
                          //     height: 20,
                          //     child: Stack(
                          //       children: [
                          //         SimpleAnimationProgressBar(
                          //           height: 20,
                          //           width: MediaQuery.of(context).size.width *
                          //               0.8, // Utilisation de 80% de la largeur de l'écran
                          //           backgroundColor: const Color.fromARGB(
                          //               255, 220, 220, 220),
                          //           foregrondColor: MyColors.yellow,
                          //           ratio: 0.3,
                          //           direction: Axis.horizontal,
                          //           curve: Curves.fastLinearToSlowEaseIn,
                          //           duration: const Duration(seconds: 3),
                          //           borderRadius: BorderRadius.circular(10),
                          //           gradientColor: const LinearGradient(
                          //               colors: [
                          //                 Color.fromARGB(255, 220, 220, 220),
                          //                 MyColors.yellow
                          //               ]),
                          //         ),
                          //         Positioned(
                          //           left: MediaQuery.of(context).size.width *
                          //                   0.4 -
                          //               (0.4 *
                          //                   MediaQuery.of(context).size.width *
                          //                   0.5), // Ajustement pour centrer le texte par rapport à la barre de progression
                          //           top: 0,
                          //           bottom: 0,
                          //           child: Center(
                          //             child: Text(
                          //               "${xp}xp",
                          //               style: const TextStyle(
                          //                 color: Colors.white,
                          //                 fontSize: 10.0,
                          //                 fontWeight: FontWeight.bold,
                          //               ),
                          //             ),
                          //           ),
                          //         ),
                          //         Positioned(
                          //           right: 0,
                          //           top: 0,
                          //           bottom: 0,
                          //           child: Center(
                          //             child: Container(
                          //               width: 20,
                          //               height: 20,
                          //               decoration: const BoxDecoration(
                          //                 color: Colors.black,
                          //                 shape: BoxShape.circle,
                          //               ),
                          //               child: const Center(
                          //                 child: Text(
                          //                   '12',
                          //                   style: TextStyle(
                          //                     color: Colors.white,
                          //                     fontSize: 10.0,
                          //                     fontWeight: FontWeight.bold,
                          //                   ),
                          //                 ),
                          //               ),
                          //             ),
                          //           ),
                          //         ),
                          //       ],
                          //     ),
                          //   ),
                          // ),
                          // const SizedBox(width: 20),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Coins',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 13.0,
                                  fontWeight: FontWeight.normal,
                                  decoration: TextDecoration.none,
                                ),
                              ),
                              Text(
                                coins,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.none,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 5),
                    Container(
                      margin: const EdgeInsets.only(top: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              // Naviguer vers la page précédente ici
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const InitScreen(),
                                ),
                              );
                            },
                            child: Image.asset(
                              'images/pngs/Presedent.png', // Remplacez par le chemin de votre image
                              fit: BoxFit.cover,
                            ),
                          ),
                          if (hasstep == true)
                            GestureDetector(
                              onTap: () {
                                // Naviguer vers une autre page ici
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        StepOneCoinChallenge(challengeid),
                                  ),
                                );
                              },
                              child: Image.asset(
                                'images/pngs/Next.png', // Remplacez par le chemin de votre image
                                fit: BoxFit.cover,
                              ),
                            )
                          else
                            Container(),
                        ],
                      ),
                    ),
                    const SizedBox(height: 5),
                    const Text(
                      'Ma position',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.none,
                      ),
                    ),
                    buildColoredCard(
                        "0xFF000000",
                        leaderbord!.userRank.rank,
                        leaderbord!.userRank.imageUrl ??
                            'https://e-s-tunis.com/images/news/2023/03/03/1677831592_img.jpg',
                        "${leaderbord!.userRank.firstName ?? ""} ${leaderbord!.userRank.lastName ?? ""}",
                        'images/pngs/level.png',
                        leaderbord!.userRank.score,
                        '0xFFFCC213',
                        '#FFFFFF'),
                    const SizedBox(height: 20),
                    const Text(
                      'Classement global',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.none,
                      ),
                    ),
                    if (leaderbord != null)
                      for (var data in leaderbord!.ranks)
                        Column(
                          children: [
                            buildColoredCard(
                              (data.rank == 1)
                                  ? firstPlaceBackgroundColor
                                  : otherPlaceBackgroundColor,
                              data.rank,
                              data.imageUrl ??
                                  'https://e-s-tunis.com/images/news/2023/03/03/1677831592_img.jpg',
                              "${data.firstName ?? ""} ${data.lastName ?? ""}",
                              "images/pngs/level.png",
                              data.score,
                              (data.rank == 1)
                                  ? firstPlacebackgroundColorValue
                                  : otherPlacebackgroundColorValue,
                              (data.rank == 1)
                                  ? firstPlaceImageColor
                                  : otherPlaceImageColor,
                            ),
                            const SizedBox(height: 10),
                          ],
                        )
                    // else
                    //   const CircularProgressIndicator(
                    //     color: MyColors.yellow,
                    //   ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
