import 'dart:async';
import 'package:flutter/material.dart';
import 'package:my_taraji/core/models/challenge_answer_request_model.dart';
import 'package:my_taraji/core/models/next_question_model.dart';
import 'package:my_taraji/core/theme/my_color.dart';
import 'package:my_taraji/services/challenge_service.dart';
import 'package:my_taraji/views/challenge/components/response_question_screen.dart';
import 'package:my_taraji/views/challenge/components/step_one_coin_challenge_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_animation_progress_bar/simple_animation_progress_bar.dart';

// void main() {
//   runApp(const MaterialApp(
//     home: QuestionOneCoinChallenge(
//         "659564607428f60708a9be76", "6595376beb16ee594ceb90d8"),
//   ));
// }

// class DiamondShapeBackground extends StatelessWidget {
//   final double width;
//   final double height;
//   final Widget child;

//   const DiamondShapeBackground({
//     Key? key,
//     required this.width,
//     required this.height,
//     required this.child,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: width,
//       height: height,
//       decoration: const BoxDecoration(
//         color: Color.fromRGBO(255, 255, 255, 0.0),
//         shape: BoxShape.rectangle,
//       ),
//       child: ClipPath(
//         clipper: DiamondClipper(),
//         child: Container(
//           color: MyColors.yellow,
//           child: child,
//         ),
//       ),
//     );
//   }
// }

class DiamondClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.moveTo(size.width / 2, 0);
    path.lineTo(size.width, size.height / 2);
    path.lineTo(size.width / 2, size.height);
    path.lineTo(0, size.height / 2);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}

class QuestionOneCoinChallenge extends StatefulWidget {
  final String stepId;
  final String challengeId;
// Add this variable
  const QuestionOneCoinChallenge(this.stepId, this.challengeId, {Key? key})
      : super(key: key);

  @override
  QuestionOneCoinChallengeState createState() =>
      QuestionOneCoinChallengeState(stepid: stepId, challengeid: challengeId);
}

class QuestionOneCoinChallengeState extends State<QuestionOneCoinChallenge> {
  final String stepid;
  final String challengeid;
  bool isLoading = false;
  bool isApiCalled = false;
  QuestionOneCoinChallengeState(
      {required this.stepid, required this.challengeid});
  ChallengeQuestionResult? question;
  String answerResponse = "";
  int selectedChoiceIndex = -1;
  String selectedChoice = "";
  double ratio = 0.0;
  Color progressBarColor = MyColors.blue;
  Timer? countdownTimer;
  late DateTime startdate;
  @override
  void initState() {
    super.initState();
    _loadQuestion();
  }

