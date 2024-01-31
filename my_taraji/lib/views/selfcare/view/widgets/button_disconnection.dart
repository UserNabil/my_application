import 'dart:developer';

import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:my_taraji/views/fanpay/imports.dart';

class ButtonDisconnection extends StatelessWidget {
  const ButtonDisconnection({super.key});

  @override
  Widget build(BuildContext context) {
    FlutterAppAuth appauth = const FlutterAppAuth();
    return TextButton(
      onPressed: () async {
        final prefs = await SharedPreferences.getInstance();
        final String? token = prefs.getString('token');
        final endSessionRes = await appauth.endSession(
          EndSessionRequest(
            idTokenHint: token,
            discoveryUrl:
                'https://mytarajjib2c.b2clogin.com/myTarajjiB2c.onmicrosoft.com/v2.0/.well-known/openid-configuration?p=B2C_1_mytarajji_signup_signin',
            postLogoutRedirectUrl: 'com.trendit.mytaraji://oauthredirect',
          ),
        );
        log("endSessionRes ${endSessionRes?.state}");
        await prefs.remove('token');
        Navigator.pushReplacementNamed(context, '/');
      },
      child: const Text(
        'Déconnexion',
        style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w600,
          color: MyColors.yellow,
        ),
      ),
    );
  }
}
