import 'package:my_taraji/views/challenge/import.dart';

class ChallengeProvider with ChangeNotifier {
  ChallengeService challengeService = ChallengeService();
  String _page = 'leaderboard';
  final bool _laststep = false;
  ChallengeStep? _currentstep;
  ChallengeById? _challenge;
  ChallengeQuestionResult? _question;
  Timer? _countdownTimer;
  final double _ratio = 0.0;
  final Color _progressBarColor = MyColors.blue;
  bool _isApiCalled = false;
  bool _isLoading = false;
  ChallengeAnswerResponse? _answerResponse;
  final bool _isJokerFiftyButtonDisabled = false;
  bool _isJokerSpyButtonDisabled = false;
  final int _numquestion = 0;
  List<JokerFiftyResponse>? _jokerFifTy;
  JokerExtraTimeResponse? _jokerExtraTime;
  List<JokerSpyResponse>? _jokerSpy;
  final int _selectedChoiceIndex = -1;
  final String _selectedChoice = "";
  late DateTime _startdate;
  List<bool> _isChoiceDisabled = [];
  List<JokerSpyResponse>? _maxPercentageList;
  final bool _isSelected = false;
  final bool _isQuestionDataLoaded = false;

  String get page => _page;
  bool get laststep => _laststep;
  ChallengeStep? get currentstep => _currentstep;
  ChallengeById? get challenge => _challenge;
  ChallengeQuestionResult? get question => _question;
  Timer? get countdownTimer => _countdownTimer;
  double get ratio => _ratio;
  Color get progressBarColor => _progressBarColor;
  bool get isApiCalled => _isApiCalled;
  bool get isLoading => _isLoading;
  ChallengeAnswerResponse? get answerResponse => _answerResponse;
  bool get isJokerFiftyButtonDisabled => _isJokerFiftyButtonDisabled;
  bool get isJokerSpyButtonDisabled => _isJokerSpyButtonDisabled;
  int get numquestion => _numquestion;
  List<JokerFiftyResponse>? get jokerFifTy => _jokerFifTy;
  JokerExtraTimeResponse? get jokerExtraTime => _jokerExtraTime;
  List<JokerSpyResponse>? get jokerSpy => _jokerSpy;
  int get selectedChoiceIndex => _selectedChoiceIndex;
  String get selectedChoice => _selectedChoice;
  DateTime get startdate => _startdate;
  List<bool> get isChoiceDisabled => _isChoiceDisabled;
  List<JokerSpyResponse>? get maxPercentageList => _maxPercentageList;
  bool get isSelected => _isSelected;
  bool get isQuestionDataLoaded => _isQuestionDataLoaded;

  void setIsLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void setIsApiCalled(bool value) {
    _isApiCalled = value;
    notifyListeners();
  }

  void setIsJokerSpyButtonDisabled(bool value) {
    _isJokerSpyButtonDisabled = value;
    notifyListeners();
  }

  void setJokerExtraTime(JokerExtraTimeResponse? value) {
    _jokerExtraTime = value;
    notifyListeners();
  }

  void setJokerSpy(List<JokerSpyResponse>? value) {
    _jokerSpy = value;
    notifyListeners();
  }

  void setMaxPercentageList(List<JokerSpyResponse>? value) {
    _maxPercentageList = value;
    notifyListeners();
  }

  void setIsChoiceDisabled(List<bool> value) {
    _isChoiceDisabled = value;
    notifyListeners();
  }

  void changePage(String page) {
    _page = page;
    notifyListeners();
  }

  void setJokerFifTy(List<JokerFiftyResponse>? value) {
    _jokerFifTy = value;
    notifyListeners();
  }

  Future<ChallengeStep?> loadChallenge(String challengeId) async {
    await challengeService.getChallengeById(challengeId).then((value) {
      _challenge = value.data;
      _currentstep = value.data?.steps.first;
      // notifyListeners();
      // List<ChallengeStep> unfinishedSteps =
      //     _challenge!.steps.where((step) => step.status != "done").toList();
      // if (unfinishedSteps.length == 1) {
      //   _laststep = true;
      // }
      // if (unfinishedSteps.isNotEmpty) {
      //   _currentstep = unfinishedSteps.first;

      //   notifyListeners();
      //   return _currentstep!;
      // }
    });
    return null;
  }

