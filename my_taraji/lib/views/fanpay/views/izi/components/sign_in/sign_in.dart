import 'package:flutter/cupertino.dart';
import 'package:my_taraji/views/fanpay/imports.dart';
import 'package:my_taraji/views/fanpay/views/izi/components/overlay_loader.dart';
import 'package:my_taraji/views/fanpay/views/izi/components/sign_in/sign_in_form.dart';
import 'package:my_taraji/views/fanpay/views/izi/provider/izi_provider.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => SignInScreenState();
}

class SignInScreenState extends State<SignInScreen> {
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
        backgroundColor: MyColors.transparent,
      ),
      body: context.watch<IziProvider>().connectionStep == "pinCode"
          ? context.watch<IziProvider>().isVerifProcissing == true
              ? Stack(
                  children: [
                    PinCode(onPressed: onPressedToVerif, paddingTop: 150),
                    const OverlayLoader(),
                  ],
                )
              : PinCode(onPressed: onPressedToVerif, paddingTop: 150)
          : context.watch<IziProvider>().isConnectProcissing == true
              ? Stack(
                  children: [
                    SignIn(onPressed: onPressedToConnect, paddingTop: 150),
                    const OverlayLoader(),
                  ],
                )
              : SignIn(onPressed: onPressedToConnect, paddingTop: 150),
    );
  }
}

class SignIn extends StatelessWidget {
  const SignIn({super.key, required this.onPressed, required this.paddingTop});
  final Function? onPressed;
  final double paddingTop;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.only(top: paddingTop),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Image.asset("images/pngs/izi.jpg", width: 150),
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
                    color: MyColors.black,
                    fontSize: 27,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const Text(
                  'Veuillez vous connecter afin d\'acceder à votre wallet.',
                  style: TextStyle(
                    color: MyColors.grey,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const IziSignInForm(),
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
                      backgroundColor: MyColors.iziBlue,
                    ),
                    child: context.watch<IziProvider>().isValid
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
