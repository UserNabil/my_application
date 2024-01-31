import 'package:flutter/cupertino.dart';
import 'package:my_taraji/views/fanpay/imports.dart';
import 'package:my_taraji/views/fanpay/providers/transfert_provider.dart';

class ConfirmTransfert extends StatelessWidget {
  const ConfirmTransfert({super.key, required this.user});
  final User? user;

  @override
  Widget build(BuildContext context) {
    bool isLoading = context.watch<TransfertProvider>().isLoading;
    DonUI transfertUI = DonUI();
    DateTime now = DateTime.now();
    Widget confirmTransfert() {
      return Column(
        children: [
          Container(
            alignment: Alignment.center,
            child: SvgPicture.asset(
                width: 150, height: 150, "images/svgs/fanpay/confirm_don.svg"),
          ),
          transfertUI.divider(20.0),
          Text(
            "${context.watch<TransfertProvider>().amountController.text} DT",
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 32.0,
            ),
          ),
          const SizedBox(height: 10.0),
          transfertUI.textType1("Votre transfert pour Taraji", false, false),
          const SizedBox(height: 20.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              transfertUI.textType1("Payer par", false, false),
              transfertUI.textType2("Solde wallet"),
              Switch(
                thumbColor: MaterialStateProperty.all(MyColors.white),
                trackColor: MaterialStateProperty.all(MyColors.orange),
                trackOutlineWidth: MaterialStateProperty.all(0),
                trackOutlineColor:
                    MaterialStateProperty.all(Colors.transparent),
                value: context.watch<TransfertProvider>().isTypeCash,
                onChanged: (value) {
                  context.read<TransfertProvider>().setTypeCash(value);
                },
              ),
              transfertUI.textType2("Coins"),
            ],
          ),
          context.watch<TransfertProvider>().isTypeCash
              ? Column(
                  children: [
                    transfertUI.divider(40.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        transfertUI.textType1("Nombre des coins", false, false),
                        transfertUI.textType2(
                            "${context.watch<TransfertProvider>().convertedAmount} Coins"),
                      ],
                    ),
                  ],
                )
              : const SizedBox(),
          transfertUI.divider(40.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              transfertUI.textType1("Transfert destination", false, false),
              transfertUI.textType2("Taraji"),
            ],
          ),
          transfertUI.divider(40.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              transfertUI.textType1("Date", false, false),
              transfertUI.textType2(transfertUI.formatDate(now)),
            ],
          ),
          const SizedBox(height: 50),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              fixedSize: const Size(300.0, 50.0),
              backgroundColor: MyColors.orange,
            ),
            onPressed: () {
              isLoading
                  ? null
                  : context.read<TransfertProvider>().createTransfert(user);
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

    return confirmTransfert();
  }
}
