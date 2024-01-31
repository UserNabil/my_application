import 'package:my_taraji/views/fanpay/imports.dart';
import 'package:my_taraji/views/fanpay/views/izi/provider/izi_provider.dart';

class IziSignInForm extends StatelessWidget {
  const IziSignInForm({
    super.key,
    required this.formKey,
    required this.signinId,
    required this.signinPwd,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController signinId;
  final TextEditingController signinPwd;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Padding(
        padding: const EdgeInsets.all(0.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            // Téléphone
            TextFormField(
              controller: signinId,
              keyboardType: TextInputType.phone,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Ce champs est obligatoire.';
                }

                bool phoneValid = RegExp(r'^[0-9]+$').hasMatch(value);
                if (!phoneValid) {
                  return 'Entrer un numéro de téléphone valide';
                }

                return null;
              },
              decoration: const InputDecoration(
                labelText: 'Téléphone',
                hintText: '+33 6 12 34 56 78',
                prefixIcon: Icon(TablerIcons.phone),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            // Mot de passe
            TextFormField(
              controller: signinPwd,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Ce champs est obligatoire.';
                }

                if (value.length < 6) {
                  return 'Le mot de passe doit contenir au moins 6 caractères.';
                }
                return null;
              },
              obscureText: !context.watch<IziProvider>().showPassword,
              decoration: InputDecoration(
                  labelText: 'Mot de passe',
                  hintText: '*********',
                  prefixIcon: const Icon(TablerIcons.lock),
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: Icon(context.watch<IziProvider>().showPassword
                        ? TablerIcons.eye_off
                        : TablerIcons.eye),
                    onPressed: () {
                      context.read<IziProvider>().togglePassword();
                    },
                  )),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