  Future<void> startTimer(double counterTime) async {
    const oneSecond = Duration(seconds: 1);
    countdownTimer = Timer.periodic(
      oneSecond,
      (timer) async {
        setState(() {
          counterTime--;
          ratio = 1 - (counterTime / 60);
          double pourcentagered = (question!.nextQuestion.counterTime) / 4;
          double pourcentageorange = (question!.nextQuestion.counterTime) / 2;
          if (counterTime <= pourcentagered) {
            progressBarColor = MyColors.redLight;
          } else if (counterTime <= pourcentageorange) {
            progressBarColor = MyColors.orange;
          } else {
            progressBarColor = MyColors.blue;
          }
        });

        if (counterTime == 0 && !isApiCalled) {
          isApiCalled = true;
          try {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            double latitude = prefs.getDouble('latitude')!;
            double longitude = prefs.getDouble('longitude')!;
            GeoLocation userGeolocation =
                GeoLocation(longitude: longitude, latitude: latitude);
            Answer answer = Answer(
                questionId: question!.nextQuestion.id,
                value: "*",
                answerTime: question!.nextQuestion.counterTime,
                questionTypeId: "",
                score: 0);
            List<Answer> answers = [answer];
            ChallengeAnswerRequest answerRequest = ChallengeAnswerRequest(
                userId: "",
                answerStatus: "",
                score: 0,
                extraTimeUsed: 0,
                spyUsed: 0,
                fiftyUsed: 0,
                deviceConfiguration: "",
                geoLocation: userGeolocation,
                answers: answers);
            print('GeoLocation: ${userGeolocation.toMap()}');
            print('Answer: ${answer.toMap()}');
            print('ChallengeAnswerRequest: ${answerRequest.toMap()}');
            var challengeService = ChallengeService();
            String response = await challengeService.submitChallengeAnswers(
                answerRequest, stepid);

            setState(() {
              answerResponse = response;
              print('answer response data: $answerResponse');
              // if (answerResponse == "0") {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ResponseQuestionChallenge(
                    stepid: stepid,
                    challengeid: challengeid,
                    textQuestion: question!.nextQuestion.title,
                    message: "Dommage",
                    image: const AssetImage('images/pngs/dommage.png'),
                    description: "vous avez perdu\nTemps terminé",
                  ),
                ),
              );
              // }
            });
            cancelTimer();
          } catch (e) {
            print('Failed to submit answer response data: $e');
          }
        }
      },
    );
  }

  Future<void> _loadQuestion() async {
    try {
      var challengeService = ChallengeService();
      ChallengeQuestionResult? loadedQuestion =
          await challengeService.getNextQuestionByStepId(stepid);
      setState(() {
        question = loadedQuestion;
      });
      print("question ${question!.nextQuestion.toMap()}");
      if (question == null) {
        // ignore: use_build_context_synchronously
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => StepOneCoinChallenge(challengeid),
          ),
        );
      } else {
        double remainingTime =
            loadedQuestion!.nextQuestion.counterTime.toDouble();

        startTimer(remainingTime);
        startdate = DateTime.now();
      }
    } catch (e) {
      print('Failed to load next question data: $e');
    }
  }

  Future<void> _submitChallengeAnswer() async {
    try {
      DateTime currentDate = DateTime.now();
      Duration difference = currentDate.difference(startdate);
      // Extract the difference in seconds
      int differenceInSeconds = difference.inSeconds;
      SharedPreferences prefs = await SharedPreferences.getInstance();
      print(prefs.get('latitude'));
      double latitude = prefs.getDouble('latitude')!;

      double longitude = prefs.getDouble('longitude')!;

      print('longitude: $longitude');
      GeoLocation userGeolocation =
          GeoLocation(longitude: longitude, latitude: latitude);
      Answer answer = Answer(
          questionId: question!.nextQuestion.id,
          value: selectedChoice,
          answerTime: differenceInSeconds,
          questionTypeId: "",
          score: 0);

      List<Answer> answers = [answer];
      ChallengeAnswerRequest answerRequest = ChallengeAnswerRequest(
          userId: "",
          answerStatus: "",
          score: 0,
          extraTimeUsed: 0,
          spyUsed: 0,
          fiftyUsed: 0,
          deviceConfiguration: "",
          geoLocation: userGeolocation,
          answers: answers);
      print('GeoLocation: ${userGeolocation.toMap()}');
      print('Answer: ${answer.toMap()}');
      print('ChallengeAnswerRequest: ${answerRequest.toMap()}');

      var challengeService = ChallengeService();
      String response =
          await challengeService.submitChallengeAnswers(answerRequest, stepid);

      setState(() {
        answerResponse = response;
        print('answer response data: $answerResponse');
        // if (answerResponse == "0") {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ResponseQuestionChallenge(
              stepid: stepid,
              challengeid: challengeid,
              textQuestion: question!.nextQuestion.title,
              message: "Bien Joué !",
              image: const AssetImage('images/pngs/Check.png'),
              description: "Vous avez gagné",
            ),
          ),
        );
        isApiCalled = true;
        // }
      });
    } catch (e) {
      print('Failed to submit answer response data: $e');
    }
  }

  void cancelTimer() {
    countdownTimer?.cancel(); // Use null-aware operator to avoid null exception
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var cardHeight = 200.0; // Ajustez la hauteur de la carte selon vos besoins
    //var screenHeight = MediaQuery.of(context).size.height;
    // double ratio = 0.0;
    // // if (question != null) {
    // ratio = 1 - (question!.nextQuestion.counterTime.toDouble() / 60);
    // // }
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: width,
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
                            cancelTimer();
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      StepOneCoinChallenge(challengeid)),
                            );
                          },
                          child: Image.asset(
                            'images/pngs/IconLeft.png',
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 100),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        if (question != null)
                          Text(
                            question!.nextQuestion.title,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 15.0,
                              fontWeight: FontWeight.normal,
                              decoration: TextDecoration.none,
                            ),
                            textAlign: TextAlign.center,
                          )
                        else
                          const CircularProgressIndicator(),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                child: SimpleAnimationProgressBar(
                  reverseAlignment: true,
                  height: 10,
                  width: width,
                  backgroundColor: progressBarColor,
                  foregrondColor: const Color.fromARGB(255, 220, 220, 220),
                  ratio: ratio,
                  direction: Axis.horizontal,
                  curve: Curves.fastLinearToSlowEaseIn,
                  duration: Duration(
                      seconds: (question != null &&
                              question!.nextQuestion != null)
                          ? question!.nextQuestion!.counterTime?.toInt() ?? 0
                          : 0),

                  borderRadius: BorderRadius.circular(10),
                  //   gradientColor: const LinearGradient(
                  //       colors: [MyColors.blue, MyColors.blue]),
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
                      height: cardHeight,
                      width: width - 50,
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
                              if (question != null)
                                Text(
                                  question!.nextQuestion.description,
                                  style: const TextStyle(
                                    fontSize: 17.0,
                                    fontWeight: FontWeight.normal,
                                  ),
                                  textAlign: TextAlign.center,
                                )
                              else
                                const CircularProgressIndicator(),
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
                          onPressed: () {
                            _showDiamondPopup('50/50',
                                'Réduit les choix à deux,\naméliorant les chances\ndu participant de choisir\ncorrectement.');
                          },
                          style: ElevatedButton.styleFrom(
                            fixedSize: const Size(80, 50),
                            backgroundColor: MyColors.yellow,
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
                        const SizedBox(width: 10),
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            fixedSize: const Size(80, 50),
                            backgroundColor: MyColors.yellow,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                          child: Image.asset(
                            'images/pngs/eye.png',
                          ),
                        ),
                        const SizedBox(width: 10),
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            fixedSize: const Size(80, 50),
                            backgroundColor: MyColors.yellow,
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
              if (question != null)
                Column(
                  children: question!.nextQuestion.choices.map((choice) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedChoiceIndex =
                                question!.nextQuestion.choices.indexOf(choice);
                          });
                          selectedChoice =
                              choice.value; // Update the global variable
                        },
                        child: SizedBox(
                          width: width - 50,
                          child: Card(
                            color: selectedChoiceIndex ==
                                    question!.nextQuestion.choices
                                        .indexOf(choice)
                                ? MyColors.yellow.withOpacity(
                                    0.7) // Couleur avec opacité réduite
                                : Colors
                                    .transparent, // Transparent si non sélectionné
                            elevation: 4.0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              side: const BorderSide(
                                color: Colors.white,
                                width: 2.0,
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Text(
                                choice.value,
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
                      ),
                    );
                  }).toList(),
                )
              else
                const CircularProgressIndicator(),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  _submitChallengeAnswer();
                },
                style: ElevatedButton.styleFrom(
                  fixedSize: const Size(150, 30),
                  backgroundColor: MyColors.yellow,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                ),
                child: const Text(
                  'Valider',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.0,
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

  void _showDiamondPopup(String title, String contenu) {
    // YYDialog().build(context)
    //   ..width = 300
    //   ..height = 300
    //   ..widget(DiamondShapeBackground(
    //     width: 300,
    //     height: 300,
    //     child: Column(
    //       mainAxisAlignment: MainAxisAlignment.center,
    //       children: [
    //         Padding(
    //           padding:
    //               const EdgeInsets.only(bottom: 8.0, right: 8.0, left: 8.0),
    //           child: Text(
    //             title,
    //             style: const TextStyle(
    //               fontSize: 20.0,
    //               color: Colors.white,
    //             ),
    //             textAlign: TextAlign.center,
    //           ),
    //         ),
    //         Padding(
    //           padding: const EdgeInsets.all(8.0),
    //           child: Text(
    //             contenu,
    //             style: const TextStyle(
    //               fontSize: 15.0,
    //               color: Colors.white,
    //             ),
    //             textAlign: TextAlign.center,
    //           ),
    //         ),
    //       ],
    //     ),
    //   ))
    //   ..show();
  }

  @override
  void dispose() {
    cancelTimer();
    super.dispose();
  }
}
