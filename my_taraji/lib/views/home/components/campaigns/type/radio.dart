import '../../../import.dart';

enum InputValue { value0, value1 }

class RadioInput extends StatefulWidget {
  const RadioInput(
      {super.key,
      required this.campaign,
      required this.radioController,
      this.question});

  final Campaign campaign;
  final TextEditingController radioController;
  final QuestionCampaign? question;

  @override
  RadioInputState createState() => RadioInputState();
}

class RadioInputState extends State<RadioInput> {
  InputValue? _character = InputValue.value0;

  @override
  void initState() {
    super.initState();
    widget.radioController.text = widget.question!.metas[0].value;
  }

  @override
  Widget build(BuildContext context) {
    List<Meta> groupedValue = widget.question!.metas;

    return Column(
      children: <Widget>[
        Text(widget.question!.description),
        RadioListTile<InputValue>(
          title: Text(groupedValue[0].value),
          value: InputValue.value0,
          groupValue: _character,
          onChanged: (InputValue? value) {
            setState(() {
              _character = value;
              widget.radioController.text = groupedValue[0].value;
            });
          },
        ),
        RadioListTile<InputValue>(
          title: Text(groupedValue[1].value),
          value: InputValue.value1,
          groupValue: _character,
          onChanged: (InputValue? value) {
            setState(() {
              _character = value;
              widget.radioController.text = groupedValue[1].value;
            });
          },
        ),
      ],
    );
  }
}
