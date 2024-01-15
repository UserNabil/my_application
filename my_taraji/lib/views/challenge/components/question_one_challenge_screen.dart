import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_taraji/core/models/challenge_answer_request_model.dart';
import 'package:my_taraji/core/models/joker_extratime_response.dart';
import 'package:my_taraji/core/models/joker_fifty_response.dart';
import 'package:my_taraji/core/models/joker_request.dart';
import 'package:my_taraji/core/models/joker_spy_response.dart';
import 'package:my_taraji/core/models/next_question_model.dart';
import 'package:my_taraji/core/theme/my_color.dart';
import 'package:my_taraji/services/challenge_service.dart';
import 'package:my_taraji/services/joker_service.dart';
import 'package:my_taraji/views/challenge/components/response_last_step_screen.dart';
import 'package:my_taraji/views/challenge/components/response_question_screen.dart';
import 'package:my_taraji/views/challenge/components/response_step_screen.dart';
import 'package:my_taraji/views/challenge/components/step_one_coin_challenge_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_animation_progress_bar/simple_animation_progress_bar.dart';

// void main() {
//   runApp(const MaterialApp(
//     home: QuestionOneCoinChallenge(
//         "659564607428f60708a9be76", "6595376beb16ee594ceb90d8"),
//   ));
// }
// void main() {
//   runApp(const MaterialApp(
//     home: QuestionOneCoinChallenge(
//         "659564607428f60708a9be76", "6595376beb16ee594ceb90d8"),
//   ));
// }

class QuestionOneCoinChallenge extends StatefulWidget {
  final bool lastStep;
  final String stepId;
  final int questionNumber;
  final String challengeId;
  const QuestionOneCoinChallenge(
      this.lastStep, this.stepId, this.questionNumber, this.challengeId,
      {super.key});

  @override
  // ignore: no_logic_in_create_state
  QuestionOneCoinChallengeState createState() => QuestionOneCoinChallengeState(
      laststep: lastStep,
      stepid: stepId,
      questionnumber: questionNumber,
      challengeid: challengeId);
}

class QuestionOneCoinChallengeState extends State<QuestionOneCoinChallenge> {
  final bool laststep;
  final String stepid;
  final int questionnumber;
  final String challengeid;
  bool isLoading = false;
  bool isApiCalled = false;
  int numquestion = 0;
  QuestionOneCoinChallengeState(
      {required this.laststep,
      required this.stepid,
      required this.questionnumber,
      required this.challengeid});
  ChallengeQuestionResult? question;
  List<JokerFiftyResponse>? jokerFifTy;
  JokerExtraTimeResponse? jokerExtraTime;
  JokerSpyResponse? jokerSpy;
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
          double pourcentagered = (question!.nextQuestion!.counterTime) / 4;
          double pourcentageorange = (question!.nextQuestion!.counterTime) / 2;
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
                questionId: question!.nextQuestion!.id,
                value: "*",
                answerTime: question!.nextQuestion!.counterTime,
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
            // print('GeoLocation: ${userGeolocation.toMap()}');
            // print('Answer: ${answer.toMap()}');
            // print('ChallengeAnswerRequest: ${answerRequest.toMap()}');
            var challengeService = ChallengeService();
            String response = await challengeService.submitChallengeAnswers(
                answerRequest, stepid);

