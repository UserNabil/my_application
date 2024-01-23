import 'package:flutter/material.dart';
import 'package:my_taraji/views/fanpay/providers/fanpay_don_provider.dart';
import 'package:my_taraji/views/fanpay/providers/fanpay_historique_provider.dart';
import 'package:my_taraji/views/fanpay/providers/fanpay_provider.dart';
import 'package:my_taraji/views/home/components/news/provider/news_provider.dart';
import 'package:my_taraji/views/home/provider/home_provider.dart';
import 'package:my_taraji/views/init/providers/init_taraji_provider.dart';
import 'package:my_taraji/views/selfcare/provider/self_care_provider.dart';
import 'package:provider/provider.dart';
import 'core/context/routes.dart';
import 'core/pages/loading_page.dart';

void main() async {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => SelfCareProvider()),
      ChangeNotifierProvider(create: (_) => FanPayProvider()),
      ChangeNotifierProvider(create: (_) => DonProvider()),
      ChangeNotifierProvider(create: (_) => HistoriqueProvider()),
      ChangeNotifierProvider(create: (_) => InitProvider()),
      ChangeNotifierProvider(create: (_) => NewsProvider()),
      ChangeNotifierProvider(create: (_) => HomeProvider()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<InitProvider>().initStatusPermissions();
    return MaterialApp(
      locale: const Locale('fr', 'FR'),
      title: 'My Taraji',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Poppins',
      ),
      initialRoute: LoadingScreen.routeName,
      routes: routes,
    );
  }
}
