import 'package:flutter/cupertino.dart';
import 'package:my_taraji/views/fanpay/imports.dart';

class MyDon extends StatelessWidget {
  const MyDon({super.key});

  manageStep(userData, BuildContext globalContext) {
    switch (globalContext.watch<DonProvider>().step) {
      case "don":
        return don(userData, globalContext);
      case "confirmDon":
        return const ConfirmDon();
      case "finishDon":
        return const FinishDon();
    }
  }

  buildTop(BuildContext context) {
    String thisStep = context.watch<DonProvider>().step;
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
                if (thisStep == "confirmDon") {
                  context.read<DonProvider>().setStep("don");
                } else if (thisStep == "don") {
                  Navigator.pop(context);
                  context.read<FanPayProvider>().openModal();
                } else if (thisStep == "finishDon") {
                  context.read<DonProvider>().setStep("confirmDon");
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

  buildMiddle(BuildContext context, UserData userData) {
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
                      manageStep(userData, context),
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

  Widget buildBody(BuildContext context, UserData userData) {
    return Column(
      children: [
        buildTop(context),
        buildMiddle(context, userData),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: context.read<HomeProvider>().getUserData(),
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SizedBox(
            height: 100,
            child: Center(
              child: CircularProgressIndicator(
                color: MyColors.yellow,
              ),
            ),
          );
        }

        if (snapshot.hasError) {
          return const Text('Error', style: TextStyle(color: MyColors.red));
        }

        final userData = snapshot.data!;
        return context.watch<DonProvider>().step != "finishDon"
            ? buildBody(context, userData)
            : Stack(
                alignment: Alignment.topCenter,
                children: [
                  buildBody(context, userData),
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
      },
    );
  }

  Widget don(userData, BuildContext context) {
    DonUI donUI = DonUI();
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
                Text(userData.pseudo,
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
              width: 150,
              child: TextField(
                readOnly: context.watch<DonProvider>().isTypeCash,
                controller: context.watch<DonProvider>().amountController,
                cursorColor: MyColors.blue,
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
            children: context.watch<DonProvider>().amounts.map((amount) {
              return ElevatedButton(
                onPressed: () {
                  context.read<DonProvider>().setAmount(amount);
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
                    '$amount DT',
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
