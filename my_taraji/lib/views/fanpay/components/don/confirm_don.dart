import 'package:flutter/cupertino.dart';
import 'package:my_taraji/views/fanpay/imports.dart';

class ConfirmDon extends StatelessWidget {
  const ConfirmDon({super.key, required this.user});
  final User? user;

  @override
  Widget build(BuildContext context) {
    bool isLoading = context.watch<DonProvider>().isLoading;
    DonUI donUI = DonUI();
    DateTime now = DateTime.now();
    bool userHaveCoins = context.watch<DonProvider>().userHaveCoins;
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
            "${context.watch<DonProvider>().amountController.text} DT",
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
                  context.read<DonProvider>().setTypeCash(value, user);
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
                        Text(
                            style: TextStyle(
                              color: userHaveCoins ? null : MyColors.red,
                              fontWeight: FontWeight.w600,
                              fontSize: 16.0,
                            ),
                            userHaveCoins
                                ? "${context.watch<DonProvider>().convertedAmount} Coins"
                                : "${context.watch<DonProvider>().userCoins} Coins"),
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
              donUI.textType2(donUI.formatDate(now)),
            ],
          ),
          userHaveCoins
              ? const SizedBox(height: 50)
              : SizedBox(
                  height: 50,
                  child: Text(
                    context.watch<DonProvider>().error,
                    style: const TextStyle(color: MyColors.red),
                  ),
                ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              fixedSize: const Size(300.0, 50.0),
              backgroundColor: MyColors.orange,
            ),
            onPressed: () {
              isLoading
                  ? null
                  : context.read<DonProvider>().createDonation(user);
            },
            child: isLoading
                ? const CupertinoActivityIndicator(
                    color: Colors.white,
                  )
                : const Text(
                    'Confirmer',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
          ),
        ],
      );
    }

    return confirmDon();
  }
}
