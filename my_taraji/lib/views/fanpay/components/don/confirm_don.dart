import 'package:my_taraji/views/fanpay/imports.dart';

class ConfirmDon extends StatelessWidget {
  const ConfirmDon({super.key, required this.user});
  final User? user;

  @override
  Widget build(BuildContext context) {
    DonUI donUI = DonUI();
    Widget confirmDon() {
      return Column(
        children: [
          Container(
            alignment: Alignment.center,
            child: SvgPicture.asset(
                width: 150, height: 150, "images/svgs/fanpay/confirm_don.svg"),
          ),
          donUI.divider(20.0),
          Text(
            context.watch<DonProvider>().isTypeCash
                ? "${context.watch<DonProvider>().convertedAmount} Coins"
                : "${context.watch<DonProvider>().amountController.text} DT",
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 32.0,
            ),
          ),
          const SizedBox(height: 10.0),
          donUI.textType1("Votre don pour Taraji", false, false),
          const SizedBox(height: 20.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              donUI.textType1("Payer par", false, false),
              donUI.textType2("Solde wallet"),
              Switch(
                thumbColor: MaterialStateProperty.all(MyColors.white),
                trackColor: MaterialStateProperty.all(MyColors.orange),
                trackOutlineWidth: MaterialStateProperty.all(0),
                trackOutlineColor:
                    MaterialStateProperty.all(Colors.transparent),
                value: context.watch<DonProvider>().isTypeCash,
                onChanged: (value) {
                  context.read<DonProvider>().setTypeCash(value);
                },
              ),
              donUI.textType2("Coins"),
            ],
          ),
          context.watch<DonProvider>().isTypeCash
              ? Column(
                  children: [
                    donUI.divider(40.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        donUI.textType1("Nombre des coins", false, false),
                        donUI.textType2(
                            "${context.watch<DonProvider>().convertedAmount} Coins"),
                      ],
                    ),
                  ],
                )
              : const SizedBox(),
          donUI.divider(40.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              donUI.textType1("Don destination", false, false),
              donUI.textType2("Taraji"),
            ],
          ),
          donUI.divider(40.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              donUI.textType1("Date", false, false),
              donUI.textType2("22 Avril, 2024 • 12:00"),
            ],
          ),
          const SizedBox(height: 50),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              fixedSize: const Size(300.0, 50.0),
              backgroundColor: MyColors.orange,
            ),
            onPressed: () {
              context.read<DonProvider>().createDonation(false, context, user!);
            },
            child: const Text(
              "Confirmer",
              style: TextStyle(
                color: MyColors.white,
                fontSize: 16.0,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      );
    }

    return confirmDon();
  }
}
