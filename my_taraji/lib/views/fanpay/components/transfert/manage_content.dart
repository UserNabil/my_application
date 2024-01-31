import 'package:my_taraji/views/fanpay/components/transfert/confirm_transfert.dart';
import 'package:my_taraji/views/fanpay/components/transfert/finish_transfert.dart';
import 'package:my_taraji/views/fanpay/components/transfert/transfert.dart';
import 'package:my_taraji/views/fanpay/imports.dart';
import 'package:my_taraji/views/fanpay/providers/transfert_provider.dart';
import 'package:my_taraji/views/fanpay/views/izi/components/overlay_loader.dart';

class ManageTransfertPage extends StatelessWidget {
  const ManageTransfertPage({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<User?>(
      future: context.read<HomeProvider>().getUserData(),
      builder: (context, snapshot) {
        final value = snapshot.data;
        if (snapshot.hasData) {
          return context.watch<TransfertProvider>().step != "finishTransfert"
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
    final step = context.watch<TransfertProvider>().step;
    onPressedToConnect() {
      context.read<TransfertProvider>().validateConnectionForm(context);
    }

    onPressedToVerif() {
      context.read<TransfertProvider>().validateVerifForm(context);
    }

    context.read<TransfertProvider>().getTransfertSettings();
    switch (step) {
      case "transfert":
        return MyTransfert(user: user);
      case "confirmTransfert":
        return ConfirmTransfert(user: user);
      case "finishTransfert":
        return const FinishTransfert();
      case "pinCode":
        return context.watch<TransfertProvider>().isLoading == true
            ? Stack(
                children: [
                  PinCode(
                    onPressed: onPressedToVerif,
                    paddingTop: 0,
                    formKey: context.watch<TransfertProvider>().formKey,
                    pinCode: context.watch<TransfertProvider>().pinCode,
                    isLoading: context.watch<TransfertProvider>().isLoading,
                    valid: false,
                  ),
                  const OverlayLoader(),
                ],
              )
            : PinCode(
                onPressed: onPressedToVerif,
                paddingTop: 0,
                formKey: context.watch<TransfertProvider>().formKey,
                pinCode: context.watch<TransfertProvider>().pinCode,
                isLoading: context.watch<TransfertProvider>().isLoading,
                valid: false,
              );

      case "connect":
        return context.watch<TransfertProvider>().isLoading == true
            ? Stack(
                alignment: Alignment.center,
                children: [
                  SignIn(
                    onPressed: onPressedToConnect,
                    paddingTop: 0,
                    formKey: context.watch<TransfertProvider>().formKey,
                    signinId: context.watch<TransfertProvider>().signinId,
                    signinPwd: context.watch<TransfertProvider>().signinPwd,
                    isLoading: context.watch<TransfertProvider>().isLoading,
                  ),
                  const OverlayLoader(),
                ],
              )
            : SignIn(
                onPressed: onPressedToConnect,
                paddingTop: 0,
                formKey: context.watch<TransfertProvider>().formKey,
                signinId: context.watch<TransfertProvider>().signinId,
                signinPwd: context.watch<TransfertProvider>().signinPwd,
                isLoading: context.watch<TransfertProvider>().isLoading,
              );

      default:
        return Container();
    }
  }

  Widget _buildTop(BuildContext context) {
    final transfertProvider = context.watch<TransfertProvider>();
    final fanPayProvider = context.read<FanPayProvider>();
    final step = transfertProvider.step;

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
              transfertProvider.title,
              style: const TextStyle(
                color: MyColors.white,
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
            GestureDetector(
              onTap: () {},
              child: transfertProvider.step != "finishTransfert"
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
    final transfertProvider = context.read<TransfertProvider>();

    switch (step) {
      case "transfert":
        fanPayProvider.openModal();
        Navigator.pop(context);
        break;
      case "confirmTransfert":
        transfertProvider.setStep("transfert");
        break;
      case "connect":
      case "pinCode":
        transfertProvider.setStep("confirmTransfert");
        break;
    }
  }

  Widget _buildMiddle(BuildContext context, User? user) {
    final transfertProvider = context.watch<TransfertProvider>();

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
              transfertProvider.step != "finishTransfert"
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
                        transfertProvider.step != "finishTransfert"
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
