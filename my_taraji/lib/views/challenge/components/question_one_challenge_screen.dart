import 'package:flutter/material.dart';
import 'package:my_taraji/core/theme/my_color.dart';
import 'package:my_taraji/views/challenge/components/step_one_coin_challenge_screen.dart';
import 'package:simple_animation_progress_bar/simple_animation_progress_bar.dart';

void main() {
  runApp(const MaterialApp(
    home: QuestionOneCoinChallenge(),
  ));
}

class QuestionOneCoinChallenge extends StatefulWidget {
  const QuestionOneCoinChallenge({Key? key}) : super(key: key);

  @override
  QuestionOneCoinChallengeState createState() =>
      QuestionOneCoinChallengeState();
}

class QuestionOneCoinChallengeState extends State<QuestionOneCoinChallenge> {
  final List<String> cardTexts = [
    '2015',
    '2017',
    '2019',
    '2021',
  ];

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: width,
          //height: height,
          padding: const EdgeInsets.only(left: 30, right: 30),
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomRight,
              end: Alignment.topLeft,
              colors: [MyColors.redDarker, MyColors.red],
            ),
          ),
          alignment: Alignment.center,
          child: Column(
            //   crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: const EdgeInsets.only(top: 50),
                child: Row(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const StepOneCoinChallenge()),
                            );
                          },
                          child: Image.asset(
                            'images/pngs/IconLeft.png',
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 100),
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Question 1',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 13.0,
                            fontWeight: FontWeight.normal,
                            decoration: TextDecoration.none,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                child: SimpleAnimationProgressBar(
                  height: 10,
                  width: 700,
                  backgroundColor: const Color.fromARGB(255, 220, 220, 220),
                  foregrondColor: MyColors.blue,
                  ratio: 0.5,
                  direction: Axis.horizontal,
                  curve: Curves.fastLinearToSlowEaseIn,
                  duration: const Duration(seconds: 3),
                  borderRadius: BorderRadius.circular(10),
                  gradientColor: const LinearGradient(
                      colors: [MyColors.blue, MyColors.blue]),
                ),
              ),
              const SizedBox(height: 40),
              Stack(
                children: [
                  const SizedBox(
                    height: 180,
                    width: 150,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: SizedBox(
                      height: 200,
                      width: width - 50, // Ajustez la largeur selon vos besoins
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        color: Colors.white,
                        child: const Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'En quelle année,\nKylian Mbappé a-t-il\nle rejoint le club du\nParis Saint-Germain\n?',
                                style: TextStyle(
                                  fontSize: 17.0,
                                  fontWeight: FontWeight.normal,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    right: (width - 320) / 2,
                    child: Row(
                      children: [
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            fixedSize: const Size(80, 50),
                            primary: MyColors.yellow,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                          child: const Text(
                            '50/50',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 10.0,
                            ),
                          ),
                        ),
                        const SizedBox(
                            width:
                                10), // Ajustez l'espacement selon vos besoins
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            fixedSize: const Size(80, 50),
                            primary: MyColors.yellow,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                          child: Image.asset(
                            'images/pngs/eye.png',
                          ),
                        ),
                        const SizedBox(
                            width:
                                10), // Ajustez l'espacement selon vos besoins
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            fixedSize: const Size(80, 50),
                            primary: MyColors.yellow,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                          child: Image.asset(
                            'images/pngs/watch.png',
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              for (String cardText in cardTexts)
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical:
                          8.0), // Ajouter un espace vertical entre les boutons
                  child: ElevatedButton(
                    onPressed: () {
                      // Add your button onPressed logic here
                    },
                    style: ElevatedButton.styleFrom(
                      fixedSize: const Size(310, 50),
                      elevation: 4.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        side: const BorderSide(color: Colors.white, width: 2.0),
                      ),
                      primary: Colors.transparent,
                      onPrimary: MyColors
                          .yellow, // Couleur de fond lorsque le bouton est pressé
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        cardText,
                        style: const TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  fixedSize: const Size(150, 30),
                  primary: MyColors.yellow,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                ),
                child: const Text(
                  'Valider',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.0, // Ajustez la taille de la police ici
                  ),
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
