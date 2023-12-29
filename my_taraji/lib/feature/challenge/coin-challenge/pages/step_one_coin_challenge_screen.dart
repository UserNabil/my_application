import 'package:flutter/material.dart';
import 'package:my_taraji/core/theme/my_color.dart';
import 'package:my_taraji/feature/challenge/coin-challenge/pages/leader_bord_screen.dart';
import 'package:my_taraji/feature/challenge/coin-challenge/pages/question_one_challenge_screen.dart';
import 'package:simple_animation_progress_bar/simple_animation_progress_bar.dart';

void main() {
  runApp(const MaterialApp(
    home: StepOneCoinChallenge(),
  ));
}

class StepOneCoinChallenge extends StatefulWidget {
  const StepOneCoinChallenge({Key? key}) : super(key: key);

  @override
  StepOneCoinChallengeState createState() => StepOneCoinChallengeState();
}

class StepOneCoinChallengeState extends State<StepOneCoinChallenge> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    //  var height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: width,
          // height: height,
          padding: const EdgeInsets.only(left: 30, right: 30),
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomRight,
              end: Alignment.topLeft,
              colors: [MyColors.redDarker, MyColors.red],
            ),
            borderRadius: BorderRadius.only(
                // topLeft: Radius.circular(50),
                // topRight: Radius.circular(50),
                ),
          ),
          alignment: Alignment.center,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: const EdgeInsets.only(top: 16),
                child: Row(
                  children: [
                    SizedBox(
                      height: 60,
                      child: ClipOval(
                        child: Image.asset(
                          'images/pngs/profile.jpg',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                    SizedBox(
                      width: 150,
                      height: 20,
                      child: Stack(
                        children: [
                          SimpleAnimationProgressBar(
                            height: 20,
                            width: 180,
                            backgroundColor:
                                const Color.fromARGB(255, 220, 220, 220),
                            foregrondColor: MyColors.yellow,
                            ratio: 0.5,
                            direction: Axis.horizontal,
                            curve: Curves.fastLinearToSlowEaseIn,
                            duration: const Duration(seconds: 3),
                            borderRadius: BorderRadius.circular(10),
                            gradientColor: const LinearGradient(colors: [
                              Color.fromARGB(255, 220, 220, 220),
                              MyColors.yellow
                            ]),
                          ),
                          const Positioned(
                            left:
                                50, // Set the left property to the width of the progress bar
                            top: 0,
                            bottom: 0,
                            child: Center(
                              child: Text(
                                '78xp', // Replace with the actual percentage value
                                style: TextStyle(
                                  color: Colors.white, // Choose the text color
                                  fontSize: 10.0, // Choose the font size
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            right:
                                0, // Set the right property to position the black circle at the end
                            top: 0,
                            bottom: 0,
                            child: Center(
                              child: Container(
                                width: 20,
                                height: 20,
                                decoration: const BoxDecoration(
                                  color: Colors.black,
                                  shape: BoxShape.circle,
                                ),
                                child: const Center(
                                  child: Text(
                                    '12',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 10.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 20),
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Coins',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 13.0,
                            fontWeight: FontWeight.normal,
                            decoration: TextDecoration.none,
                          ),
                        ),
                        Text(
                          '9932',
                          style: TextStyle(
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
                              builder: (context) => const LeaderBord()),
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
                  Container(
                    height: 300,
                    width: 250,
                  ),
                  SizedBox(
                    width: width - 50, // Ajustez la largeur selon vos besoins
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
                            const Text(
                              'NIVEAU 1',
                              style: TextStyle(
                                fontSize: 17.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Text(
                              'Vous pouvez gagner \n jusqu\'à 150 Coins',
                              style: TextStyle(
                                color: MyColors.red,
                                fontSize: 14.0,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                            Image.asset(
                              'images/pngs/Illustration.png',
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 60,
                    right: (width - 210) / 2,
                    width: 150,
                    child: ElevatedButton(
                      onPressed: () {
                        _showPopup(context);
                      },
                      style: ElevatedButton.styleFrom(
                        fixedSize: const Size(10, 10),
                        primary: MyColors.yellow,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        side: const BorderSide(color: Colors.white, width: 1.0),
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
              const SizedBox(height: 40),
            ],
          ),
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
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 30, left: 15, right: 0, bottom: 40),
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
              bottom: 160,
              left: 0,
              right: 0,
              child: Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              const QuestionOneCoinChallenge()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    primary: MyColors.red,
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