  Future<ChallengeQuestionResult?> loadQuestion(String stepId) async {
    await challengeService.getNextQuestionByStepId(stepId).then((value) {
      _question = value.data;
      double remainingTime =
          _question?.nextQuestion!.counterTime.toDouble() ?? 0.0;

      startTimer(remainingTime, stepId);
      // startdate = DateTime.now();
    });
    return null;
  }

  Future<void> startTimer(double counterTime, String stepId) async {
    // const oneSecond = Duration(seconds: 1);
    // _countdownTimer = Timer.periodic(
    //   oneSecond,
    //   (timer) async {
    //     counterTime--;
    //     _ratio = 1 - (counterTime / 60);
    //     double pourcentagered = (question!.nextQuestion!.counterTime) / 4;
    //     double pourcentageorange = (question!.nextQuestion!.counterTime) / 2;
    //     if (counterTime <= pourcentagered) {
    //       _progressBarColor = MyColors.redLight;
    //     } else if (counterTime <= pourcentageorange) {
    //       _progressBarColor = MyColors.orange;
    //     } else {
    //       _progressBarColor = MyColors.blue;
    //     }

    //     if (counterTime == 0 && !_isApiCalled) {
    //       _isApiCalled = true;
    //       try {
    //         SharedPreferences prefs = await SharedPreferences.getInstance();
    //         double latitude = prefs.getDouble('latitude') ?? 0;
    //         double longitude = prefs.getDouble('longitude') ?? 0;
    //         GeoLocation userGeolocation =
    //             GeoLocation(longitude: longitude, latitude: latitude);
    //         Answer answer = Answer(
    //             questionId: question!.nextQuestion!.id,
    //             value: "",
    //             answerTime: question!.nextQuestion!.counterTime,
    //             questionTypeId: "",
    //             score: 0);
    //         List<Answer> answers = [answer];
    //         ChallengeAnswerRequest answerRequest = ChallengeAnswerRequest(
    //             userId: "",
    //             answerStatus: "",
    //             score: 0,
    //             extraTimeUsed: 0,
    //             spyUsed: 0,
    //             fiftyUsed: 0,
    //             deviceConfiguration: "",
    //             geoLocation: userGeolocation,
    //             answers: answers);
    //         var challengeService = ChallengeService();
    //         ChallengeAnswerResponse? response = await challengeService
    //             .submitChallengeAnswers(answerRequest, stepId)
    //             .then((value) => value.data);
    //         ChallengeQuestionResult? loadedQuestion = await challengeService
    //             .getNextQuestionByStepId(stepId)
    //             .then((value) => value.data);
    //         _answerResponse = response;
    //         if (_answerResponse != null) _isLoading = false;

    //         if (_laststep == false && loadedQuestion!.nextQuestion == null) {
    //           // Navigator.push(
    //           //   context,
    //           //   MaterialPageRoute(
    //           //     builder: (context) => ResponseStepChallenge(
    //           //       challengeid: challengeId,
    //           //       message: "Bravo",
    //           //       image: const AssetImage('images/pngs/Star.png'),
    //           //       description: "Vous avez gagné ${response!.score} points",
    //           //     ),
    //           //   ),
    //           // );
    //         } else if (_laststep == true &&
    //             loadedQuestion!.nextQuestion == null) {
    //           // Navigator.push(
    //           //   context,
    //           //   MaterialPageRoute(
    //           //     builder: (context) => ResponseLastStepChallenge(
    //           //       message: "Bravo",
    //           //       image: 'images/pngs/Star.png',
    //           //       description:
    //           //           "Vous avez gagné ${response!.score} points \nChallenge terminé",
    //           //     ),
    //           //   ),
    //           // );
    //         } else {
    //           // Navigator.push(
    //           //   context,
    //           //   MaterialPageRoute(
    //           //     builder: (context) => ResponseQuestionChallenge(
    //           //       laststep: lastStep,
    //           //       stepid: widget.stepId,
    //           //       questionnumber: widget.questionNumber,
    //           //       challengeid: widget.challengeId,
    //           //       textQuestion: question!.nextQuestion!.title,
    //           //       message: "Dommage",
    //           //       image: const AssetImage('images/pngs/dommage.png'),
    //           //       description: "vous avez perdu\nTemps terminé",
    //           //     ),
    //           //   ),
    //           // );
    //         }
    //         cancelTimer();
    //       } catch (e) {
    //         throw ('Failed to submit answer response data: $e');
    //       }
    //     }
    //   },
    // );
  }

  void cancelTimer() {
    countdownTimer?.cancel();
  }
}
