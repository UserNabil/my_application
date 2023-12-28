import 'package:flutter/material.dart';
import 'package:my_taraji/core/theme/my_color.dart';

// import 'type/checkbox.dart';
// import 'type/date.dart';
import 'type/email.dart';
// import 'type/number.dart';
import 'type/phone.dart';
// import 'type/rating.dart';
// import 'type/smiley.dart';

class PaginationForm extends StatefulWidget {
  const PaginationForm({super.key, required this.title});
  final String title;

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
  int _totalCount = 0;

  @override
  void initState() {
    super.initState();
    _pages = <Widget>[
      widget.title == "Email" ? const EmailInput() : const PhoneInput(),
    ];
    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page!.round();
      });
    });
    _totalCount = _pages.length;
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
        ButtonBar(
          alignment: MainAxisAlignment.center,
          children: [
            _totalCount > 1
                ? ElevatedButton(
                    onPressed: _currentPage > 0
                        ? () {
                            _pageController.previousPage(
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.ease,
                            );
                            _updateCurrentPage(-1);
                          }
                        : null,
                    child: const Text(
                      '<',
                      style: TextStyle(color: MyColors.white),
                    ),
                  )
                : Container(),
            _currentPage == _totalCount - 1
                ? ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: MyColors.yellow,
                    ),
                    onPressed: _currentPage == _totalCount - 1
                        ? () {
                            showCongratulationsModal(context);
                          }
                        : null,
                    child: const Text(
                      'Envoyer',
                      style: TextStyle(color: MyColors.white),
                    ),
                  )
                : ElevatedButton(
                    onPressed: _currentPage < _totalCount - 1
                        ? () {
                            _pageController.nextPage(
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.ease,
                            );
                            _updateCurrentPage(1);
                          }
                        : null,
                    child: const Text(
                      '>',
                      style: TextStyle(color: MyColors.white),
                    ),
                  )
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

  void showCongratulationsModal(BuildContext context) {
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
              const Text(
                'Votre demande sera traitée dans les brefs délais.',
                style: TextStyle(fontSize: 16.0),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: MyColors.redLight,
                ),
                onPressed: () {
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
