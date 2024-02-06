import 'package:my_taraji/views/fanpay/imports.dart';
import 'package:my_taraji/views/selfcare/models/pages_enum.dart';
import 'package:my_taraji/views/selfcare/provider/self_care_provider.dart';

class ButtonCGU extends StatelessWidget {
  const ButtonCGU({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        context.read<SelfCareProvider>().switchPage(PageViewEnum.cgu);
      },
      child: const Text(
        'Conditions générales d\'utilisation',
        style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w600,
          color: MyColors.black,
        ),
      ),
    );
  }
}
