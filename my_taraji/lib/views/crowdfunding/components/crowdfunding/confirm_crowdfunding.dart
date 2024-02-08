import 'package:flutter/cupertino.dart';
import 'package:my_taraji/views/crowdfunding/provider/crowdfunding_provider.dart';
import 'package:my_taraji/views/fanpay/imports.dart';

class ConfirmCrowdFunding extends StatelessWidget {
  const ConfirmCrowdFunding({super.key, required this.user});
  final User? user;

  static DonUI crowdFundingUI = DonUI();

  @override
  Widget build(BuildContext context) {
    bool isLoading = context.watch<CrowdFundingProvider>().isLoading;
    DateTime now = DateTime.now();
    bool userHaveCoins = context.watch<CrowdFundingProvider>().userHaveCoins;
    // Crowdfunding? crowFunding =
    //     context.watch<CrowdFundingProvider>().crowdFunding;
    Widget confirmCrowdFunding() {
      return Column(
        children: [
          Container(
            alignment: Alignment.center,
            child: SvgPicture.asset(
                width: 150, height: 150, "images/svgs/fanpay/confirm_don.svg"),
          ),
          crowdFundingUI.divider(20.0),
          Text(
            "${context.watch<CrowdFundingProvider>().amountController.text} DT",
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 32.0,
            ),
          ),
          const SizedBox(height: 10.0),
          crowdFundingUI.textType1("Votre don pour Taraji", false, false),
          const SizedBox(height: 20.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              crowdFundingUI.textType1("Payer par", false, false),
              crowdFundingUI.textType2("Solde wallet"),
              Switch(
                thumbColor: MaterialStateProperty.all(MyColors.white),
                trackColor: MaterialStateProperty.all(MyColors.orange),
                trackOutlineWidth: MaterialStateProperty.all(0),
                trackOutlineColor:
                    MaterialStateProperty.all(Colors.transparent),
                value: context.watch<CrowdFundingProvider>().isTypeCash,
                onChanged: (value) {
                  context.read<CrowdFundingProvider>().setTypeCash(value, user);
                },
              ),
              crowdFundingUI.textType2("Coins"),
            ],
          ),
          context.watch<CrowdFundingProvider>().isTypeCash
              ? Column(
                  children: [
                    crowdFundingUI.divider(40.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        crowdFundingUI.textType1(
                            "Nombre des coins", false, false),
                        Text(
                            style: TextStyle(
                              color: userHaveCoins ? null : MyColors.red,
                              fontWeight: FontWeight.w600,
                              fontSize: 16.0,
                            ),
                            userHaveCoins
                                ? "${context.watch<CrowdFundingProvider>().convertedAmount} Coins"
                                : "${context.watch<CrowdFundingProvider>().userCoins} Coins"),
                      ],
                    ),
                  ],
                )
              : const SizedBox(),
          crowdFundingUI.divider(40.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              crowdFundingUI.textType1("Don destination", false, false),
              crowdFundingUI.textType2("Taraji"),
            ],
          ),
          crowdFundingUI.divider(40.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              crowdFundingUI.textType1("Date", false, false),
              crowdFundingUI.textType2(crowdFundingUI.formatDate(now)),
            ],
          ),
          userHaveCoins
              ? const SizedBox(height: 50)
              : SizedBox(
                  height: 50,
                  child: Text(
                    context.watch<CrowdFundingProvider>().error,
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
                  : context
                      .read<CrowdFundingProvider>()
                      .createCrowdFunding(user, context);
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

    return confirmCrowdFunding();
  }
}
