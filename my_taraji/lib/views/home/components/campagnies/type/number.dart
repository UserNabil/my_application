import 'package:flutter/material.dart';

class NumberInput extends StatelessWidget {
  const NumberInput({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: const InputDecoration(
        // border: OutlineInputBorder(),
        labelText: 'Code de vérification',
        prefixIcon: Icon(Icons.numbers),
      ),
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Veuillez entrer votre age';
        }
        return null;
      },
    );
  }
}
