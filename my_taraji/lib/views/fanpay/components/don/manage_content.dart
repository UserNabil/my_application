import 'package:my_taraji/views/fanpay/imports.dart';
import 'package:my_taraji/views/fanpay/views/izi/components/overlay_loader.dart';

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
    onPressedToConnect() {
      context.read<DonProvider>().validateConnectionForm(context);
    }

    onPressedToVerif() {
      context.read<DonProvider>().validateVerifForm(context);
    }

    context.read<DonProvider>().getDonSettings();
    switch (step) {
      case "don":
        return MyDon(user: user);
      case "confirmDon":
        return ConfirmDon(user: user);
      case "finishDon":
        return FinishDon(user: user);
      case "pinCode":
        return context.watch<DonProvider>().isLoading == true
            ? Stack(
                children: [
                  PinCode(
                    onPressed: onPressedToVerif,
                    paddingTop: 0,
                    formKey: context.watch<DonProvider>().formKey,
                    pinCode: context.watch<DonProvider>().pinCode,
                    isLoading: context.watch<DonProvider>().isLoading,
                    valid: context.watch<DonProvider>().isValid,
                  ),
                  const OverlayLoader(),
                ],
              )
            : PinCode(
                onPressed: onPressedToVerif,
                paddingTop: 0,
                formKey: context.watch<DonProvider>().formKey,
                pinCode: context.watch<DonProvider>().pinCode,
                isLoading: context.watch<DonProvider>().isLoading,
                valid: context.watch<DonProvider>().isValid,
              );

      case "connect":
        return context.watch<DonProvider>().isLoading == true
            ? Stack(
                alignment: Alignment.center,
                children: [
                  SignIn(
                    onPressed: onPressedToConnect,
                    paddingTop: 0,
                    formKey: context.watch<DonProvider>().formKey,
                    signinId: context.watch<DonProvider>().signinId,
                    signinPwd: context.watch<DonProvider>().signinPwd,
                    isLoading: context.watch<DonProvider>().isLoading,
                  ),
                  const OverlayLoader(),
                ],
              )
            : SignIn(
                onPressed: onPressedToConnect,
                paddingTop: 0,
                formKey: context.watch<DonProvider>().formKey,
                signinId: context.watch<DonProvider>().signinId,
                signinPwd: context.watch<DonProvider>().signinPwd,
                isLoading: context.watch<DonProvider>().isLoading,
              );

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
        context.read<DonProvider>().initAllData();
        fanPayProvider.openModal();
        Navigator.pop(context);
        break;
      case "finishDon":
        context.read<DonProvider>().initAllData();
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
