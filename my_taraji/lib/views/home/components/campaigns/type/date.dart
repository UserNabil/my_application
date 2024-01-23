import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:my_taraji/views/home/components/campaigns/models/compaign_model.dart';
import 'package:intl/intl.dart';

class DateInput extends StatefulWidget {
  const DateInput({
    super.key,
    required this.campaign,
    required this.dateController,
  });

  final Campaign campaign;
  final TextEditingController dateController;

  @override
  DateInputState createState() => DateInputState();
}

class DateInputState extends State<DateInput> {
  DateTime selectedDate = DateTime.now();
  TextEditingController dateControllerTest = TextEditingController();

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2015, 8),
      lastDate: DateTime(2101),
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        widget.dateController.text =
            DateFormat('dd/MM/yyyy').format(selectedDate);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    String error = '';
    return TextFormField(
      controller: widget.dateController,
      decoration: InputDecoration(
        labelText: widget.campaign.questionCampaign![0].description,
        prefixIcon: const Icon(TablerIcons.calendar),
      ),
      keyboardType: TextInputType.text,
      onChanged: (value) {
        if (widget.dateController.text.isEmpty) {
          error = 'Veuillez entrer une date';
        }
      },
      validator: (value) {
        if (widget.dateController.text.isEmpty) {
          return error;
        }
        return null;
      },
      onTap: () async {
        FocusScope.of(context).requestFocus(FocusNode());
        await selectDate(context);
      },
    );
  }
}
