import 'package:my_taraji/views/fanpay/models/account_card.dart';
import '../../imports.dart';

class FanPayTop extends StatelessWidget {
  const FanPayTop({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: MyColors.white,
      ),
      height: 300,
      child: const Stack(
        children: [
          CustomContainer(
            colorTo: MyColors.blueLinear1,
            colorFrom: MyColors.blueLinear2,
          ),
          Column(
            children: [
              SizedBox(height: 80),
              Padding(
                padding: EdgeInsets.all(20),
                child: AllCards(),
              ),
            ],
          )
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
      FutureBuilder(
        future: context.watch<HomeProvider>().getUserData(),
        builder: (context, AsyncSnapshot<User?> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }

          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }
          final userData = snapshot.data;
          return PaymentCard(userData: userData);
        },
      ),
    ];
    return Stack(
      children: cards,
    );
  }
}

class PaymentCard extends StatelessWidget {
  const PaymentCard({super.key, required this.userData});
  final User? userData;

  buildContentCard(BuildContext context) {
    AccountCard? accountCard = context.watch<FanPayProvider>().accountCard;
    return SizedBox(
      width: 365,
      height: 240,
      child: Stack(
        children: [
          Positioned(
              left: 24,
              top: 50,
              child: Text(
                userData?.pseudo?.toUpperCase() ?? '',
                style: const TextStyle(
                  color: MyColors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              )),
          Positioned(
            top: 90,
            left: 24,
            child: Row(
              children: [
                Text(
                  context
                      .read<FanPayProvider>()
                      .formatCardNumber(accountCard?.data?.rib ?? ''),
                  style: const TextStyle(
                    color: MyColors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
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
          Positioned(
            top: 170,
            left: 24,
            child: Text(
              '${accountCard?.data?.balance} DTN',
              style: const TextStyle(
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
                  // ignore: deprecated_member_use
                  color: MyColors.orangeLight,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: SvgPicture.asset(
                    'images/icons/mastercard.svg',
                    // ignore: deprecated_member_use
                    color: MyColors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return buildContentCard(context);
  }
}
