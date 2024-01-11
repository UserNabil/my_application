import '../../../import.dart';

class NumberInput extends StatelessWidget {
  const NumberInput({
    super.key,
    required this.campaign,
    required this.numberController,
  });

  final Campaign campaign;
  final TextEditingController numberController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: numberController.text,
      decoration: InputDecoration(
        labelText: campaign.questionCampaign![0].description,
        prefixIcon: const Icon(TablerIcons.numbers),
      ),
      keyboardType: TextInputType.number,
      validator: (inputValue) {
        if (inputValue == null || inputValue.isEmpty) {
          return 'Veuillez entrer un nombre';
        }

        if (int.tryParse(inputValue) == null) {
          return 'Veuillez entrer un nombre valide';
        }

        return null;
      },
    );
  }
}
