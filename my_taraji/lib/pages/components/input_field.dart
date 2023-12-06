import 'package:flutter/material.dart';
import 'my_color.dart';

class MyInputField extends StatefulWidget {
  final String label;
  final String placeholder;
  final bool isEmail;
  final bool isPassword;
  final bool isRequired;
  final TextInputType keyboardType;
  final TextEditingController controller;

  const MyInputField({
    Key? key,
    required this.label,
    required this.placeholder,
    this.isEmail = false,
    this.isPassword = false,
    this.isRequired = false,
    this.keyboardType = TextInputType.text,
    required this.controller,
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _MyInputFieldState createState() => _MyInputFieldState();
}

class _MyInputFieldState extends State<MyInputField> {
  String? errorText;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: const TextStyle(color: MyColors.white),
        ),
        const SizedBox(height: 8),
        TextField(
          obscureText: widget.isPassword,
          keyboardType: widget.keyboardType,
          controller: widget.controller,
          decoration: InputDecoration(
            filled: true,
            fillColor: MyColors.white,
            hintText: widget.placeholder,
            contentPadding: const EdgeInsets.all(12),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none,
            ),
            errorText: errorText,
          ),
        ),
      ],
    );
  }

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(validateInput);
  }

  void validateInput() {
    setState(() {
      errorText = validate(widget.controller.text);
    });
  }

  String? validate(String value) {
    if (widget.isRequired && value.isEmpty) {
      return 'Ce champ est obligatoire';
    }

    if (widget.isEmail && !isValidEmail(value)) {
      return 'Format e-mail invalide';
    }

    if (widget.isPassword && !isValidPassword(value)) {
      return 'Format du mot de passe invalide';
    }

    return null;
  }

  bool isValidEmail(String email) {
    final emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
    return emailRegex.hasMatch(email);
  }

  bool isValidPassword(String password) {
    final passwordRegex = RegExp(
      r'^(?=.*[A-Z])(?=.*[!@#$%^&*(),.?":{}|<>0-9]).{8,}$',
    );
    return passwordRegex.hasMatch(password);
  }

  @override
  void dispose() {
    widget.controller.dispose();
    super.dispose();
  }
}
