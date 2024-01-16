import '../../../import.dart';

class FormulaInput extends StatelessWidget {
  const FormulaInput({
    super.key,
    required this.campaign,
    required this.formulaController,
    this.question,
  });

  final Campaign campaign;
  final TextEditingController formulaController;
  final QuestionCampaign? question;

  @override
  Widget build(BuildContext context) {
    var questionDetails = question!.metas;
    double numericValue = double.parse(formulaController.text);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Text(
            question!.description,
            style: const TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: questionDetails[0].value == "number"
              ? NumberInput(
                  campaign: campaign,
                  numberController: formulaController,
                )
              : TextareaInput(
                  campaign: campaign,
                  textareaController: formulaController,
                ),
        ),
        (numericValue < -100 || numericValue > 100)
            ? const Text('Valeur hors intervalle [-100, 100]')
            : const Text(''),
      ],
    );
  }
}
