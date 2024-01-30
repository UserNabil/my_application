import 'dart:ui';
import 'package:my_taraji/views/fanpay/imports.dart';
import 'package:my_taraji/views/fanpay/views/izi/components/sign_up/sign_up.dart';
import 'package:my_taraji/views/fanpay/views/izi/provider/izi_provider.dart';
import 'package:rive/rive.dart';

class FanPayIzi extends StatefulWidget {
  const FanPayIzi({super.key});

  @override
  FanPayIziState createState() => FanPayIziState();
}

class FanPayIziState extends State<FanPayIzi> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const RiveAnimation.asset('images/rives/shapes6.riv'),
        Positioned.fill(
            child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
          child: const SizedBox(),
        )),
        AnimatedPositioned(
          duration: const Duration(milliseconds: 200),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Spacer(),
                  SizedBox(
                    width: 300,
                    child: Column(children: [
                      Text(
                        "Pas de compte Izi ?",
                        style: TextStyle(
                          color: MyColors.white,
                          fontSize: 60,
                          height: 1.2,
                          shadows: [
                            Shadow(
                              color: Colors.black.withOpacity(0.7),
                              offset: const Offset(1, 1),
                              blurRadius: 30,
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      const Text(
                        "Veuillez créer votre wallet afin d'acceder à cette page.",
                        style: TextStyle(
                          color: MyColors.blue,
                          fontSize: 17,
                          fontWeight: FontWeight.w700,
                        ),
                      )
                    ]),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: context.watch<IziProvider>().wallet
                        ? () => goToSignUpIzi(context)
                        : () => goToSignInIzi(context),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: MyColors.white,
                      backgroundColor: context.watch<IziProvider>().wallet
                          ? MyColors.blue3
                          : MyColors.yellow,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        context.watch<IziProvider>().wallet
                            ? 'Me connecter'
                            : 'Cr�er mon compte',
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  const Spacer(
                    flex: 2,
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }

  void goToSignInIzi(BuildContext context) {
    context.read<IziProvider>().init();
    context
        .read<HomeProvider>()
        .getUserData()
        .then((value) => context.read<IziProvider>().prefillForm(value));

    Navigator.push(
      context,
      MaterialPageRoute(
        barrierDismissible: true,
        builder: (context) => const SignUpScreen(),
      ),
    );
  }

  void goToSignUpIzi(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        barrierDismissible: true,
        builder: (context) => const SignInScreen(),
      ),
    );
  }
}
