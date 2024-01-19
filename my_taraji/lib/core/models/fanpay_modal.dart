import 'package:flutter_svg/svg.dart';
import 'package:my_taraji/views/home/import.dart';

class FanPayAction {
  Icon icon;
  Function onTap;

  FanPayAction({required this.icon, required this.onTap});
}

class FanPayModal {
  String title;
  Widget content;
  String? topModalSvg;

  FanPayModal({required this.title, required this.content});

  setTitle(String text) {
    title = text;
  }

  setTopModalSvg(String? svg) {
    topModalSvg = svg;
  }

  show(BuildContext context, Function setModalStat, FanPayAction? action) {
    setModalStat();

    Widget contentModal(context) {
      return Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.15,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              color: Colors.transparent,
            ),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                      setModalStat();
                    },
                    child: const Icon(
                      size: 25,
                      TablerIcons.arrow_left,
                      color: MyColors.white,
                    ),
                  ),
                  Text(
                    title,
                    style: const TextStyle(
                      color: MyColors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: action?.icon ??
                        const SizedBox(
                          height: 22,
                          width: 22,
                        ),
                  ),
                ],
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.85,
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(32),
                    topRight: Radius.circular(32),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    topModalSvg != null
                        ? SvgPicture.asset(
                            topModalSvg!,
                            height: 5,
                            width: 5,
                          )
                        : SvgPicture.asset(
                            'images/icons/drag.svg',
                            height: 5,
                            width: 5,
                          ),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.80,
                      width: MediaQuery.of(context).size.width,
                      decoration: const BoxDecoration(
                        color: Colors.transparent,
                      ),
                      child: SingleChildScrollView(child: content),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      );
    }

    showModalBottomSheet(
      enableDrag: false,
      useRootNavigator: true,
      barrierColor: Colors.black.withOpacity(0),
      isDismissible: false,
      scrollControlDisabledMaxHeightRatio: 1,
      backgroundColor: Colors.transparent,
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
          return topModalSvg != null ? Container() : contentModal(context);
        });
      },
    );
  }
}
