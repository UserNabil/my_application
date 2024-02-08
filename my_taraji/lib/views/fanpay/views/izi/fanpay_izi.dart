// ignore_for_file: dead_code

import 'package:my_taraji/views/fanpay/imports.dart';
import 'package:my_taraji/views/fanpay/models/account_card.dart';
import 'package:my_taraji/views/fanpay/views/izi/components/sign_up/sign_up.dart';
import 'package:my_taraji/views/fanpay/views/izi/provider/izi_provider.dart';

class FanPayIzi extends StatelessWidget {
  const FanPayIzi({super.key, required this.authDetails, required this.user});
  final AccountCard? authDetails;
  final User? user;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: context.read<HomeProvider>().getUserData(),
        builder: (context, snapshot) {
          final value = snapshot.data;
          if (snapshot.hasData) {
            return Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    MyColors.blue,
                    MyColors.blue3,
                  ],
                ),
              ),
              child: buildBody(context, value),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}

Widget buildBody(BuildContext context, User? user) {
  /*user?.mytarajiUser?.isSubscribedIZI ==*/
  bool haveWallet = true;
  // bool haveWallet = context.watch<IziProvider>().wallet;
  return Stack(
    children: [
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
                      haveWallet
                          ? "Bienvenue sur Fanpay"
                          : "Pas de compte Fanpay ?",
                      style: TextStyle(
                        color: MyColors.white,
                        fontSize: 50,
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
                    Text(
                      haveWallet
                          ? "Vous pouvez maintenant effectuer vos transactions en toute sécurité."
                          : "Veuillez créer votre wallet afin d'accéder à cette page.",
                      style: const TextStyle(
                        color: MyColors.yellow,
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                      ),
                    )
                  ]),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: haveWallet
                      ? () => goToSignInIzi(context)
                      : () => goToSignUpIzi(context),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: MyColors.white,
                    backgroundColor:
                        haveWallet ? MyColors.blue3 : MyColors.yellow,
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
                      haveWallet ? 'Me connecter' : 'Créer mon compte',
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

void goToSignUpIzi(BuildContext context) {
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

void goToSignInIzi(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(
      barrierDismissible: true,
      builder: (context) => const SignInScreen(),
    ),
  );
}
