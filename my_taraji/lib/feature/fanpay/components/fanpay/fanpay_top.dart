import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_taraji/core/components/custom_card.dart';
import 'package:my_taraji/core/theme/my_color.dart';
import 'package:my_taraji/feature/init/components/my_profile.dart';
import 'package:my_taraji/feature/init/components/my_taraji_logo.dart';

import '../../../../core/components/background_top.dart';

class TopFanPay extends StatefulWidget {
  const TopFanPay({super.key});

  @override
  TopFanPayState createState() => TopFanPayState();
}

class TopFanPayState extends State<TopFanPay> {
  int myIndex = 1;
  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 450,
      child: Stack(
        children: [
          CustomContainer(
            colorTo: MyColors.blue,
            colorFrom: MyColors.blueDark,
          ),
          Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MyTarajiLogo(
                      logoImagePath: 'images/pngs/taraji.png',
                      firstText: 'My',
                      secondText: 'Taraji',
                      logoSize: 40,
                      textSize: 17,
                      textPosition: TextPosition.right,
                    ),
                    MyProfile(
                      greetingText: 'Bonjour',
                      textPosition: TextPosition.left,
                    ),
                  ],
                ),
                SizedBox(height: 20),
                AllCards(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class AllCards extends StatelessWidget {
  const AllCards({super.key});

  @override
  Widget build(BuildContext context) {
    List<Widget> cards = [
      const Padding(
          padding: EdgeInsets.only(top: 15),
          child: CustomCard(
              svgUrl: 'images/icons/card.svg',
              color: MyColors.white,
              width: 347,
              height: 237)),
      const Padding(
          padding: EdgeInsets.only(top: 10),
          child: CustomCard(
              svgUrl: 'images/icons/card.svg',
              color: MyColors.white,
              width: 347,
              height: 237)),
      const Padding(
          padding: EdgeInsets.only(top: 5),
          child: CustomCard(
              svgUrl: 'images/icons/card.svg',
              color: MyColors.white,
              width: 347,
              height: 237)),
      const Padding(
          padding: EdgeInsets.only(top: 0),
          child: CustomCard(
              svgUrl: 'images/icons/card.svg',
              color: MyColors.orange,
              width: 347,
              height: 237)),
      const PaymentCard()
    ];
    return Expanded(
      child: Stack(
        // alignment: Alignment.center,
        children: cards,
      ),
    );
  }
}

class PaymentCard extends StatelessWidget {
  const PaymentCard({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 365,
        height: 240,
        child: Stack(
          children: [
            const Positioned(
                left: 24,
                top: 50,
                child: Text(
                  'JOHN DOE',
                  style: TextStyle(
                    color: MyColors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                )),
            const Positioned(
                top: 90,
                left: 24,
                child: Row(
                  children: [
                    Text(
                      "••••",
                      style: TextStyle(
                        color: MyColors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(width: 15),
                    Text(
                      "••••",
                      style: TextStyle(
                        color: MyColors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(width: 15),
                    Text(
                      "••••",
                      style: TextStyle(
                        color: MyColors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(width: 15),
                    Text(
                      "5520",
                      style: TextStyle(
                        color: MyColors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    )
                  ],
                )),
            const Positioned(
                top: 150,
                left: 24,
                child: Text(
                  "Balance",
                  style: TextStyle(
                    color: MyColors.white,
                    fontSize: 13,
                    fontWeight: FontWeight.w300,
                  ),
                )),
            const Positioned(
              top: 170,
              left: 24,
              child: Text(
                '1,788.00 DTN',
                style: TextStyle(
                  color: MyColors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Positioned(
                top: 130,
                right: 0,
                child: Stack(
                  alignment: Alignment.centerRight,
                  children: [
                    SvgPicture.asset(
                      'images/icons/pay_card.svg',
                      width: 175,
                      color: MyColors.orangeLight,
                    ),
                    Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child: SvgPicture.asset(
                          'images/icons/mastercard.svg',
                          color: MyColors.white,
                        ))
                  ],
                ))
          ],
        ));
  }
}
