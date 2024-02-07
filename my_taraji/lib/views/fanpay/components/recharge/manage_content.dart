import 'package:my_taraji/views/fanpay/components/recharge/confirm_recharge.dart';
import 'package:my_taraji/views/fanpay/imports.dart';

class ManageRechargePage extends StatelessWidget {
  const ManageRechargePage({super.key});

  manageStep(User? user, BuildContext globalContext) {
    switch (globalContext.watch<RechargeProvider>().step) {
      case "recharge":
        return RechargeFistPage(user: user);
      case "confirmRecharge":
        return const ConfirmRecharge();
      case "finishRecharge":
        return const FinishRecharge();
    }
  }

  buildTop(BuildContext context) {
    String step = context.watch<RechargeProvider>().step;
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
                  case "recharge":
                    context.read<FanPayProvider>().openModal();
                    Navigator.pop(context);
                    break;
                  case "finishRecharge":
                  case "confirmRecharge":
                    context.read<RechargeProvider>().setStep("recharge");
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
              context.watch<RechargeProvider>().title,
              style: const TextStyle(
                color: MyColors.white,
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
            GestureDetector(
              onTap: () {},
              child: context.watch<RechargeProvider>().step != "finishRecharge"
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
              context.watch<RechargeProvider>().step != "finishRecharge"
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
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 20.0,
                    right: 20.0,
                    top: 20.0,
                    bottom: 1,
                  ),
                  child: Scaffold(
                    body: SingleChildScrollView(
                      child: Column(children: [
                        context.watch<RechargeProvider>().step !=
                                "finishRecharge"
                            ? Container()
                            : const SizedBox(height: 50),
                        manageStep(user, context),
                      ]),
                    ),
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
// here is the issue
    return FutureBuilder(
        future: context.read<HomeProvider>().getUserData(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return context.watch<RechargeProvider>().step != "finishRecharge"
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
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        });
  }
}
