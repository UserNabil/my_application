import 'package:my_taraji/views/home/components/campaigns/type/smiley.dart';
import 'package:my_taraji/views/home/provider/home_provider.dart';

import '../../../import.dart';

Answer createAnswer(String questionId, String questionTypeId, String value) {
  QuestionAnswer questionAnswer = QuestionAnswer(value: value);
  return Answer(
    questionId: questionId,
    questionTypeId: questionTypeId,
    questionAnswers: [questionAnswer],
  );
}

Future<CampaignResponse> submitForm({
  required List<Widget> pages,
  required Campaign campaign,
}) async {
  final prefs = await SharedPreferences.getInstance();
  List<Answer> answers = pages.map((element) {
    var index = pages.indexOf(element);
    return element is EmailInput
        ? createAnswer(campaign.questionCampaign![index].id,
            campaign.questionCampaign![index].questionType, element.value)
        : element is SocialMediaInput
            ? createAnswer(campaign.questionCampaign![index].id,
                campaign.questionCampaign![index].questionType, "")
            : element is PhoneInput
                ? createAnswer(
                    campaign.questionCampaign![index].id,
                    campaign.questionCampaign![index].questionType,
                    element.phoneController.text)
                : element is NumberInput
                    ? createAnswer(
                        campaign.questionCampaign![index].id,
                        campaign.questionCampaign![index].questionType,
                        element.numberController.text)
                    : element is TextareaInput
                        ? createAnswer(
                            campaign.questionCampaign![index].id,
                            campaign.questionCampaign![index].questionType,
                            element.textareaController.text)
                        : element is DateInput
                            ? createAnswer(
                                campaign.questionCampaign![index].id,
                                campaign.questionCampaign![index].questionType,
                                element.dateController.text)
                            : element is RateInput
                                ? createAnswer(
                                    campaign.questionCampaign![index].id,
                                    campaign
                                        .questionCampaign![index].questionType,
                                    element.rateController.text)
                                : element is SelectInput
                                    ? createAnswer(
                                        campaign.questionCampaign![index].id,
                                        campaign.questionCampaign![index]
                                            .questionType,
                                        element.selectController.text)
                                    : element is FormWithImage
                                        ? createAnswer(
                                            campaign
                                                .questionCampaign![index].id,
                                            campaign.questionCampaign![index]
                                                .questionType,
                                            element
                                                .formWithImageController.text)
                                        : element is RadioInput
                                            ? createAnswer(
                                                campaign
                                                    .questionCampaign![index]
                                                    .id,
                                                campaign
                                                    .questionCampaign![index]
                                                    .questionType,
                                                element.radioController.text)
                                            : element is FormulaInput
                                                ? createAnswer(
                                                    campaign
                                                        .questionCampaign![
                                                            index]
                                                        .id,
                                                    campaign
                                                        .questionCampaign![
                                                            index]
                                                        .questionType,
                                                    element
                                                        .formulaController.text)
                                                : Answer(
                                                    questionId: "",
                                                    questionTypeId: "",
                                                    questionAnswers: []);
  }).toList();

  GeoLocation geoLocation = GeoLocation(
    latitude: prefs.getDouble('latitude')!,
    longitude: prefs.getDouble('longitude')!,
  );

  DeviceConfiguration deviceConfiguration = DeviceConfiguration(
    androidId: "",
    apiLevel: 0,
    batteryLevel: 0.0,
    deviceId: "",
    deviceName: "",
    firstInstallTime: 0,
    fontScale: 0.0,
    freeDiskStorage: 0,
    hardware: "",
    ipAddress: "",
    macAddress: "",
    manufacturer: "",
    model: "",
    powerState: PowerState(
      lowPowerMode: false,
      batteryState: "",
      batteryLevel: 0.0,
    ),
    readableVersion: "",
    systemName: "",
    systemVersion: "",
    totalDiskCapacity: 0,
    totalMemory: 0,
    uniqueId: "",
    usedMemory: 0,
    userAgent: "",
    version: "",
    notch: false,
    emulator: false,
    tablet: false,
  );

  final CampaignResponse response = CampaignResponse(
    campaignId: campaign.id,
    userId: prefs.getString('id') ?? "",
    answerId: "",
    status: "done",
    progress: "100",
    addressIp: "",
    deviceConfiguration: deviceConfiguration,
    geoLocation: geoLocation,
    score: campaign.rewardCoins,
    // rewards: Reward(coins: campaign.rewardCoins, maxRep: 1, givenRep: 0),
    answers: answers,
  );

  return response;
}

