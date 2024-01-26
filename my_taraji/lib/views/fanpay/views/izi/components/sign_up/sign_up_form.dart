import 'dart:io';
import 'package:my_taraji/views/fanpay/imports.dart';
import 'package:my_taraji/views/fanpay/views/izi/provider/izi_provider.dart';

class IziSignUpForm extends StatelessWidget {
  const IziSignUpForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: context.watch<IziProvider>().formKey,
      child: Padding(
        padding: const EdgeInsets.all(0.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            // Nom
            TextFormField(
              keyboardType: TextInputType.text,
              controller: context.watch<IziProvider>().lastName,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Ce champs est obligatoire.';
                }
                return null;
              },
              decoration: const InputDecoration(
                labelText: 'Nom',
                hintText: 'DOE',
                prefixIcon: Icon(TablerIcons.user_edit),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            // Prénom
            TextFormField(
              controller: context.watch<IziProvider>().firstName,
              keyboardType: TextInputType.text,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Ce champs est obligatoire.';
                }
                return null;
              },
              decoration: const InputDecoration(
                labelText: 'Prénom',
                hintText: 'John',
                prefixIcon: Icon(TablerIcons.user_edit),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            // CIN
            TextFormField(
              controller: context.watch<IziProvider>().cin,
              keyboardType: TextInputType.number,
              maxLength: 8,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Ce champs est obligatoire.';
                }

                bool cinValid = RegExp(r'^[0-9]{8}$').hasMatch(value);
                if (!cinValid) {
                  return 'Entrer un CIN valide';
                }

                return null;
              },
              decoration: const InputDecoration(
                labelText: 'Numero de CIN',
                hintText: 'XXXX XXXX',
                prefixIcon: Icon(TablerIcons.cards),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            // Email
            TextFormField(
              controller: context.watch<IziProvider>().email,
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Ce champs est obligatoire.';
                }

                bool emailValid =
                    RegExp(r'^[a-zA-Z0-9]+@[a-zA-Z0-9]+\.[a-zA-Z]+$')
                        .hasMatch(value);
                if (!emailValid) {
                  return 'Entrer un email valide';
                }

                return null;
              },
              decoration: const InputDecoration(
                labelText: 'Email',
                hintText: 'john.doe@mail.org',
                prefixIcon: Icon(TablerIcons.mail),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            // Téléphone
            TextFormField(
              controller: context.watch<IziProvider>().phone,
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
            // Sexe
            DropdownButtonFormField<String>(
              value: context.watch<IziProvider>().sexe.text,
              icon: const Icon(TablerIcons.chevron_down),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Ce champ est obligatoire.';
                }
                return null;
              },
              decoration: const InputDecoration(
                labelText: 'Sexe',
                prefixIcon: Icon(TablerIcons.user_check),
                border: OutlineInputBorder(),
              ),
              items: [
                DropdownMenuItem(
                  enabled: false,
                  value: '',
                  child: Text(
                    'Sélectionner un sexe',
                    style: TextStyle(
                        color: Colors.black.withOpacity(0.8),
                        fontWeight: FontWeight.w400),
                  ),
                ),
                const DropdownMenuItem(
                  value: '0',
                  child: Text('Homme'),
                ),
                const DropdownMenuItem(
                  value: '1',
                  child: Text('Femme'),
                ),
              ],
              onChanged: (value) {
                context.read<IziProvider>().sexe.text = value!;
              },
            ),
            const SizedBox(height: 20),
            // Date de naissance
            TextFormField(
              keyboardType: TextInputType.streetAddress,
              controller: context.watch<IziProvider>().birthDate,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Ce champ est obligatoire.';
                }
                return null;
              },
              decoration: const InputDecoration(
                labelText: 'Date de naissance',
                prefixIcon: Icon(Icons.calendar_today),
                border: OutlineInputBorder(),
              ),
              onTap: () async {
                await context.read<IziProvider>().selectDate(context);
              },
            ),
            const SizedBox(height: 20),
            // Adresse
            TextFormField(
              controller: context.watch<IziProvider>().address,
              keyboardType: TextInputType.streetAddress,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Ce champs est obligatoire.';
                }
                return null;
              },
              decoration: const InputDecoration(
                labelText: 'Adresse',
                hintText: '19 rue de la paix, Paris 75009',
                prefixIcon: Icon(TablerIcons.map_2),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                // Photo
                isNotNullFile(
                  buildPhotoInput(context, "Selfie"),
                  context.watch<IziProvider>().selfie,
                ),
                const SizedBox(width: 10),
                // CIN Recto
                isNotNullFile(
                  buildFileInput(
                    context,
                    "CIN Recto",
                    () => context.read<IziProvider>().importRectoFile(),
                    context.watch<IziProvider>().cinRectoColorInput,
                  ),
                  context.watch<IziProvider>().cinRectoFile,
                ),
                const SizedBox(width: 10),
                // CIN Verso
                isNotNullFile(
                  buildFileInput(
                    context,
                    "CIN Verso",
                    () => context.read<IziProvider>().importVersoFile(),
                    context.watch<IziProvider>().cinVersoColorInput,
                  ),
                  context.watch<IziProvider>().cinVersoFile,
                ),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget isNotNullFile(Widget child, File? file) {
    if (file != null) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          child,
          const SizedBox(height: 10),
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.black54, width: 1),
              image: DecorationImage(
                image: FileImage(file),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      );
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          child,
          const SizedBox(height: 10),
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: Colors.black54,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Center(
              child: Text(
                "Vide",
                style: TextStyle(color: Colors.white54),
              ),
            ),
          ),
        ],
      );
    }
  }

  Widget buildPhotoInput(BuildContext context, String title) {
    return Column(
      children: [
        GestureDetector(
          onTap: context.read<IziProvider>().takePicture,
          child: Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: MyColors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: context.watch<IziProvider>().selfiColorInput,
                width: 1,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  TablerIcons.camera_selfie,
                  size: 40,
                  color: context.watch<IziProvider>().selfiColorInput,
                ),
                const SizedBox(height: 8),
                Text(
                  title,
                  style: TextStyle(
                    color: context.watch<IziProvider>().selfiColorInput,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget buildFileInput(
      BuildContext context, String title, Function() onTap, Color color) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          color: MyColors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: color,
            width: 1,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              TablerIcons.user_scan,
              size: 40,
              color: color,
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: TextStyle(
                color: color,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
