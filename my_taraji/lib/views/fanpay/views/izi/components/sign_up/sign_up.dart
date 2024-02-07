import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_taraji/core/theme/my_color.dart';
import 'package:my_taraji/views/fanpay/views/izi/components/sign_up/sign_up_form.dart';
import 'package:my_taraji/views/fanpay/views/izi/provider/izi_provider.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    bool isProcessing = context.watch<IziProvider>().isProcessing;
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
      body: Container(
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
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 70,
              ),
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
                      'Création de compte Izi',
                      style: TextStyle(
                        color: MyColors.white,
                        fontSize: 27,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const Text(
                      'Afin de créer votre wallet, veuillez remplir les champs ci-dessous.',
                      style: TextStyle(
                        color: MyColors.yellow,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const IziSignUpForm(),
                    Center(
                      child: ElevatedButton(
                        onPressed: isProcessing
                            ? null
                            : () => context
                                .read<IziProvider>()
                                .validateSignUpForm(context),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                            vertical: 15,
                            horizontal: 50,
                          ),
                          backgroundColor: MyColors.yellow,
                        ),
                        child: isProcessing
                            ? const CupertinoActivityIndicator(
                                color: Colors.white,
                              )
                            : const Text(
                                'Créer mon compte',
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
        ),
      ),
    );
  }
}