List<Widget> manageInput(Campaign campaign) {
  TextEditingController email = TextEditingController();
  TextEditingController emailVerified = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController number = TextEditingController();
  TextEditingController textarea = TextEditingController();
  TextEditingController datepicker = TextEditingController();
  TextEditingController radio = TextEditingController();
  TextEditingController rate = TextEditingController();
  TextEditingController select = TextEditingController();
  TextEditingController formWithImage = TextEditingController();
  TextEditingController calculated = TextEditingController();
  TextEditingController smiley = TextEditingController();

  List<Widget> pages = [];
  Map<String, QuestionCampaign> questionTypeToOptions = {};
  if (campaign.questionCampaign != null) {
    for (var question in campaign.questionCampaign!) {
      questionTypeToOptions[question.questionType] = question;
    }
  }

  Map<String, Widget> questionTypeWidgets = {
    "email-verification": EmailInput(
      campaign: campaign,
      value: email.text,
    ),
    "email-verified": NumberInput(
      campaign: campaign,
      numberController: emailVerified,
    ),
    "socialmediaaction": const SocialMediaInput(),
    "number-verification": PhoneInput(
      campaign: campaign,
      phoneController: phone,
    ),
    "number-verified": PhoneInput(
      campaign: campaign,
      phoneController: phone,
    ),
    "number": NumberInput(
      campaign: campaign,
      numberController: number,
    ),
    "textarea": TextareaInput(
      campaign: campaign,
      textareaController: textarea,
    ),
    "datePicker": DateInput(
      campaign: campaign,
      dateController: datepicker,
    ),
    "rating": RateInput(
      campaign: campaign,
      rateController: rate,
      question: questionTypeToOptions['rating'],
    ),
    "toggle": RadioInput(
      campaign: campaign,
      radioController: radio,
      question: questionTypeToOptions['toggle'],
    ),
    "select": SelectInput(
      campaign: campaign,
      selectController: select,
      question: questionTypeToOptions['select'],
    ),
    "lead-generation": FormWithImage(
      campaign: campaign,
      formWithImageController: formWithImage,
      question: questionTypeToOptions['lead-generation'],
    ),
    "calculated": FormulaInput(
      campaign: campaign,
      formulaController: calculated,
      question: questionTypeToOptions['calculated'],
    ),
    "smiley": SmileyInput(
      campaign: campaign,
      smileyController: smiley,
      question: questionTypeToOptions['smiley'],
    ),
  };

  if (campaign.questionCampaign != null) {
    for (var question in campaign.questionCampaign!) {
      Widget page = questionTypeWidgets[question.questionType] ?? Container();
      pages.add(page);
    }
  }

  return pages;
}

void openDialog(BuildContext context, Campaign campaign) {
  GlobalKey<State> dialogKey = GlobalKey<State>();
  showDialog(
    context: context,
    builder: (BuildContext context) {
      // ignore: deprecated_member_use
      return WillPopScope(
        onWillPop: () async {
          return true;
        },
        child: campaignDialog(campaign, dialogKey, context),
      );
    },
  );
}

Widget campaignDialog(
    Campaign campaign, GlobalKey? dialogKey, BuildContext context) {
  return AlertDialog(
    key: dialogKey,
    actionsAlignment: MainAxisAlignment.center,
    backgroundColor: MyColors.red,
    icon: const Icon(
      TablerIcons.check,
      color: MyColors.yellow,
    ),
    title: const Text(
      style: TextStyle(color: MyColors.white),
      'Félicitations !',
    ),
    content: Text(
      style: const TextStyle(color: MyColors.white),
      'Vous avez gagné ${campaign.rewardCoins} coins !',
    ),
    actions: [
      TextButton(
        style: TextButton.styleFrom(
          alignment: Alignment.center,
          backgroundColor: MyColors.yellow,
        ),
        onPressed: () {
          context.read<HomeProvider>().getUserData();
          Navigator.of(context).pop();
        },
        child: const Text(
          style: TextStyle(color: MyColors.white),
          'OK',
        ),
      ),
    ],
  );
}

showMySnackBar(String message, Color color, BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      backgroundColor: color,
      duration: const Duration(seconds: 5),
      action: SnackBarAction(
        backgroundColor: MyColors.white,
        textColor: MyColors.black,
        label: 'x',
        onPressed: () {},
      ),
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.all(20),
    ),
  );
}
