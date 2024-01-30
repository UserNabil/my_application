import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:my_taraji/views/home/provider/home_provider.dart';
import 'package:my_taraji/views/init/components/bottom_bar/bar.dart';
import 'package:my_taraji/views/init/providers/init_taraji_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InitScreen extends StatefulWidget {
  const InitScreen({super.key});

  static String routeName = "/";

  @override
  State<InitScreen> createState() => _InitScreenState();
}

class _InitScreenState extends State<InitScreen> {
  late SharedPreferences prefs;
  final clientId = '1689eb93-8b4f-476f-bb17-8889533e4c65';
  final redirectURL = 'com.trendit.mytaraji://oauthredirect';
  final discoveryURL =
      'https://mytarajjib2c.b2clogin.com/myTarajjiB2c.onmicrosoft.com/v2.0/.well-known/openid-configuration?p=B2C_1_mytarajji_signup_signin';
  final List<String> scopes = [
    //  '1689eb93-8b4f-476f-bb17-8889533e4c65',
    'openid',
    // 'profile',
  ];

  @override
  void initState() {
    super.initState();
    loadData();
  }

  loadData() async {
    FlutterAppAuth _appauth = FlutterAppAuth();
    AuthorizationTokenResponse? result;
    try {
      result = await _appauth.authorizeAndExchangeCode(
        AuthorizationTokenRequest(clientId, redirectURL,
            //issuer: "https://prodplatform.b2clogin.com/ccab738-09c1-45df-8aca-7c17c285b689/v2.0/",
            discoveryUrl: discoveryURL,
            scopes: scopes),
      );
      log('token${result?.idToken}');
    } catch (e) {
      log('error catched $e');
    }

    prefs = await SharedPreferences.getInstance();
    while (prefs == null || result == null) continue;
    setState(() {
      prefs.setString('token', result?.idToken ?? 'no token');
    });
    //print(result);
    var accessToken = result.accessToken;
    log('accessToken $accessToken');
  }

  @override
  Widget build(BuildContext context) {
    context.read<HomeProvider>().setCurrentLocation();
    context.read<HomeProvider>().setUserData();
    context.read<HomeProvider>().getUserData();
    List<Widget> pages = context.watch<InitProvider>().pages;

    Widget buildContent(BuildContext context) {
      return Scaffold(
        body: Stack(
          children: [
            AnimatedSwitcher(
                duration: const Duration(milliseconds: 500),
                child: pages[context.watch<InitProvider>().currentIndex]),
            Align(
              alignment: Alignment.bottomCenter,
              child: MyBottomBar(
                active: items[context.watch<InitProvider>().currentIndex],
                onTap: (item) {
                  context.read<InitProvider>().setCurrentIndex(item.index);
                },
              ),
            ),
          ],
        ),
      );
    }

    return buildContent(context);
  }
}
