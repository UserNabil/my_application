import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MyButton extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color textColor;
  final Color color;
  final bool isBlock;
  final VoidCallback onPressed;

  const MyButton({
    super.key,
    required this.icon,
    required this.text,
    required this.textColor,
    required this.color,
    this.isBlock = false,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return isBlock
        ? Expanded(
            child: ElevatedButton(
              onPressed: onPressed,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  vertical: 20,
                ),
                backgroundColor: color,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: buildButtonContent(),
            ),
          )
        : ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(
                vertical: 20,
              ),
              backgroundColor: color,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: buildButtonContent(),
          );
  }

  Widget buildButtonContent() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        FaIcon(
          icon,
          color: textColor,
        ),
        const SizedBox(
          width: 8,
        ),
        Text(
          text,
          style: TextStyle(
            color: textColor,
            fontSize: 16,
          ),
        ),
      ],
    );
  }
}
