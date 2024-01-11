import '../../../import.dart';

class TextareaInput extends StatelessWidget {
  const TextareaInput(
      {super.key, required this.campaign, required this.textareaController});
  final Campaign campaign;
  final TextEditingController textareaController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textareaController,
      maxLines: null,
      decoration: InputDecoration(
        labelText: campaign.questionCampaign![0].description,
        prefixIcon: const Icon(TablerIcons.a_b),
      ),
      validator: (value) {
        if (textareaController.text.isEmpty) {
          return 'Veuillez renseigner le texte';
        }
        return null;
      },
    );
  }
}
