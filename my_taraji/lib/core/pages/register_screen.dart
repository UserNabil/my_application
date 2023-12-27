import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../components/input_field.dart';
import '../../views/init/components/my_taraji_logo.dart';
import '../theme/my_color.dart';
import '../components/my_button.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);
  static const routeName = '/register';

  @override
  // ignore: library_private_types_in_public_api
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController sponsorship = TextEditingController();
  bool accept = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                      logoImagePath: 'images/pngs/taraji.png',
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
                    const SizedBox(height: 16),
                    buildInputField('Code de parrainage', 'ET-SPONSORSHIP',
                        false, false, false, sponsorship),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Checkbox(
                          value: accept,
                          onChanged: (value) {
                            setState(() {
                              accept = value!;
                            });
                          },
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              accept = !accept;
                            });
                          },
                          child: GestureDetector(
                            child: const Text(
                              'Accepter les conditions générales',
                              style: TextStyle(color: MyColors.yellow),
                            ),
                          ),
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
                            passwordController.text, accept);
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
void Submit(context, email, password, accept) async {
  if (isValidEmail(email) && isValidPassword(password) && accept == true) {
    await saveRegistrationInfo(email, password);

    Navigator.pushReplacementNamed(context, '/login');
  }
}

Future<void> saveRegistrationInfo(String email, String password) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('email', email);
  prefs.setString('password', password);
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
