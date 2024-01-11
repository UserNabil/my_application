import 'package:flutter/material.dart';
import 'package:my_taraji/core/theme/my_color.dart';
import 'package:my_taraji/views/challenge/components/step_one_coin_challenge_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

// void main() {
//   runApp(const MaterialApp(
//     home: ResponseQuestionChallenge(
//       stepid: "659564607428f60708a9be76",
//       challengeid: "",
//       textQuestion: "Question 1",
//       message: "Bien Joué !",
//       image: AssetImage('images/pngs/Check.png'), // Remplacez par votre image
//       description: "Vous avez gagné",
//     ),
//   ));
// }

// ignore: must_be_immutable
class ResponseStepChallenge extends StatelessWidget {
  final String challengeid;
  final String message;
  final ImageProvider<Object> image;
  final String description;
  String profileImagePath = "";
  String xp = "";
  String coins = "";
  ResponseStepChallenge({
    super.key,
    required this.challengeid,
    required this.message,
    required this.image,
    required this.description,
  });
  Future<void> getuserinfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    profileImagePath = prefs.getString('profileImagePath') ??
        'https://e-s-tunis.com/images/news/2023/03/03/1677831592_img.jpg';
    coins = prefs.getString('coins')!;
    xp = prefs.getString('xp')!;
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
          return const Text("loading");
        }

        return buildContent(context);
      },
    );
  }

  Widget buildContent(BuildContext context) {
    // var width = MediaQuery.of(context).size.width;
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
                    const SizedBox(height: 20),
                    Container(
                      margin: const EdgeInsets.all(16.0),
                      padding: const EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // Première ligne : message
                            Text(
                              message,
                              style: const TextStyle(
                                fontSize: 22.0,
                                fontWeight: FontWeight.bold,
                                color: MyColors.white,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 50),
                            // Deuxième ligne : image
                            Container(
                              margin:
                                  const EdgeInsets.symmetric(vertical: 10.0),
                              height: 100.0,
                              width: 150.0,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: image,
                                  fit: BoxFit.cover,
                                ),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                            const SizedBox(height: 30),
                            // Troisième ligne : description
                            Text(
                              description,
                              style: const TextStyle(
                                fontSize: 17.0,
                                fontWeight: FontWeight.normal,
                                color: MyColors.white,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 110),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                StepOneCoinChallenge(challengeid),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        fixedSize: const Size(280, 40),
                        backgroundColor: MyColors.yellow,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      child: const Text(
                        'Niveau suivant',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 14.0,
                            fontWeight: FontWeight.normal),
                      ),
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
}
