import 'package:flutter/cupertino.dart';
import 'package:my_taraji/views/fanpay/imports.dart';
import 'package:my_taraji/views/fanpay/views/izi/components/overlay_loader.dart';
import 'package:my_taraji/views/fanpay/views/izi/components/sign_in/sign_in_form.dart';
import 'package:my_taraji/views/fanpay/views/izi/provider/izi_provider.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    onPressedToConnect() {
      context.read<IziProvider>().validateSignInForm(context);
    }

    onPressedToVerif() {
      context.read<IziProvider>().validateVerifForm(context);
    }

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: MyColors.white,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: MyColors.white,
          ),
        ),
        backgroundColor: MyColors.transparent,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              MyColors.blue2,
              MyColors.blue,
            ],
          ),
        ),
        child: context.watch<IziProvider>().connectionStep == "pinCode"
            ? context.watch<IziProvider>().isVerifProcissing == true
                ? Stack(
                    children: [
                      PinCode(
                        onPressed: onPressedToVerif,
                        paddingTop: 150,
                        formKey: context.watch<IziProvider>().formKey,
                        pinCode: context.watch<IziProvider>().pinCode,
                        isLoading:
                            context.watch<IziProvider>().isVerifProcissing,
                        valid: context.watch<IziProvider>().verifIsWrong,
                      ),
                      const OverlayLoader(),
                    ],
                  )
                : PinCode(
                    onPressed: onPressedToVerif,
                    paddingTop: 150,
                    formKey: context.watch<IziProvider>().formKey,
                    pinCode: context.watch<IziProvider>().pinCode,
                    isLoading: context.watch<IziProvider>().isVerifProcissing,
                    valid: context.watch<IziProvider>().verifIsWrong,
                  )
            : context.watch<IziProvider>().isConnectProcissing == true
                ? Stack(
                    children: [
                      SignIn(
                        onPressed: onPressedToConnect,
                        paddingTop: 150,
                        formKey: context.watch<IziProvider>().formKey,
                        signinId: context.watch<IziProvider>().signinId,
                        signinPwd: context.watch<IziProvider>().signinPwd,
                        isLoading:
                            context.watch<IziProvider>().isConnectProcissing,
                      ),
                      const OverlayLoader(),
                    ],
                  )
                : SignIn(
                    onPressed: onPressedToConnect,
                    paddingTop: 150,
                    formKey: context.watch<IziProvider>().formKey,
                    signinId: context.watch<IziProvider>().signinId,
                    signinPwd: context.watch<IziProvider>().signinPwd,
                    isLoading: context.watch<IziProvider>().isConnectProcissing,
                  ),
      ),
    );
  }
}

class SignIn extends StatelessWidget {
  const SignIn({
    super.key,
    required this.onPressed,
    required this.paddingTop,
    required this.formKey,
    required this.signinId,
    required this.signinPwd,
    required this.isLoading,
  });
  final Function? onPressed;
  final double paddingTop;
  final GlobalKey<FormState> formKey;
  final TextEditingController signinId;
  final TextEditingController signinPwd;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.only(top: paddingTop),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Image.asset("images/pngs/taraji.png", width: 100),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              textDirection: TextDirection.ltr,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Connexion à Izi',
                  style: TextStyle(
                    color: MyColors.white,
                    fontSize: 27,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const Text(
                  'Veuillez vous connecter afin d\'acceder à votre wallet.',
                  style: TextStyle(
                    color: MyColors.yellow,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                IziSignInForm(
                  formKey: formKey,
                  signinId: signinId,
                  signinPwd: signinPwd,
                ),
                Center(
                  child: ElevatedButton(
                    onPressed: () async {
                      await onPressed!();
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        vertical: 15,
                        horizontal: 50,
                      ),
                      backgroundColor: MyColors.yellow,
                    ),
                    child: isLoading
                        ? const CupertinoActivityIndicator(
                            color: Colors.white,
                          )
                        : const Text(
                            'Se connecter',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
