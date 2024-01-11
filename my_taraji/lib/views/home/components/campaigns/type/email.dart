import '../../../import.dart';

class EmailInput extends StatelessWidget {
  const EmailInput({super.key, required this.campaign, required this.value});
  final Campaign campaign;
  final String value;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: value,
      decoration: const InputDecoration(
        labelText: 'Email',
        prefixIcon: Icon(TablerIcons.mail),
      ),
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Veuillez entrer votre email';
        }
        return null;
      },
    );
  }
}
