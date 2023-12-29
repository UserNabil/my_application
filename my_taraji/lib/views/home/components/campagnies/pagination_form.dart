import 'package:flutter/material.dart';
import 'package:my_taraji/core/models/compaign_model.dart';
import 'package:my_taraji/core/theme/my_color.dart';
import 'package:shared_preferences/shared_preferences.dart';

// import 'type/checkbox.dart';
// import 'type/date.dart';
import 'type/email.dart';
import 'type/number.dart';
import 'type/phone.dart';
// import 'type/rating.dart';
// import 'type/smiley.dart';

class PaginationForm extends StatefulWidget {
  const PaginationForm({super.key, required this.campaign});
  final Campaign campaign;

  @override
  PaginationFormState createState() => PaginationFormState();
}

class PaginationFormState extends State<PaginationForm> {
  late List<Widget> _pages = <Widget>[
    // const EmailInput(),
    // const NumberInput(),
    // const PhoneInput(),
    // const ChoiceInput(isRadio: true),
    // const ChoiceInput(isRadio: false),
    // const DateInput(),
    // const SmileyInput(),
    // const RatingInput(maxRating: 5)
  ];
  final PageController _pageController = PageController();
  int _currentPage = 0;
  bool emailValid = false, phoneValid = false;
  // int _totalCount = 0;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _pages = widget.campaign.title == "Email"
        ? <Widget>[
            EmailInput(emailController: emailController),
            const NumberInput()
          ]
        : <Widget>[
            PhoneInput(phoneController: phoneController),
            const NumberInput()
          ];
    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page!.round();
      });
    });
    // _totalCount = _pages.length;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 100,
          width: 300,
          child: PageView(
            controller: _pageController,
            children: _pages,
          ),
        ),
        widget.campaign.title == 'Email'
            ? Text(emailController.text.isNotEmpty
                ? ""
                : "Veuillez renseigner le champs de l'email.")
            : Text(phoneController.text.isNotEmpty
                ? ""
                : "Veuillez renseigner le champs du téléphone."),
        ButtonBar(
          alignment: MainAxisAlignment.center,
          children: [
            _currentPage == 0
                ? ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: MyColors.yellow,
                    ),
                    onPressed: () {
                      if (emailController.text.isNotEmpty) {
                        setState(() {
                          emailValid =
                              RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                  .hasMatch(emailController.text);
                        });
                      }
                      if (phoneController.text.isNotEmpty) {
                        setState(() {
                          phoneValid = RegExp(r"^[0-9]{8}$")
                              .hasMatch(phoneController.text);
                        });
                      }
                      emailController.text.isNotEmpty ||
                              phoneController.text.isNotEmpty
                          ? _pageController.nextPage(
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.ease,
                            )
                          : null;
                    },
                    child: const Text(
                      'Envoyer',
                      style: TextStyle(color: MyColors.white),
                    ),
                  )
                : ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: MyColors.yellow,
                    ),
                    onPressed: () {
                      showCongratulationsModal(context);
                    },
                    child: const Text(
                      'Vérifier',
                      style: TextStyle(color: MyColors.white),
                    ),
                  ),
          ],
        ),
      ],
    );
  }

  void _updateCurrentPage(int increment) {
    setState(() {
      _currentPage += increment;
    });
  }

  void showCongratulationsModal(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // ignore: use_build_context_synchronously
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Félicitations!',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Vous avez gagné ${widget.campaign.score} coins.',
                style: const TextStyle(fontSize: 16.0),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: MyColors.redLight,
                ),
                onPressed: () {
                  int coins = int.parse(prefs.getString('coins')!);
                  int xp = int.parse(prefs.getString('xp')!);
                  coins += int.parse(widget.campaign.score);
                  xp += 50;
                  prefs.setString('coins', coins.toString());
                  prefs.setString('xp', xp.toString());
                  prefs.setBool(widget.campaign.id, false);
                  Navigator.pushNamed(context, "/");
                },
                child: const Text(
                  'OK',
                  style: TextStyle(color: MyColors.white),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

// void BottonBarChildren() {
  // var _totalCount;
  // var _currentPage;
  // var children = [
  //   _totalCount > 1
  //       ? ElevatedButton(
  //           onPressed: _currentPage > 0
  //               ? () {
  //                   var _pageController;
  //                   _pageController.previousPage(
  //                     duration: const Duration(milliseconds: 500),
  //                     curve: Curves.ease,
  //                   );
  //                   // _updateCurrentPage(-1);
  //                 }
  //               : null,
  //           child: const Text(
  //             '<',
  //             style: TextStyle(color: MyColors.white),
  //           ),
  //         )
  //       : Container(),
  //   _currentPage == _totalCount - 1
  //       ? ElevatedButton(
  //           style: ElevatedButton.styleFrom(
  //             backgroundColor: MyColors.yellow,
  //           ),
  //           onPressed: _currentPage == _totalCount - 1
  //               ? () {
  //                   // showCongratulationsModal(context);
  //                 }
  //               : null,
  //           child: const Text(
  //             'Envoyer',
  //             style: TextStyle(color: MyColors.white),
  //           ),
  //         )
  //       : ElevatedButton(
  //           onPressed: _currentPage < _totalCount - 1
  //               ? () {
  //                   // _pageController.nextPage(
  //                   //   duration: const Duration(milliseconds: 500),
  //                   //   curve: Curves.ease,
  //                   // );
  //                   // _updateCurrentPage(1);
  //                 }
  //               : null,
  //           child: const Text(
  //             '>',
  //             style: TextStyle(color: MyColors.white),
  //           ),
  //         )
  // ];
// }
