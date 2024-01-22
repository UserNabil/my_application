import 'package:flutter/material.dart';
import 'package:my_taraji/core/models/challenge_by_id_model.dart';
import 'package:my_taraji/core/theme/my_color.dart';
import 'package:my_taraji/services/challenge_service.dart';
import 'package:my_taraji/views/challenge/pages/leader_bord_screen.dart';
import 'package:my_taraji/views/challenge/components/question_one_challenge_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

// void main() {
//   runApp(const MaterialApp(
//     home: StepOneCoinChallenge("6595376beb16ee594ceb90d8"),
//   ));
// }

class StepOneCoinChallenge extends StatefulWidget {
  final String challengeId;

  // ignore: use_super_parameters
  const StepOneCoinChallenge(this.challengeId, {Key? key}) : super(key: key);

  @override
  StepOneCoinChallengeState createState() =>
      // ignore: no_logic_in_create_state
      StepOneCoinChallengeState(challengeid: challengeId);
}

class StepOneCoinChallengeState extends State<StepOneCoinChallenge> {
  String profileImagePath = "";
  String xp = "";
  String coins = "";
  bool laststep = false;
  final String challengeid;
  ChallengeById? challenge;
  ChallengeStep? currentstep;
  StepOneCoinChallengeState({required this.challengeid});
  @override
  void initState() {
    super.initState();
    _loadChallenge();
  }

  Future<void> getuserinfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    profileImagePath = prefs.getString('profileImagePath') ??
        'https://e-s-tunis.com/images/news/2023/03/03/1677831592_img.jpg';
    coins = prefs.getString('coins')!;
    xp = prefs.getString('xp')!;
  }

  Future<void> _loadChallenge() async {
    try {
      var challengeService = ChallengeService();
      ChallengeById? loadedChallenge = await challengeService
          .getChallengeById(challengeid)
          .then((value) => value.data);

      List<ChallengeStep> unfinishedSteps = loadedChallenge!.steps
          .where((step) => step.status != "done")
          .toList();
      if (unfinishedSteps.length == 1) {
        laststep = true;
      }
      if (unfinishedSteps.isNotEmpty) {
        currentstep = unfinishedSteps.first;
      }

      setState(() {
        challenge = loadedChallenge;
      });
    } catch (e) {
      // ignore: avoid_print
      print('Failed to load challenge data by id: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getuserinfo(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Container();
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          // return const Text("loading");
        }

        return buildContent(context);
      },
    );
  }

  Widget buildContent(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    //  var height = MediaQuery.of(context).size.height;
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
                          const SizedBox(width: 20),
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
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        LeaderBord(challengeid)),
                              );
                            },
                            child: Image.asset(
                              'images/pngs/Presedent.png',
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 150),
                    Stack(
                      children: [
                        const SizedBox(
                          height: 300,
                          width: 250,
                        ),
                        SizedBox(
                          width: width - 50,
                          height: 234, // Ajustez la largeur selon vos besoins
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            color: Colors.white,
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  if (currentstep != null)
                                    Text(
                                      currentstep!.title,
                                      style: const TextStyle(
                                        fontSize: 17.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  // else
                                  //   const CircularProgressIndicator(),
                                  if (currentstep != null)
                                    Text(
                                      'Vous pouvez gagner \n jusqu\'à ${currentstep!.stepTotal} points',
                                      style: const TextStyle(
                                        color: MyColors.red,
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                  // else
                                  //   const CircularProgressIndicator(),
                                  Image.asset(
                                    'images/pngs/Illustration.png',
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 58,
                          right: (width - 200) / 2,
                          width: 150,
                          child: ElevatedButton(
                            onPressed: () {
                              _showPopup(context);
                            },
                            style: ElevatedButton.styleFrom(
                              fixedSize: const Size(10, 10),
                              backgroundColor: MyColors.yellow,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              side: const BorderSide(
                                  color: Colors.white, width: 1.0),
                            ),
                            child: const Text(
                              'Démarrer',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16.0,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Stack(
          children: [
            Container(
              color: Colors.transparent,
            ),
            AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
                side: const BorderSide(color: Colors.white, width: 2.0),
              ),
              backgroundColor: MyColors.yellow,
              content: SizedBox(
                width: 150,
                height: 310,
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 30,
                    left: 15,
                    right: 0,
                    bottom: 40,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        text: const TextSpan(
                          style: TextStyle(
                            fontSize: 17.0,
                            color: MyColors.red,
                            fontWeight: FontWeight.normal,
                          ),
                          children: <TextSpan>[
                            TextSpan(
                              text: 'EL Taraji Quiz',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextSpan(
                              text:
                                  ' est un jeu dynamique sur l\'actualité footballistique mondiale \net le club tunisien El Taraji.',
                            ),
                          ],
                        ),
                      ),
                      const Text(
                        'Testez vos\nconnaissances, défiez\nd\'autres fans et\nremportez des prix!',
                        style: TextStyle(
                          color: MyColors.red,
                          fontSize: 16.0,
                          fontWeight: FontWeight.normal,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: MediaQuery.of(context).size.height *
                  0.26, // 10% de la hauteur de l'écran depuis le bas
              left: 0,
              right: 0,
              child: Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => QuestionOneCoinChallenge(
                          laststep,
                          currentstep!.id,
                          currentstep!.questionNumber,
                          challengeid,
                        ),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: MyColors.red,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    side: const BorderSide(color: Colors.white, width: 2.0),
                  ),
                  child: const Text(
                    'Compris',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
