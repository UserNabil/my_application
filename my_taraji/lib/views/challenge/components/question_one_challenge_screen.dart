// ignore_for_file: use_build_context_synchronously, avoid_print, duplicate_ignore

import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_taraji/core/models/api_response_model.dart';
import 'package:my_taraji/core/models/challenge_answer_request_model.dart';
import 'package:my_taraji/core/models/challenge_answer_response_model.dart';
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
  bool isJokerFiftyButtonDisabled = false;
  bool isJokerSpyButtonDisabled = false;
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
  List<JokerSpyResponse>? jokerSpy;
  ChallengeAnswerResponse? answerResponse;
  int selectedChoiceIndex = -1;
  String selectedChoice = "";
  double ratio = 0.0;
  Color progressBarColor = MyColors.blue;
  Timer? countdownTimer;
  late DateTime startdate;
  List<bool> isChoiceDisabled = [];
  List<JokerSpyResponse>? maxPercentageList;
  bool isSelected = false;
  bool isQuestionDataLoaded = false;
  @override
  void initState() {
    super.initState();
    _loadQuestion();
  }

  // Future<bool> initBuilder() async {
  //   bool questionresult = await _loadQuestion();
  //   if (questionresult) {
  //     return true;
  //   } else {
  //     return false;
  //   }
  // }

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
            double latitude = prefs.getDouble('latitude') ?? 0;
            double longitude = prefs.getDouble('longitude') ?? 0;
            GeoLocation userGeolocation =
                GeoLocation(longitude: longitude, latitude: latitude);
            Answer answer = Answer(
                questionId: question!.nextQuestion!.id,
                value: "",
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
            ChallengeAnswerResponse? response = await challengeService
                .submitChallengeAnswers(answerRequest, stepid)
                .then((value) => value.data);
            ChallengeQuestionResult? loadedQuestion = await challengeService
                .getNextQuestionByStepId(stepid)
                .then((value) => value.data);
            setState(() {
              answerResponse = response;
              if (answerResponse != null) isLoading = false;

              if (laststep == false && loadedQuestion!.nextQuestion == null) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ResponseStepChallenge(
                      challengeid: challengeid,
                      message: "Bravo",
                      image: const AssetImage('images/pngs/Star.png'),
                      description: "Vous avez gagné ${response!.score} points",
                    ),
                  ),
                );
              } else if (laststep == true &&
                  loadedQuestion!.nextQuestion == null) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ResponseLastStepChallenge(
                      message: "Bravo",
                      image: 'images/pngs/Star.png',
                      description:
                          "Vous avez gagné ${response!.score} points \nChallenge terminé",
                    ),
                  ),
                );
              } else {
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
              }
            });
            cancelTimer();
            // ignore: duplicate_ignore
          } catch (e) {
            print('Failed to submit answer response data: $e');
          }
        }
      },
    );
  }

  Future<bool> _loadQuestion() async {
    try {
      if (!isQuestionDataLoaded) {
        var challengeService = ChallengeService();
        ChallengeQuestionResult? loadedQuestion = await challengeService
            .getNextQuestionByStepId(stepid)
            .then((value) => value.data);

        if (loadedQuestion != null) {
          double remainingTime =
              loadedQuestion.nextQuestion!.counterTime.toDouble();

          startTimer(remainingTime);
          startdate = DateTime.now();

          setState(() {
            question = loadedQuestion;
            isQuestionDataLoaded = true;
          });
        }
      }
      return isQuestionDataLoaded;
      // }
    } catch (e) {
      // ignore: avoid_print
      print('Failed to load next question data: $e');
      return false;
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
      double latitude = prefs.getDouble('latitude') ?? 0;
      double longitude = prefs.getDouble('longitude') ?? 0;
      GeoLocation userGeolocation =
          GeoLocation(longitude: longitude, latitude: latitude);

      Answer answer = Answer(
        questionId: question!.nextQuestion!.id,
        value: selectedChoice,
        answerTime: differenceInSeconds,
        questionTypeId: "",
        score: 0,
      );

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
        answers: answers,
      );

      var challengeService = ChallengeService();
      ChallengeAnswerResponse? response = await challengeService
          .submitChallengeAnswers(answerRequest, stepid)
          .then((value) => value.data);

      // Move the asynchronous part outside setState
      await _handleResponse(response);

      // Update state with synchronous code
      setState(() {
        isLoading = false;
        isApiCalled = true;
      });
    } catch (e) {
      print('Failed to submit answer response data: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> _handleResponse(ChallengeAnswerResponse? response) async {
    try {
      // Handle your asynchronous code here
      print('answer response data: ${response!.toMap()}');

      var challengeService = ChallengeService();
      ChallengeQuestionResult? loadedQuestion = await challengeService
          .getNextQuestionByStepId(stepid)
          .then((value) => value.data);
      Answer currentquestionresponse = response.answers
          .where((answer) => answer.questionId == question!.nextQuestion!.id)
          .first;
      if (laststep == false && loadedQuestion!.nextQuestion == null) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ResponseStepChallenge(
              challengeid: challengeid,
              message: "Bravo",
              image: const AssetImage('images/pngs/Star.png'),
              description: "Vous avez gagné ${response.score} points",
            ),
          ),
        );
      } else if (laststep == true && loadedQuestion!.nextQuestion == null) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ResponseLastStepChallenge(
              message: "Bravo",
              image: 'images/pngs/Star.png',
              description:
                  "Vous avez gagné ${response.score} points \nChallenge terminé",
            ),
          ),
        );
      } else if (currentquestionresponse.score != 0) {
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
      } else if (currentquestionresponse.score == 0) {
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
              description: "vous avez perdu",
            ),
          ),
        );
      }
    } catch (e) {
      print('Failed to handle response: $e');
    }
  }

  Future<void> useJoker(int joker) async {
    try {
      // ignore: avoid_print
      print("joker $joker");
      JokerRequest jokerRequest =
          JokerRequest(questionId: question!.nextQuestion!.id, stepId: stepid);
      setState(() {
        isLoading = true;
      });
      var jokerService = JokerService();
      String response = await jokerService.useJoker(jokerRequest, joker);
      setState(() {
        // ignore: non_constant_identifier_names
        String JokerResponse = response;

        if (joker == 0) {
          final dynamic jsonData = json.decode(JokerResponse);
          APIResponseModel<List<JokerFiftyResponse>> resultApi =
              APIResponseModel<List<JokerFiftyResponse>>.fromJson(
                  jsonData, (data) => fromJsonListJokerFiftyResponse(data));
          if (resultApi.isSuccess == true) {
            jokerFifTy = resultApi.data;
            if (question != null && question!.nextQuestion != null) {
              List<ChallengeQuestionChoiceItem> choices =
                  question!.nextQuestion!.choices;

              isChoiceDisabled = List.generate(
                choices.length,
                (index) =>
                    jokerFifTy != null &&
                    jokerFifTy!.any((joker) => joker.id == choices[index].id),
              );
              print("isChoiceDisabled $isChoiceDisabled");
            }
          } else {
            isJokerFiftyButtonDisabled = true;
            showSnackBar(
                'Vous avez utilisé tous les jokers Fifty', MyColors.red);
          }
        } else if (joker == 1) {
          final Map<String, dynamic> jsonData = json.decode(JokerResponse);
          APIResponseModel<JokerExtraTimeResponse> resultApi =
              APIResponseModel<JokerExtraTimeResponse>.fromJson(
                  jsonData, (data) => JokerExtraTimeResponse.fromJson(data));
          if (resultApi.isSuccess == true) {
            jokerExtraTime = resultApi.data;
          } else {
            showSnackBar(
                'Vous avez utilisé tous les jokers ExtraTime', MyColors.red);
          }
        } else if (joker == 2) {
          final Map<String, dynamic> jsonData = json.decode(JokerResponse);
          APIResponseModel<List<JokerSpyResponse>> resultApi =
              APIResponseModel<List<JokerSpyResponse>>.fromJson(
                  jsonData, (data) => fromJsonListJokerSpyResponse(data));
          if (resultApi.isSuccess == true) {
            jokerSpy = resultApi.data;
            int? maxPercentage = jokerSpy?.fold<int?>(
              null,
              (int? max, element) => max == null || element.percentage > max
                  ? element.percentage
                  : max,
            );
            if (maxPercentage != null) {
              maxPercentageList = jokerSpy!
                  .where((element) => element.percentage == maxPercentage)
                  .toList();
              for (var i in maxPercentageList!) {
                print(
                    "Liste d'éléments avec le pourcentage maximum : ${i.toMap()}");
              }
              if (maxPercentage == 0) {
                maxPercentageList = [];
                // Affichez votre popup avec le message approprié
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      backgroundColor: MyColors.yellow,
                      title: const Text(
                        "Désolé",
                        style: TextStyle(color: MyColors.red),
                      ),
                      content: const Text(
                          style: TextStyle(color: MyColors.white),
                          "Vous êtes le premier joueur, vous ne pouvez pas utiliser le joker."),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text(
                            "OK",
                            style: TextStyle(color: MyColors.red),
                          ),
                        ),
                      ],
                    );
                  },
                );
              }
            }
          } else {
            isJokerSpyButtonDisabled = true;
            showSnackBar('Vous avez utilisé tous les jokers Spy', MyColors.red);
          }
        }
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
    return isQuestionDataLoaded
        ? buildContent(context)
        : const Center(
            child: CircularProgressIndicator(
            color: MyColors.yellow,
          ));
  }

  Widget buildContent(BuildContext context) {
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
                                onPressed: isJokerFiftyButtonDisabled
                                    ? null
                                    : () {
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
                                onPressed: isJokerSpyButtonDisabled
                                    ? null
                                    : () {
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
                        children: question!.nextQuestion!.choices
                            .asMap()
                            .entries
                            .map((entry) {
                          int index = entry.key;
                          ChallengeQuestionChoiceItem choice = entry.value;
                          bool isDisabled = isChoiceDisabled.isNotEmpty &&
                              !isChoiceDisabled[index];
                          if (maxPercentageList != null) {
                            isSelected = maxPercentageList!.any(
                                (element) => element.choiceId == choice.id);
                          }
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: GestureDetector(
                              onTap: () {
                                if (!isDisabled) {
                                  setState(() {
                                    selectedChoiceIndex = index;
                                  });
                                  selectedChoice = choice.value;
                                }
                              },
                              child: SizedBox(
                                width: width - 50,
                                child: Card(
                                  color: isDisabled
                                      ? Colors.grey.withOpacity(0.7)
                                      : selectedChoiceIndex ==
                                              question!.nextQuestion!.choices
                                                  .indexOf(choice)
                                          ? MyColors.yellow.withOpacity(0.7)
                                          : Colors.transparent,
                                  elevation: 4.0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                    side: BorderSide(
                                      color: isSelected
                                          ? MyColors.yellow
                                          : Colors
                                              .white, // Change the border color here
                                      width: 2.0,
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Text(
                                      choice.value,
                                      style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold,
                                        color: isDisabled
                                            ? Colors.grey
                                            : Colors.white,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    // else
                    //   const CircularProgressIndicator(),
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
            width: 110,
            top: 50,
            left: 150 / 2,
            child: _buildTitleWidget(title),
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
                // disableUnselectedChoices();
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
              width: 60,
              height: 30,
            ))
          : Center(
              child: Text(
                title,
                style: const TextStyle(
                  color: MyColors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
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

  void showSnackBar(String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: color,
        duration: const Duration(seconds: 5),
        action: SnackBarAction(
          backgroundColor: MyColors.white,
          textColor: MyColors.black,
          label: 'Fermer',
          onPressed: () {},
        ),
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(20),
      ),
    );
  }
}
