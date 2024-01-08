import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:my_taraji/core/models/compaign_model.dart';

class NumberInput extends StatelessWidget {
  const NumberInput({
    super.key,
    required this.campaign,
  });

  final Campaign campaign;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: campaign.questionCampaign![0].description,
        prefixIcon: const Icon(TablerIcons.numbers),
      ),
      keyboardType: TextInputType.number,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Veuillez entrer un nombre';
        }

        if (int.tryParse(value) == null) {
          return 'Veuillez entrer un nombre valide';
        }

        return null;
      },
    );
  }
}
