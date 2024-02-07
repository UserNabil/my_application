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
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: MyColors.white,
          ),
        ),
      ),
      body: PinCode(
        onPressed: onPressed,
        paddingTop: 70,
        formKey: context.watch<IziProvider>().formKey,
        pinCode: context.watch<IziProvider>().pinCode,
        isLoading: context.watch<IziProvider>().isVerifProcissing,
        valid: context.watch<IziProvider>().isValid,
      ),
    );
  }
}

class PinCode extends StatelessWidget {
  const PinCode({
    super.key,
    required this.onPressed,
    required this.paddingTop,
    required this.formKey,
    required this.pinCode,
    required this.isLoading,
    required this.valid,
  });
  final Function? onPressed;
  final double paddingTop;
  final GlobalKey<FormState> formKey;
  final TextEditingController pinCode;
  final bool isLoading;
  final bool valid;

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
                  'Vérifier votre identité',
                  style: TextStyle(
                    color: MyColors.white,
                    fontSize: 27,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const Text(
                  'Veuillez saisir votre code PIN',
                  style: TextStyle(
                    color: MyColors.yellow,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                PinCodeForm(
                  formKey: formKey,
                  pinCode: pinCode,
                  valid: valid,
                ),
                const SizedBox(height: 15),
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
                      backgroundColor: MyColors.yellow,
                    ),
                    child: isLoading
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
                Center(
                  child: InkWell(
                    onTap: () {
                      context.read<IziProvider>().resendCode();
                    },
                    child: const Text(
                      'Renvoyer un code PIN',
                      style: TextStyle(
                        color: MyColors.yellow,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
