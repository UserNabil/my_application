import 'package:my_taraji/views/fanpay/imports.dart';

class ButtonDisconnection extends StatelessWidget {
  const ButtonDisconnection({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.pushReplacementNamed(context, '/login');
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
