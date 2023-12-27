import 'package:flutter/material.dart';
import 'package:my_taraji/core/theme/my_color.dart';
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
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: width,
          padding: const EdgeInsets.only(left: 30, right: 30),
          decoration: const BoxDecoration(
            color: MyColors.red,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(50),
              topRight: Radius.circular(50),
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
            ],
          ),
        ),
      ),
    );
  }
}
