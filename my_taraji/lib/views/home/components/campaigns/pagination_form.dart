import 'package:flutter/material.dart';
// import 'package:my_taraji/core/models/campaign_response.dart';
import 'package:my_taraji/core/models/compaign_model.dart';
import 'package:my_taraji/core/theme/my_color.dart';
import 'type/email.dart';
import 'type/number.dart';
import 'type/phone.dart';
import 'type/socialmedia.dart';

class PaginationForm extends StatefulWidget {
  const PaginationForm({super.key, required this.campaign});
  final Campaign campaign;

  @override
  PaginationFormState createState() => PaginationFormState();
}

class PaginationFormState extends State<PaginationForm> {
  late List<Widget> pages = <Widget>[];
  final PageController pageController = PageController();
  int currentPage = 0;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  late bool isFormValid = false;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    pages = manageInput();

    pageController.addListener(() {
      setState(() {
        currentPage = pageController.page!.round();
      });
    });
  }

  List<Widget> manageInput() {
    List<Widget> pages = [];

    if (widget.campaign.questionCampaign != null) {
      for (var question in widget.campaign.questionCampaign!) {
        switch (question.questionType) {
          case "email-verification":
            pages.add(EmailInput(emailController: emailController));
            break;
          case "socialmediaaction":
            pages.add(const SocialMediaInput());
            break;
          case "number-verification":
            pages.add(PhoneInput(phoneController: phoneController));
            break;
          case "number":
            pages.add(NumberInput(
              campaign: widget.campaign,
            ));
            break;
          default:
            pages.add(Container());
        }
      }
    }

    return pages;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          SizedBox(
            height: 100,
            width: 300,
            child: PageView(
              controller: pageController,
              children: pages,
            ),
          ),
          myBottomBar(
              currentPage, pages, updateCurrentPage, isFormValid, formKey),
        ],
      ),
    );
  }

  void updateCurrentPage(int increment) {
    setState(() {
      currentPage += increment;
      pageController.animateToPage(
        currentPage,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    });
  }

  Future submitForm() async {
    // CampaignResponse response = CampaignResponse(campaignId: widget.campaign.id, userId: userId, answerId: answerId, status: status, progress: progress, addressIp: addressIp, deviceConfiguration: deviceConfiguration, geoLocation: geoLocation, score: score, answers: answers);
    // Map<String, dynamic> answers = {
    //   "campaignId": widget.campaign.id,
    //   "userId": "1",
    //   "answerId": "1",
    //   "status": "1",
    //   "progress": "1",
    //   "addressIp": "1",
    //   "deviceConfiguration": "1",
    //   "geoLocation": {
    //     "longitude": 1.0,
    //     "latitude": 1.0,
    //   },
    //   "score": 1,
    //   "answers": [
    //     {
    //       "questionId": "1",
    //       "answer": "1",
    //     },
    //   ],
    // };
  }
}

Widget myBottomBar(
  int currentPage,
  List<Widget> pages,
  Function updateCurrentPage,
  bool isFormValid,
  GlobalKey<FormState> formKey,
) {
  return ButtonBar(
    alignment: MainAxisAlignment.center,
    children: [
      if (currentPage > 0)
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: MyColors.yellow,
          ),
          onPressed: () {
            updateCurrentPage(-1);
          },
          child: const Text(
            '<',
            style: TextStyle(color: MyColors.white),
          ),
        ),
      if (currentPage < pages.length - 1)
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: MyColors.yellow,
          ),
          onPressed: () {
            if (formKey.currentState!.validate()) {
              updateCurrentPage(1);
            }
          },
          child: const Text(
            '>',
            style: TextStyle(color: MyColors.white),
          ),
        ),
      if (currentPage == pages.length - 1)
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: MyColors.yellow,
          ),
          onPressed: () {
            if (formKey.currentState!.validate()) {
              // ignore: avoid_print
              print(formKey.currentWidget.toString());
            }
          },
          child: const Text(
            'Envoyer',
            style: TextStyle(color: MyColors.white),
          ),
        ),
    ],
  );
}
