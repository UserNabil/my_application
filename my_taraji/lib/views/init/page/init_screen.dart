import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:my_taraji/core/config/azureb2c_config.dart';
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
  bool isConnected = false;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  loadData() async {
    FlutterAppAuth appauth = const FlutterAppAuth();
    AuthorizationTokenResponse? result;
    try {
      result = await appauth.authorizeAndExchangeCode(
        AuthorizationTokenRequest(
          AzureB2cConfig.clientId,
          AzureB2cConfig.redirectURL,
          discoveryUrl: AzureB2cConfig.discoveryURL,
          scopes: AzureB2cConfig.scopes,
        ),
      );
      log('access token ${result?.accessToken}');
      log('id token ${result?.idToken}');
      setState(() {
        isConnected = true;
      });
    } catch (e) {
      log('error catched $e');
    }

    prefs = await SharedPreferences.getInstance();
    prefs.setString('accessToken', result?.accessToken ?? '');
  }

  @override
  Widget build(BuildContext context) {
    context.read<HomeProvider>().setCurrentLocation();
    context.read<HomeProvider>().setUserData();
    context.read<HomeProvider>().getUserData();
    List<Widget> pages = context.watch<InitProvider>().pages;

    Widget buildContent(BuildContext context) {
      return Scaffold(
        body: isConnected
            ? Stack(
                children: [
                  AnimatedSwitcher(
                      duration: const Duration(milliseconds: 500),
                      child: pages[context.watch<InitProvider>().currentIndex]),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: MyBottomBar(
                      active: items[context.watch<InitProvider>().currentIndex],
                      onTap: (item) {
                        context
                            .read<InitProvider>()
                            .setCurrentIndex(item.index);
                      },
                    ),
                  ),
                ],
              )
            : const Center(
                child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 20),
                  Text('Connexion en cours...'),
                ],
              )),
      );
    }

    return buildContent(context);
  }
}
