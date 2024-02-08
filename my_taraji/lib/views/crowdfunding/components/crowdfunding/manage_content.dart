import 'package:my_taraji/views/crowdfunding/components/crowdfunding/confirm_crowdfunding.dart';
import 'package:my_taraji/views/crowdfunding/components/crowdfunding/crowdfunding.dart';
import 'package:my_taraji/views/crowdfunding/components/crowdfunding/finish_crowdfunding.dart';
import 'package:my_taraji/views/crowdfunding/provider/crowdfunding_provider.dart';
import 'package:my_taraji/views/fanpay/imports.dart';
import 'package:my_taraji/views/fanpay/views/izi/components/overlay_loader.dart';

class ManageCrowdFundingPage extends StatelessWidget {
  const ManageCrowdFundingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<User?>(
      future: context.read<HomeProvider>().getUserData(),
      builder: (context, snapshot) {
        final value = snapshot.data;
        if (snapshot.hasData) {
          return context.watch<CrowdFundingProvider>().step != "finishDon"
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
    final step = context.watch<CrowdFundingProvider>().step;
    onPressedToConnect() {
      context.read<CrowdFundingProvider>().validateConnectionForm(context);
    }

    onPressedToVerif() {
      context.read<CrowdFundingProvider>().validateVerifForm(context);
    }

    switch (step) {
      case "don":
        return CrowdFunding(user: user);
      case "confirmDon":
        return ConfirmCrowdFunding(user: user);
      case "finishDon":
        return FinishCrowdFunding(user: user);
      case "pinCode":
        return context.watch<CrowdFundingProvider>().isLoading == true
            ? Stack(
                children: [
                  PinCode(
                    onPressed: onPressedToVerif,
                    paddingTop: 0,
                    formKey: context.watch<CrowdFundingProvider>().formKey,
                    pinCode: context.watch<CrowdFundingProvider>().pinCode,
                    isLoading: context.watch<CrowdFundingProvider>().isLoading,
                    valid: context.watch<CrowdFundingProvider>().isValid,
                  ),
                  const OverlayLoader(),
                ],
              )
            : PinCode(
                onPressed: onPressedToVerif,
                paddingTop: 0,
                formKey: context.watch<CrowdFundingProvider>().formKey,
                pinCode: context.watch<CrowdFundingProvider>().pinCode,
                isLoading: context.watch<CrowdFundingProvider>().isLoading,
                valid: context.watch<CrowdFundingProvider>().isValid,
              );

      case "connect":
        return context.watch<CrowdFundingProvider>().isLoading == true
            ? Stack(
                alignment: Alignment.center,
                children: [
                  SignIn(
                    onPressed: onPressedToConnect,
                    paddingTop: 0,
                    formKey: context.watch<CrowdFundingProvider>().formKey,
                    signinId: context.watch<CrowdFundingProvider>().signinId,
                    signinPwd: context.watch<CrowdFundingProvider>().signinPwd,
                    isLoading: context.watch<CrowdFundingProvider>().isLoading,
                  ),
                  const OverlayLoader(),
                ],
              )
            : SignIn(
                onPressed: onPressedToConnect,
                paddingTop: 0,
                formKey: context.watch<CrowdFundingProvider>().formKey,
                signinId: context.watch<CrowdFundingProvider>().signinId,
                signinPwd: context.watch<CrowdFundingProvider>().signinPwd,
                isLoading: context.watch<CrowdFundingProvider>().isLoading,
              );

      default:
        return Container();
    }
  }

  Widget _buildTop(BuildContext context) {
    final crowdFundingProvider = context.watch<CrowdFundingProvider>();
    final fanPayProvider = context.read<FanPayProvider>();
    final step = crowdFundingProvider.step;

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
              crowdFundingProvider.title,
              style: const TextStyle(
                color: MyColors.white,
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
            GestureDetector(
              onTap: () {},
              child: crowdFundingProvider.step != "finishDon"
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
    final crowdFundingProvider = context.read<CrowdFundingProvider>();

    switch (step) {
      case "don":
        context.read<CrowdFundingProvider>().initAllData();
        fanPayProvider.openModal();
        Navigator.pop(context);
        break;
      case "finishDon":
        context.read<CrowdFundingProvider>().initAllData();
        fanPayProvider.openModal();
        Navigator.pop(context);
        break;
      case "confirmDon":
        crowdFundingProvider.setStep("don");
        break;
      case "connect":
      case "pinCode":
        crowdFundingProvider.setStep("confirmDon");
        break;
    }
  }

  Widget _buildMiddle(BuildContext context, User? user) {
    final crowdFundingProvider = context.watch<CrowdFundingProvider>();

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
              crowdFundingProvider.step != "finishDon"
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
                        crowdFundingProvider.step != "finishDon"
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
