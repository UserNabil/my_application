import '../../../import.dart';
import 'package:flutter/services.dart';

class PhoneInput extends StatelessWidget {
  const PhoneInput(
      {super.key, required this.campaign, required this.phoneController});
  final Campaign campaign;
  final TextEditingController phoneController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: phoneController,
      decoration: const InputDecoration(
        labelText: 'Numéro de téléphone',
        prefixIcon: Icon(TablerIcons.phone),
      ),
      keyboardType: TextInputType.phone,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
      ],
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Veuillez entrer votre numéro de téléphone';
        }
        return null;
      },
    );
  }
}
