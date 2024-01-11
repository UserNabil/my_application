import '../../../import.dart';

class SelectInput extends StatelessWidget {
  const SelectInput({
    super.key,
    required this.campaign,
    required this.selectController,
    this.question,
  });

  final Campaign campaign;
  final TextEditingController selectController;
  final QuestionCampaign? question;

  @override
  Widget build(BuildContext context) {
    selectController.text = question?.options[0].id.toString() ?? "";
    return DropdownButtonFormField(
      decoration: InputDecoration(
        labelText: campaign.description,
        prefixIcon: const Icon(Icons.list),
      ),
      items: question?.options
          .map((option) => DropdownMenuItem(
                value: option.id,
                child: Text(option.name),
              ))
          .toList(),
      onChanged: (value) {
        selectController.text = value.toString();
      },
    );
  }
}
