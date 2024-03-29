import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'components/my_taraji_logo.dart';
import 'components/my_color.dart';
import 'components/my_button.dart';
import 'components/input_field.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();
    final TextEditingController phoneController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
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
                      logoSize: 70,
                      textSize: 20,
                    ),
                    const SizedBox(height: 16),
                    const Align(
                        alignment: Alignment.centerLeft,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                'Créer un compte',
                                style: TextStyle(
                                  color: MyColors.white,
                                  fontSize: 25,
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                'Connectez-vous pour continuer',
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
                    buildInputField('Numéro de téléphone', '+33 06 14 14 14 14',
                        false, false, true, phoneController),
                    const SizedBox(height: 16),
                    buildInputField('Mot de passe', '**********', true, false,
                        true, passwordController),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Checkbox(
                          value: false,
                          onChanged: (value) {
                            value = !value!;
                          },
                        ),
                        const Text(
                          'Se rappeler de moi',
                          style: TextStyle(color: MyColors.yellow),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    MyButton(
                      icon: Icons.login,
                      text: "S'inscrire",
                      color: MyColors.yellow,
                      textColor: MyColors.white,
                      onPressed: () {
                        Submit(context, emailController.text,
                            passwordController.text);
                      },
                    ),
                    const SizedBox(height: 16),
                    GestureDetector(
                      onTap: () {},
                      child: Text.rich(
                        TextSpan(
                          text: "Vous avez déjà un compte ? ",
                          style: const TextStyle(
                            color: MyColors.yellow,
                            fontSize: 16,
                          ),
                          children: [
                            TextSpan(
                              text: "Se connecter",
                              style: const TextStyle(
                                color: MyColors.white,
                                fontSize: 16,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.pushReplacementNamed(
                                      context, '/login');
                                },
                            ),
                          ],
                        ),
                      ),
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
void Submit(context, email, password) {
  if (isValidEmail(email) && isValidPassword(password)) {
    Navigator.pushReplacementNamed(context, '/login');
  }
}

bool isValidEmail(String email) {
  final emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
  return emailRegex.hasMatch(email);
}

bool isValidPassword(String password) {
  final passwordRegex = RegExp(
    r'^(?=.*[A-Z])(?=.*[!@#$%^&*(),.?":{}|<>0-9]).{8,}$',
  );
  return passwordRegex.hasMatch(password);
}
