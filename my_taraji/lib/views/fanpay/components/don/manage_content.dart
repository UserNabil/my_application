import 'package:my_taraji/views/fanpay/imports.dart';
import 'package:my_taraji/views/fanpay/views/izi/components/overlay_loader.dart';
import 'package:my_taraji/views/fanpay/views/izi/provider/izi_provider.dart';

class ManageDonPage extends StatelessWidget {
  const ManageDonPage({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<User?>(
      future: context.read<HomeProvider>().getUserData(),
      builder: (context, snapshot) {
        final value = snapshot.data;
        if (snapshot.hasData) {
          return context.watch<DonProvider>().step != "finishDon"
              ? _buildBody(context, value)
              : Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    _buildBody(context, value),
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
        } else if (snapshot.hasError) {
          return const Center(child: Text("Une erreur est survenue"));
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget _manageStep(User? user, BuildContext context) {
    final step = context.watch<DonProvider>().step;

    context.read<DonProvider>().getDonSettingsProv();
    switch (step) {
      case "don":
        return MyDon(user: user);
      case "confirmDon":
        return ConfirmDon(user: user);
      case "finishDon":
        return const FinishDon();
      case "connect":
        // return SignIn(
        //   onPressed: () async {
        //     Future.delayed(const Duration(milliseconds: 500), () {
        //       // context.read<DonProvider>().setStep("pinCode");
        //     });
        //     // context.read<DonProvider>().setStep("pinCode")
        //   },
        //   paddingTop: 0,
        // );
        String step = context.watch<IziProvider>().connectionStep;
        onPressedToConnect() {
          context.read<IziProvider>().setConnectProcissing(false);
          // context.read<IziProvider>().validateSignInForm(context);
        }

        onPressedToVerif() {
          // context.read<IziProvider>().validateVerifForm(context);
        }
        return step == "pinCode"
            ? context.watch<IziProvider>().isVerifProcissing == true
                ? Stack(
                    children: [
                      PinCode(onPressed: onPressedToVerif, paddingTop: 0),
                      const OverlayLoader(),
                    ],
                  )
                : PinCode(onPressed: onPressedToVerif, paddingTop: 0)
            : context.watch<IziProvider>().isConnectProcissing == true
                ? Stack(
                    children: [
                      SignIn(onPressed: onPressedToConnect, paddingTop: 0),
                      const OverlayLoader(),
                    ],
                  )
                : SignIn(onPressed: onPressedToConnect, paddingTop: 0);
      default:
        return Container();
    }
  }

  Widget _buildTop(BuildContext context) {
    final donProvider = context.watch<DonProvider>();
    final fanPayProvider = context.read<FanPayProvider>();
    final step = donProvider.step;

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
              onTap: () => _handleTopGesture(context, step, fanPayProvider),
              child: const Icon(
                size: 25,
                TablerIcons.arrow_left,
                color: MyColors.white,
              ),
            ),
            Text(
              donProvider.title,
              style: const TextStyle(
                color: MyColors.white,
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
            GestureDetector(
              onTap: () {},
              child: donProvider.step != "finishDon"
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

  void _handleTopGesture(
      BuildContext context, String step, FanPayProvider fanPayProvider) {
    final donProvider = context.read<DonProvider>();

    switch (step) {
      case "don":
        fanPayProvider.openModal();
        Navigator.pop(context);
        break;
      case "confirmDon":
        donProvider.setStep("don");
        break;
      case "connect":
      case "pinCode":
        donProvider.setStep("confirmDon");
        break;
    }
  }

  Widget _buildMiddle(BuildContext context, User? user) {
    final donProvider = context.watch<DonProvider>();

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
              donProvider.step != "finishDon"
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
                    child: Column(
                      children: [
                        donProvider.step != "finishDon"
                            ? Container()
                            : const SizedBox(height: 50),
                        _manageStep(user, context),
                      ],
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

  Widget _buildBody(BuildContext context, User? user) {
    return Column(
      children: [
        _buildTop(context),
        _buildMiddle(context, user),
      ],
    );
  }
}
