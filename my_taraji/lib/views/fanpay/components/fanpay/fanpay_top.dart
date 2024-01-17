// ignore_for_file: deprecated_member_use

import '../../imports.dart';

class TopFanPay extends StatefulWidget {
  const TopFanPay({super.key, required this.userData});
  final Map<String, String> userData;

  @override
  TopFanPayState createState() => TopFanPayState();
}

class TopFanPayState extends State<TopFanPay> {
  int myIndex = 1;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 505,
      child: Stack(
        children: [
          const CustomContainer(
            colorTo: MyColors.blueLinear1,
            colorFrom: MyColors.blueLinear2,
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MyTarajiLogo(
                      logoImagePath: 'images/pngs/taraji.png',
                      firstText: 'My',
                      secondText: 'Taraji',
                      logoSize: 40,
                      textSize: 17,
                      textPosition: TextPositionLogo.right,
                    ),
                    MyProfile(
                      greetingText: 'Bonjour',
                      textPosition: TextPositionLogo.left,
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                AllCards(userData: widget.userData),
                const FanPayMiddleContent(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class AllCards extends StatelessWidget {
  const AllCards({super.key, required this.userData});
  final Map<String, String> userData;

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
      PaymentCard(userData: userData)
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
  const PaymentCard({super.key, required this.userData});
  final Map<String, String> userData;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 365,
        height: 240,
        child: Stack(
          children: [
            Positioned(
                left: 24,
                top: 50,
                child: Text(
                  userData['name']!.toUpperCase(),
                  style: const TextStyle(
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
