import 'package:my_taraji/views/fanpay/imports.dart';
import 'package:my_taraji/views/init/providers/init_taraji_provider.dart';
import 'core/context/routes.dart';
import 'core/pages/loading_page.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => FanPayProvider()),
      ChangeNotifierProvider(create: (_) => DonProvider()),
      ChangeNotifierProvider(create: (_) => HistoriqueProvider()),
      ChangeNotifierProvider(create: (_) => InitProvider()),
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
