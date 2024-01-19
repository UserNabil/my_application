import 'package:flutter/material.dart';
import 'package:my_taraji/views/selfcare/provider/self_care_provider.dart';
import 'package:provider/provider.dart';
import 'core/context/routes.dart';
import 'core/pages/loading_page.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => SelfCareProvider()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
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
