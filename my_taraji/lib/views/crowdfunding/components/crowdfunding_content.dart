import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:my_taraji/core/theme/my_color.dart';
import 'package:my_taraji/core/theme/style.dart';
import 'package:my_taraji/views/fanpay/components/don/manage_content.dart';
import 'package:my_taraji/views/home/models/crowdfunding.dart';
import 'package:simple_animation_progress_bar/simple_animation_progress_bar.dart';

class CrowdFundContent extends StatelessWidget {
  const CrowdFundContent({super.key, required this.crowdfunding});
  final Crowdfunding? crowdfunding;

  show(BuildContext context, Widget content) {
    showModalBottomSheet(
      // enableDrag: false,
      useRootNavigator: true,
      // barrierColor: Colors.black.withOpacity(0),
      isDismissible: false,
      scrollControlDisabledMaxHeightRatio: 1,
      backgroundColor: Colors.transparent,
      context: context,
      builder: (BuildContext context) {
        // ignore: deprecated_member_use
        return WillPopScope(
          onWillPop: () async {
            return true;
          },
          child: content,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              "images/pngs/crowdfunding_background2.jpg",
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: buildContent(context),
      ),
    );
  }

  Widget buildProgressElement(IconData icon, String text) {
    return Column(
      children: [
        Icon(
          icon,
          color: Colors.white,
          size: 30,
        ),
        Text(
          text,
          style: stylePrimary.copyWith(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  Widget buildParticipateButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          width: 150,
          decoration: BoxDecoration(
            color: MyColors.yellow,
            borderRadius: BorderRadius.circular(10),
            boxShadow: const [
              BoxShadow(
                color: Color.fromARGB(97, 0, 0, 0),
                spreadRadius: 5,
                blurRadius: 5,
                offset: Offset(0, 0),
              ),
            ],
          ),
          child: InkWell(
            onTap: () {
              show(
                context,
                const ManageDonPage(),
              );
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  TablerIcons.heart_filled,
                  color: MyColors.white,
                  size: 26,
                ),
                const SizedBox(width: 10),
                Text(
                  'Participer',
                  style: stylePrimary.copyWith(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(10),
          width: 50,
          decoration: BoxDecoration(
            color: MyColors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: const [
              BoxShadow(
                color: Color.fromARGB(97, 0, 0, 0),
                spreadRadius: 5,
                blurRadius: 5,
                offset: Offset(0, 0),
              ),
            ],
          ),
          child: InkWell(
            onTap: () {
              show(
                context,
                const ManageDonPage(),
              );
            },
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  TablerIcons.send,
                  color: MyColors.yellow,
                  size: 26,
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget buildContent(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.4),
        borderRadius: BorderRadius.circular(20),
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 60),
            Text(
              "Ensemble, nous pouvons faire la différence",
              style: stylePrimary.copyWith(
                fontSize: 24,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 20),
            Stack(
              alignment: Alignment.center,
              children: [
                const SizedBox(width: 250, height: 250),
                Positioned(
                  child: Container(
                    width: 200,
                    height: 200,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      image: const DecorationImage(
                        image: AssetImage(
                            "images/pngs/crowdfunding_background2.jpg"),
                        fit: BoxFit.cover,
                      ),
                      border: Border.all(color: Colors.white, width: 2),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 5,
                          offset: const Offset(0, 0),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  child: Container(
                    width: 100,
                    height: 100,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      image: const DecorationImage(
                        image: AssetImage("images/pngs/taraji.png"),
                        fit: BoxFit.cover,
                      ),
                      border: Border.all(color: Colors.white, width: 2),
                      borderRadius: BorderRadius.circular(50),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 5,
                          offset: const Offset(0, 0),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  child: SizedBox(
                    width: 300,
                    child: buildParticipateButtons(context),
                  ),
                ),
              ],
            ),
            Container(
              width: double.infinity,
              height: 150,
              margin: const EdgeInsets.only(top: 20),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.4),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      buildProgressElement(TablerIcons.heart_handshake, "30"),
                      buildProgressElement(TablerIcons.report_money, "300 DT"),
                      buildProgressElement(TablerIcons.target_arrow, "1000 DT"),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: SimpleAnimationProgressBar(
                      width: 300,
                      height: 15,
                      backgroundColor: const Color.fromARGB(255, 220, 220, 220),
                      foregrondColor: MyColors.yellow,
                      ratio: 0.3,
                      direction: Axis.horizontal,
                      curve: Curves.fastLinearToSlowEaseIn,
                      duration: const Duration(seconds: 3),
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: const [
                        BoxShadow(
                          color: Color.fromARGB(97, 0, 0, 0),
                          spreadRadius: 5,
                          blurRadius: 5,
                          offset: Offset(0, 0),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Text(
              "Construisons un stade pour notre équipe, pour notre ville, pour notre pays. Ensemble, nous pouvons faire la différence. Chaque contribution compte. Chaque geste est important. Chaque don est un pas vers la réalisation de notre rêve. Ensemble, nous pouvons faire la différence. ",
              style: stylePrimary.copyWith(
                fontSize: 18,
                fontWeight: FontWeight.w400,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
