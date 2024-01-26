import 'package:flutter/cupertino.dart';
import 'package:my_taraji/views/fanpay/imports.dart';
<<<<<<< HEAD
import 'package:my_taraji/views/fanpay/views/izi/components/pin_code/pin_code.dart';
import 'package:my_taraji/views/fanpay/views/izi/components/sign_in/sign_in.dart';
=======
>>>>>>> Develop

class MyDon extends StatelessWidget {
  const MyDon({super.key});

  manageStep(User? user, BuildContext globalContext) {
    switch (globalContext.watch<DonProvider>().step) {
      case "don":
        globalContext.read<DonProvider>().getDonSettings();
        return don(user, globalContext);
      case "confirmDon":
        return const ConfirmDon();
      case "finishDon":
        return const FinishDon();
      case "connect":
        return SignIn(
          onPressed: () {
            globalContext.read<DonProvider>().setStep("pinCode");
          },
          paddingTop: 0,
        );
      case "pinCode":
        return PinCode(
          onPressed: () {
            globalContext.read<DonProvider>().setStep("finishDon");
          },
          paddingTop: 0,
        );
    }
  }

  Widget don(
    User? user,
    BuildContext context,
  ) {
    DonUI donUI = DonUI();
    bool isActiveMinimum =
        context.watch<DonProvider>().donSettings.isMinimumThresholdAmountActive;
    int minimumThresholdAmount =
        context.watch<DonProvider>().donSettings.minimumThresholdAmount;
    String minimumThresholdViloationMessage = context
        .watch<DonProvider>()
        .donSettings
        .minimumThresholdViloationMessage;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            ClipOval(
              child: Image.asset(
                'images/pngs/taraji.png',
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
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.5,
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
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.zero,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Veuillez entrer un montant";
                    }
                    if (isActiveMinimum &&
                        int.parse(value) < minimumThresholdAmount) {
                      return minimumThresholdViloationMessage;
                    }

                    return null;
                  },
                ),
              ),
            ),
            const SizedBox(width: 50.0),
            const Text(
              "DT",
              style: TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.w400,
                decoration: TextDecoration.none,
              ),
            ),
          ],
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

  buildTop(BuildContext context) {
    String step = context.watch<DonProvider>().step;
    return Container(
      height: MediaQuery.of(context).size.height * 0.17,
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
                switch (step) {
                  case "don":
                    context.read<FanPayProvider>().openModal();
                    Navigator.pop(context);
                    break;
                  case "confirmDon":
                    context.read<DonProvider>().setStep("don");
                    break;
                  case "finishDon":
                    context.read<DonProvider>().setStep("confirmDon");
                    break;
                  case "connect":
                    context.read<DonProvider>().setStep("confirmDon");
                    break;
                  case "pinCode":
                    context.read<DonProvider>().setStep("confirmDon");
                    break;
                }
              },
              child: const Icon(
                size: 25,
                TablerIcons.arrow_left,
                color: MyColors.white,
              ),
            ),
            Text(
              context.watch<DonProvider>().title,
              style: const TextStyle(
                color: MyColors.white,
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
            GestureDetector(
              onTap: () {},
              child: context.watch<DonProvider>().step != "finishDon"
                  ? const SizedBox(height: 22, width: 22)
                  : const Icon(
                      size: 20,
                      TablerIcons.printer,
                      color: MyColors.white,
                    ),
            ),
          ],
        ),
      ),
    );
  }

  buildMiddle(BuildContext context, User? user) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.83,
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
              context.watch<DonProvider>().step != "finishDon"
                  ? SvgPicture.asset(
                      'images/icons/drag.svg',
                      height: 5,
                      width: 5,
                    )
                  : Container(),
              Container(
                height: MediaQuery.of(context).size.height * 0.81,
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                  color: Colors.transparent,
                ),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(30),
                    child: Column(children: [
                      context.watch<DonProvider>().step != "finishDon"
                          ? Container()
                          : const SizedBox(height: 50),
                      manageStep(user, context),
                    ]),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildBody(BuildContext context, User? user) {
    return Column(
      children: [
        buildTop(context),
        buildMiddle(context, user),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    User? user;
    context.read<HomeProvider>().getUserData().then((value) => user = value!);

    return context.watch<DonProvider>().step != "finishDon"
        ? buildBody(context, user)
        : Stack(
            alignment: Alignment.topCenter,
            children: [
              buildBody(context, user),
              Positioned(
                top: 30,
                child: SvgPicture.asset(
                  "images/svgs/fanpay/finish_don.svg",
                  height: 160,
                  width: 160,
                ),
              )
            ],
          );
  }
}
