import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_taraji/core/theme/my_color.dart';
import 'package:my_taraji/views/fanpay/views/izi/components/sign_up/sign_up_form.dart';
import 'package:my_taraji/views/fanpay/views/izi/provider/izi_provider.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => SignUpScreenState();
}

class SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: MyColors.white,
      appBar: AppBar(
        backgroundColor: MyColors.transparent,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 70,
            ),
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
                    'Création de compte Izi',
                    style: TextStyle(
                      color: MyColors.black,
                      fontSize: 27,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const Text(
                    'Afin de créer votre wallet, veuillez remplir les champs ci-dessous.',
                    style: TextStyle(
                      color: MyColors.grey,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const IziSignUpForm(),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        context.read<IziProvider>().validateSignUpForm(context);
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
    );
  }
}
