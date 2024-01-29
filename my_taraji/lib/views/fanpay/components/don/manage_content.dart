import 'package:my_taraji/views/fanpay/imports.dart';

class ManageDonPage extends StatelessWidget {
  const ManageDonPage({super.key});

  @override
  Widget build(BuildContext context) {
    User? user;
    context.read<HomeProvider>().getUserData().then((value) => user = value!);

    return context.watch<DonProvider>().step != "finishDon"
        ? _buildBody(context, user)
        : Stack(
            alignment: Alignment.topCenter,
            children: [
              _buildBody(context, user),
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

  Widget _manageStep(User? user, BuildContext context) {
    final donProvider = context.watch<DonProvider>();
    final step = donProvider.step;
    final donProviderReader = context.read<DonProvider>();

    switch (step) {
      case "don":
        donProviderReader.getDonSettings();
        return MyDon(user: user);
      case "confirmDon":
        return ConfirmDon(user: user);
      case "finishDon":
        return const FinishDon();
      case "connect":
        return SignIn(
          onPressed: () => donProviderReader.setStep("pinCode"),
          paddingTop: 0,
        );
      case "pinCode":
        return PinCode(
          onPressed: () => donProviderReader.setStep("finishDon"),
          paddingTop: 0,
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
        fanPayProvider.openModal();
        Navigator.pop(context);
        break;
      case "confirmDon":
      case "finishDon":
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
