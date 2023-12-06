import 'package:flutter/material.dart';
import 'components/my_taraji_logo.dart';
import 'components/my_color.dart';
import 'components/my_button.dart';
import 'components/input_field.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomRight,
            end: Alignment.topLeft,
            colors: [MyColors.redDarker, MyColors.red],
          ),
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              leading: IconButton(
                icon: const Icon(
                  Icons.arrow_back,
                  color: MyColors.white,
                ),
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/login');
                },
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 20),
                    const MyTarajiLogo(
                      logoImagePath: 'images/taraji.png',
                      firstText: 'My',
                      secondText: 'Taraji',
                      logoSize: 100,
                      textSize: 30,
                    ),
                    const SizedBox(height: 16),
                    const Align(
                        alignment: Alignment.centerLeft,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                'Reinitialiser votre mot de passe',
                                style: TextStyle(
                                  color: MyColors.white,
                                  fontSize: 25,
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                'Vous avez oublié votre mot de passe ?',
                                style: TextStyle(
                                  color: MyColors.yellow,
                                  fontSize: 16,
                                ),
                              ),
                            ])),
                    const SizedBox(height: 16),
                    buildInputField('Email', 'John.Doe@mail.com', false, true,
                        true, emailController),
                    const SizedBox(height: 16),
                    MyButton(
                      icon: Icons.send,
                      text: 'Envoyer',
                      color: MyColors.yellow,
                      textColor: MyColors.white,
                      onPressed: () {
                        Submit(context, emailController.text);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildInputField(String label, String placeholder, isPassword, isEmail,
      isRequired, TextEditingController controller) {
    return MyInputField(
      label: label,
      placeholder: placeholder,
      isPassword: isPassword,
      isEmail: isEmail,
      isRequired: isRequired,
      keyboardType: TextInputType.text,
      controller: controller,
    );
  }
}

// ignore: non_constant_identifier_names
void Submit(context, email) {
  if (isValidEmail(email)) {
    Navigator.pushReplacementNamed(context, '/login');
  }
}

bool isValidEmail(String email) {
  final emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
  return emailRegex.hasMatch(email);
}
