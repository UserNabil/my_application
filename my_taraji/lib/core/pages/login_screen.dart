import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../../feature/init/page/init_screen.dart';
import '../../feature/init/components/my_taraji_logo.dart';
import '../components/input_field.dart';
import '../components/my_button.dart';
import '../theme/my_color.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
  static const routeName = '/login';

  @override
  // ignore: library_private_types_in_public_api
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool rememberMe = false;

  @override
  void initState() {
    super.initState();
    loadRememberMeState();
  }

  Future<void> loadRememberMeState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      rememberMe = prefs.getBool('rememberMe') ?? false;
      emailController.text = prefs.getString('email') ?? '';
    });
  }

  Future<void> saveRememberMeState(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('rememberMe', value);
    if (!value) {
      prefs.setString('email', '');
    }
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
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 50),
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
                                'Bienvenue ! 👋',
                                style: TextStyle(
                                  color: MyColors.white,
                                  fontSize: 25,
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                'Salut à toi supporter du Taraji',
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
                    buildInputField('Mot de passe', '**********', true, false,
                        true, passwordController),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Checkbox(
                          value: rememberMe,
                          onChanged: (value) {
                            setState(() {
                              rememberMe = value!;
                              saveRememberMeState(value);
                            });
                          },
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              rememberMe = !rememberMe;
                              saveRememberMeState(rememberMe);
                            });
                          },
                          child: GestureDetector(
                            child: const Text(
                              'Se rappeler de moi',
                              style: TextStyle(color: MyColors.yellow),
                            ),
                          ),
                        ),
                        const Spacer(),
                        GestureDetector(
                          onTap: () {},
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pushReplacementNamed(
                                  context, '/reset_password');
                            },
                            child: const Text(
                              'Mot de passe oublié ?',
                              style: TextStyle(color: MyColors.redLight),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    MyButton(
                      icon: Icons.login,
                      text: 'Se connecter',
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
                          text: "Vous n'avez pas de compte ? ",
                          style: const TextStyle(
                            color: MyColors.yellow,
                            fontSize: 16,
                          ),
                          children: [
                            TextSpan(
                              text: "Inscription",
                              style: const TextStyle(
                                color: MyColors.white,
                                fontSize: 16,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.pushReplacementNamed(
                                      context, '/register');
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

  // ignore: non_constant_identifier_names
  void Submit(context, email, password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String storedEmail = prefs.getString('email') ?? '';
    String storedPassword = prefs.getString('password') ?? '';

    if (email == storedEmail && password == storedPassword) {
      // Login successful
      Navigator.pushNamed(context, InitScreen.routeName);
    } else {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Erreur lors de la connexion'),
            content: const Text('Veuillez vérifier vos informations'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }
}
