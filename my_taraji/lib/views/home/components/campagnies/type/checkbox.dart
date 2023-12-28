import 'package:flutter/material.dart';

class ChoiceInput extends StatefulWidget {
  final List<String> options;
  final List<String> selectedOptions;
  final bool isRadio; // New flag to indicate radio or multi-choice behavior

  const ChoiceInput({
    Key? key,
    this.options = const ['Option 1', 'Option 2', 'Option 3'],
    this.selectedOptions = const ['Option 1'],
    required this.isRadio,
  }) : super(key: key);

  @override
  ChoiceInputState createState() => ChoiceInputState();
}

class ChoiceInputState extends State<ChoiceInput> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: widget.options.map((option) {
        bool isSelected = widget.selectedOptions.contains(option);

        return Row(
          children: [
            // Use Radio or Checkbox based on the isRadio flag
            widget.isRadio
                ? Radio(
                    value: option,
                    groupValue: widget.selectedOptions.first,
                    onChanged: (value) {
                      setState(() {
                        if (value != null) {
                          widget.selectedOptions.clear();
                          widget.selectedOptions.add(value.toString());
                        }
                      });
                    },
                  )
                : Checkbox(
                    value: isSelected,
                    onChanged: (value) {
                      setState(() {
                        if (value != null) {
                          if (value) {
                            widget.selectedOptions.add(option);
                          } else {
                            widget.selectedOptions.remove(option);
                          }
                        }
                      });
                    },
                  ),
            Text(option),
          ],
        );
      }).toList(),
    );
  }
}
