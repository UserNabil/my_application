import 'package:flutter/cupertino.dart';
import 'package:my_taraji/views/fanpay/imports.dart';

class CrowdFundingDon extends StatelessWidget {
  const CrowdFundingDon({super.key, required this.user});

  final User? user;

  @override
  Widget build(BuildContext context) {
    DonUI donUI = DonUI();
    bool isActiveMinimum =
        context.watch<DonProvider>().donSettings.isMinimumThresholdAmountActive;
    int minimumThresholdAmount =
        context.watch<DonProvider>().donSettings.minimumThresholdAmount;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            ClipOval(
              child: Image.network(
                'https://e-s-tunis.com/images/news/2023/03/03/1677831592_img.jpg',
                fit: BoxFit.cover,
                width: 70,
                height: 70,
              ),
            ),
            const SizedBox(width: 20.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(user?.pseudo ?? "",
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 15.0),
                const Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('Don pour Taraji'),
                  ],
                ),
              ],
            )
          ],
        ),
        donUI.divider(40.0),
        const SizedBox(height: 20.0),
        const Text(
          'Définir montant',
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 16.0,
          ),
        ),
        const SizedBox(height: 20.0),
        SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Form(
            key: context.watch<DonProvider>().formKey,
            child: TextFormField(
              textAlign: TextAlign.center,
              readOnly: !context
                  .watch<DonProvider>()
                  .donSettings
                  .isFreeInputAmountActivated,
              controller: context.watch<DonProvider>().amountController,
              cursorColor: MyColors.blue3,
              style: const TextStyle(
                fontSize: 40.0,
                fontWeight: FontWeight.w600,
                decoration: TextDecoration.none,
              ),
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                errorMaxLines: 2,
                suffix: Text(
                  "DT",
                  style: TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.w400,
                    decoration: TextDecoration.none,
                  ),
                ),
                border: InputBorder.none,
                contentPadding: EdgeInsets.zero,
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Veuillez entrer un montant";
                }
                if (isActiveMinimum &&
                    int.parse(value) < minimumThresholdAmount) {
                  return "Votre solde est insuffisant pour le don souhaité, veuillez recharger votre Wallet";
                  // return minimumThresholdViloationMessage;
                }

                return null;
              },
            ),
          ),
        ),
        const SizedBox(height: 10.0),
        donUI.divider(0.0),
        const SizedBox(height: 20.0),
        Container(
          height: 200,
          alignment: Alignment.topCenter,
          child: Wrap(
            spacing: 10.0,
            runSpacing: 20.0,
            children: context
                .watch<DonProvider>()
                .donSettings
                .authorizedAmounts
                .map((authorizedAmount) {
              return ElevatedButton(
                onPressed: () {
                  context
                      .read<DonProvider>()
                      .setAmount(authorizedAmount.amount);
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15.0,
                    vertical: 10.0,
                  ),
                  backgroundColor: const Color(0xffF0F5FF),
                  foregroundColor: const Color(0xff3784FB),
                  surfaceTintColor: const Color(0xffF0F5FF),
                ),
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    '${authorizedAmount.amount} DT',
                    style: const TextStyle(
                      color: Color(0xff3784FB),
                      fontSize: 14.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
        SlideAction(
          thumbWidth: 70,
          stretchThumb: true,
          trackHeight: 60,
          trackBuilder: (context, state) {
            return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: const Color(0xffF0F5FF),
              ),
              child: Center(
                child: Text(
                  state.isPerformingAction
                      ? "Chargement..."
                      : "Glisser pour continuer",
                  style: const TextStyle(
                    color: MyColors.black,
                    fontSize: 14.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            );
          },
          thumbBuilder: (context, state) {
            return Container(
              alignment: Alignment.centerRight,
              decoration: BoxDecoration(
                color: MyColors.orange,
                borderRadius: BorderRadius.circular(30),
              ),
              child: state.isPerformingAction
                  ? const Center(
                      child: CupertinoActivityIndicator(
                        color: Colors.white,
                      ),
                    )
                  : const Padding(
                      padding: EdgeInsets.only(right: 15),
                      child: Icon(
                        size: 40,
                        TablerIcons.chevrons_right,
                        color: Colors.white,
                      ),
                    ),
            );
          },
          action: () async {
            await Future.delayed(
              const Duration(seconds: 1),
              () {
                context.read<DonProvider>().setStep("confirmDon");
              },
            );
          },
        ),
      ],
    );
  }
}