            setState(() {
              answerResponse = response;
              if (answerResponse.isNotEmpty) isLoading = false;
              // print('answer response data: $answerResponse');
              // if (answerResponse == "0") {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ResponseQuestionChallenge(
                    laststep: laststep,
                    stepid: stepid,
                    questionnumber: questionnumber,
                    challengeid: challengeid,
                    textQuestion: question!.nextQuestion!.title,
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
            // ignore: avoid_print
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
      if (question!.nextQuestion == null) {
        if (laststep == true) {
          // ignore: use_build_context_synchronously
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ResponseLastStepChallenge(
                message: "Bravo",
                image: 'images/pngs/Star.png',
                description: "Vous avez gagné \nChallenge terminé",
              ),
            ),
          );
        } else {
          // ignore: use_build_context_synchronously
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ResponseStepChallenge(
                challengeid: challengeid,
                message: "Bravo",
                image: const AssetImage('images/pngs/Star.png'),
                description: "Vous avez gagné 80 Coins",
              ),
            ),
          );
        }
      } else {
        // numquestion++;
        // print("questionnumber : $questionnumber");
        // print("numquestion : $numquestion");
        double remainingTime =
            loadedQuestion.nextQuestion!.counterTime.toDouble();

        startTimer(remainingTime);
        startdate = DateTime.now();
      }
    } catch (e) {
      // ignore: avoid_print
      print('Failed to load next question data: $e');
    }
  }

  Future<void> _submitChallengeAnswer() async {
    try {
      setState(() {
        isLoading = true;
      });
      DateTime currentDate = DateTime.now();
      Duration difference = currentDate.difference(startdate);
      int differenceInSeconds = difference.inSeconds;
      SharedPreferences prefs = await SharedPreferences.getInstance();
      double latitude = prefs.getDouble('latitude')!;
      double longitude = prefs.getDouble('longitude')!;
      GeoLocation userGeolocation =
          GeoLocation(longitude: longitude, latitude: latitude);
      Answer answer = Answer(
          questionId: question!.nextQuestion!.id,
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
      // print('GeoLocation: ${userGeolocation.toMap()}');
      // print('Answer: ${answer.toMap()}');
      // print('ChallengeAnswerRequest: ${answerRequest.toMap()}');
      var challengeService = ChallengeService();
      String response =
          await challengeService.submitChallengeAnswers(answerRequest, stepid);
      setState(() {
        answerResponse = response;
        isLoading = false;
        // print('answer response data: $answerResponse');
        // if (answerResponse == "0") {

        // if (numquestion < questionnumber) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ResponseQuestionChallenge(
              laststep: laststep,
              stepid: stepid,
              questionnumber: questionnumber,
              challengeid: challengeid,
              textQuestion: question!.nextQuestion!.title,
              message: "Bien Joué !",
              image: const AssetImage('images/pngs/Check.png'),
              description: "Vous avez gagné",
            ),
          ),
        );
        // }

        isApiCalled = true;
        // }
      });
    } catch (e) {
      // ignore: avoid_print
      print('Failed to submit answer response data: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> useJoker(int joker) async {
    try {
      print("joker $joker");
      JokerRequest jokerRequest =
          JokerRequest(questionId: question!.nextQuestion!.id, stepId: stepid);
      setState(() {
        isLoading = true;
      });

      var jokerService = JokerService();
      String response = await jokerService.useJoker(jokerRequest, joker);
      setState(() {
        String JokerResponse = response;
        print("joker response $JokerResponse");
        if (joker == 0) {
          final dynamic jsonData = json.decode(JokerResponse);
          jokerFifTy = fromJsonListJokerFiftyResponse(jsonData);
        } else if (joker == 1) {
          final Map<String, dynamic> jsonData = json.decode(JokerResponse);
          jokerExtraTime = JokerExtraTimeResponse.fromJson(jsonData);
        } else if (joker == 2) {
          final Map<String, dynamic> jsonData = json.decode(JokerResponse);
          jokerSpy = JokerSpyResponse.fromJson(jsonData);
        }
        print("joker response $jokerFifTy");
        print("joker response ${jokerExtraTime!.toMap()}");
        print("joker response ${jokerSpy!.toMap()}");
        isLoading = false;
      });
    } catch (e) {
      // ignore: avoid_print
      print('Failed to use joker: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  void cancelTimer() {
    countdownTimer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var cardHeight = 200.0;
    double progressBarWidth = max(width - 50, 0.0);

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
                              if (question != null &&
                                  question!.nextQuestion != null)
                                Text(
                                  question!.nextQuestion!.title,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.normal,
                                    decoration: TextDecoration.none,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              // else
                              //   const CircularProgressIndicator(),
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
                        width: progressBarWidth,
                        backgroundColor: progressBarColor,
                        foregrondColor:
                            const Color.fromARGB(255, 220, 220, 220),
                        ratio: ratio,
                        direction: Axis.horizontal,
                        curve: Curves.fastLinearToSlowEaseIn,
                        duration: Duration(
                          seconds: (question != null &&
                                  question!.nextQuestion != null)
                              ? question!.nextQuestion!.counterTime.toInt()
                              : 0,
                        ),
                        borderRadius: BorderRadius.circular(10),
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
                                    if (question != null &&
                                        question!.nextQuestion != null)
                                      Text(
                                        question!.nextQuestion!.description,
                                        style: const TextStyle(
                                          fontSize: 17.0,
                                          fontWeight: FontWeight.normal,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    // else
                                    //   const CircularProgressIndicator(),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 0,
                          right: (width - 310) / 2,
                          child: Row(
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  openMyModal(
                                      '50/50',
                                      'Réduit les choix à deux,améliorant les chancesdu participant de choisir correctement.',
                                      0);
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
                                onPressed: () {
                                  openMyModal(
                                      'images/pngs/eye.png',
                                      'Voir le choix le plus populaire parmis les options proposé.',
                                      2);
                                },
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
                                onPressed: () {
                                  openMyModal(
                                      'images/pngs/watch.png',
                                      'Ralentir le temps qui s\'écoule lors de la partie.',
                                      1);
                                },
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
                    if (question != null && question!.nextQuestion != null)
                      Column(
                        children: question!.nextQuestion!.choices.map((choice) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedChoiceIndex = question!
                                      .nextQuestion!.choices
                                      .indexOf(choice);
                                });
                                selectedChoice =
                                    choice.value; // Update the global variable
                              },
                              child: SizedBox(
                                width: width - 50,
                                child: Card(
                                  color: selectedChoiceIndex ==
                                          question!.nextQuestion!.choices
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
                        onPressed: isLoading
                            ? () => {}
                            : () => _submitChallengeAnswer(),
                        style: ElevatedButton.styleFrom(
                          fixedSize: const Size(150, 30),
                          backgroundColor: MyColors.yellow,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                        ),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            isLoading
                                ? const SizedBox(
                                    width: 10,
                                    height: 10,
                                    child: CircularProgressIndicator(
                                      color: MyColors.white,
                                      strokeAlign: 1.0,
                                    ),
                                  )
                                : Container(),
                            Text(
                              isLoading ? '' : 'Valider',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 14.0,
                              ),
                            ),
                          ],
                        )),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void openMyModal(String title, String contenu, int joker) {
    GlobalKey? dialogKey = GlobalKey();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // ignore: deprecated_member_use
        return WillPopScope(
          onWillPop: () async {
            return true;
          },
          child: jokerDialog(dialogKey, context, title, contenu, joker),
        );
      },
    );
  }

  Widget jokerDialog(GlobalKey? dialogKey, BuildContext context, dynamic title,
      String contenu, int joker) {
    return AlertDialog(
      key: dialogKey,
      actionsAlignment: MainAxisAlignment.center,
      backgroundColor: MyColors.transparent,
      content: Stack(
        children: [
          SvgPicture.asset(
            'images/svgs/popup.svg',
            width: 300,
            height: 300,
          ),
          Positioned(
            top: 30,
            left: 90,
            child: Center(
              child: _buildTitleWidget(title),
            ),
          ),
          Positioned(
            top: 90,
            left: 20,
            width: 200,
            child: Text(
              style: const TextStyle(color: MyColors.white),
              contenu,
              textAlign: TextAlign.center,
            ),
          ),
          Positioned(
            width: 80,
            left: 30,
            bottom: 0,
            child: TextButton(
              style: TextButton.styleFrom(
                alignment: Alignment.center,
              ),
              onPressed: () {
                useJoker(joker);
                Navigator.of(context).pop();
              },
              child: SvgPicture.asset(
                'images/svgs/confirm.svg',
                width: 70,
                height: 70,
              ),
            ),
          ),
          Positioned(
            width: 80,
            right: 30,
            bottom: 0,
            child: TextButton(
              style: TextButton.styleFrom(
                alignment: Alignment.center,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: SvgPicture.asset(
                'images/svgs/return.svg',
                width: 70,
                height: 70,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTitleWidget(dynamic title) {
    if (title is String) {
      return title.contains('.png') ||
              title.contains('.jpg') ||
              title.contains('.jpeg')
          ? SizedBox(
              child: Image.asset(
              title,
              width: 70,
              height: 30,
            ))
          : Text(
              title,
              style: const TextStyle(
                color: MyColors.white,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            );
    } else if (title is Widget) {
      return title;
    } else {
      return Container();
    }
  }

  @override
  void dispose() {
    cancelTimer();
    super.dispose();
  }
}
