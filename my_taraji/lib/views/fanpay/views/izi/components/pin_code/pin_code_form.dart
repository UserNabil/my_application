import 'package:my_taraji/views/fanpay/imports.dart';
import 'package:my_taraji/views/fanpay/views/izi/provider/izi_provider.dart';

class PinCodeForm extends StatelessWidget {
  const PinCodeForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: context.watch<IziProvider>().formKey,
      child: Padding(
        padding: const EdgeInsets.all(0.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            // PinCode
            TextFormField(
              controller: context.watch<IziProvider>().pinCode,
              keyboardType: TextInputType.number,
              maxLength: 4,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Ce champs est obligatoire.';
                }

                bool cinValid = RegExp(r'^[0-9]{4}$').hasMatch(value);
                if (!cinValid) {
                  return 'Pin code invalide.';
                }

                return null;
              },
              decoration: const InputDecoration(
                labelText: 'Pin code',
                hintText: 'XXXX',
                prefixIcon: Icon(TablerIcons.barcode),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
