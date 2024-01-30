import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_taraji/core/theme/my_color.dart';
import 'package:my_taraji/views/fanpay/views/izi/components/pin_Code/pin_code_form.dart';
import 'package:my_taraji/views/fanpay/views/izi/provider/izi_provider.dart';
import 'package:provider/provider.dart';

class PinCodeScreen extends StatefulWidget {
  const PinCodeScreen({super.key});

  @override
  State<PinCodeScreen> createState() => PinCodeScreenState();
}

class PinCodeScreenState extends State<PinCodeScreen> {
  @override
  Widget build(BuildContext context) {
    onPressed() {
      context.read<IziProvider>().validateSignInForm(context);
    }

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: MyColors.white,
      appBar: AppBar(
        backgroundColor: MyColors.transparent,
      ),
      body: PinCode(
        onPressed: onPressed,
        paddingTop: 70,
      ),
    );
  }
}

class PinCode extends StatelessWidget {
  const PinCode({super.key, required this.onPressed, required this.paddingTop});
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
                  'Vérifier votre identité',
                  style: TextStyle(
                    color: MyColors.black,
                    fontSize: 27,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const Text(
                  'Veuillez saisir votre code PIN',
                  style: TextStyle(
                    color: MyColors.grey,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const PinCodeForm(),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      onPressed!();
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        vertical: 15,
                        horizontal: 50,
                      ),
                      backgroundColor: MyColors.iziBlue,
                    ),
                    child: context.watch<IziProvider>().isVerifProcissing
                        ? const CupertinoActivityIndicator(
                            color: Colors.white,
                          )
                        : const Text(
                            'Vérifier',
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
