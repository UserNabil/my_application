import 'package:flutter/cupertino.dart';
import 'package:my_taraji/views/fanpay/imports.dart';
import 'package:my_taraji/views/fanpay/providers/transfert_provider.dart';
import 'package:flutter_contacts/flutter_contacts.dart';

class ListContacts extends StatelessWidget {
  const ListContacts({super.key});

  static DonUI transfertUI = DonUI();

  void setContacts(List<Contact> contacts, BuildContext context) {
    context.read<TransfertProvider>().setListContact(contacts);
    context.read<TransfertProvider>().setFiltredContacts(List.from(contacts));
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: context.read<TransfertProvider>().fetchContacts(),
      builder: (context, AsyncSnapshot<List<Contact>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(
              color: MyColors.blue3,
            ),
          );
        }

        if (snapshot.hasError) {
          return const Center(
            child: Text("Erreur lors du chargement des contacts"),
          );
        }

        if (snapshot.hasData) {
          setContacts(snapshot.data!, context);
          return Consumer<TransfertProvider>(
            builder: (context, provider, child) {
              return Column(
                children: [
                  buildSearch(context),
                  const SizedBox(height: 20),
                  Expanded(
                    child: buildListContact(
                      context,
                      provider.filtredContacts,
                    ),
                  ),
                ],
              );
            },
          );
        }

        return const Center(
          child: Text("Aucun contact trouvé"),
        );
      },
    );
  }

  Widget buildSearch(BuildContext context) {
    return Container(
      height: 50,
      width: 300,
      decoration: BoxDecoration(
        color: MyColors.transparent,
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextFormField(
        onChanged: (value) =>
            context.read<TransfertProvider>().searchContacts(value),
        decoration: InputDecoration(
          hintText: "Rechercher un contact",
          hintStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Color(0xff9CA3AF),
          ),
          // bordure fine
          border: OutlineInputBorder(
            borderRadius: const BorderRadius.all(
              Radius.circular(15),
            ),
            borderSide: BorderSide(
              color: const Color(0xff9CA3AF).withOpacity(0.3),
              width: 1,
            ),
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 10.0,
            vertical: 10.0,
          ),
          prefixIcon: const Icon(
            TablerIcons.search,
            color: Color(0xff9CA3AF),
          ),
        ),
      ),
    );
  }

  Widget buildAlphabetColumn() {
    return Column(
      children: [
        const SizedBox(height: 10),
        ...List.generate(26, (index) {
          return Text(
            String.fromCharCode(index + 65),
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Color(0xff9CA3AF),
            ),
          );
        }),
      ],
    );
  }

  Widget buildContactRow(Contact? contact) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: 50,
              width: 50,
              decoration: const BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.all(
                  Radius.circular(50),
                ),
              ),
              child: Image.asset("images/pngs/contact.png"),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 200,
                  child: Text(
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    contact?.displayName ?? "Nom inconnu",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Color(0xff111827),
                    ),
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  contact?.phones.isNotEmpty == true
                      ? contact?.phones[0].normalizedNumber ?? "Numéro inconnu"
                      : "Numéro inconnu",
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Color(0xff9CA3AF),
                  ),
                ),
              ],
            ),
          ],
        ),
        transfertUI.divider(30.0),
      ],
    );
  }

  Widget buildListContact(BuildContext context, List<Contact> contacts) {
    if (contacts.isEmpty) {
      return const Text(
        "Aucun contact trouvé",
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.grey,
        ),
      );
    }

    setPhone(Contact? contact) {
      context.read<TransfertProvider>().setNumberPhone(contact);
    }

    return ListView.builder(
      padding: const EdgeInsets.all(0),
      itemCount: contacts.length,
      prototypeItem: buildContactRow(contacts[0]),
      itemBuilder: (context, i) => ListTile(
        contentPadding: const EdgeInsets.all(0),
        title: buildContactRow(contacts[i]),
        onTap: () => setPhone(contacts[i]),
      ),
    );
  }
}

class MyTransfert extends StatelessWidget {
  const MyTransfert({super.key, required this.user});

  final User? user;

  static DonUI transfertUI = DonUI();

  Widget buildTop(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 75,
          width: 75,
          decoration: const BoxDecoration(
            color: Colors.transparent,
            border: Border.fromBorderSide(
              BorderSide(
                color: Color(0xffE5E7EB),
                width: 2,
              ),
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(15),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: context
                    .watch<TransfertProvider>()
                    .phoneController
                    .text
                    .isNotEmpty
                ? Image.asset(
                    "images/pngs/contact.png",
                    fit: BoxFit.cover,
                    width: 50,
                    height: 50,
                  )
                : const SizedBox(),
          ),
        ),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Numéro de téléphone",
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 5),
            Container(
              decoration: const BoxDecoration(
                color: Colors.transparent,
                border: Border.fromBorderSide(
                  BorderSide(
                    color: Color(0xffE5E7EB),
                    width: 2,
                  ),
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(15),
                ),
              ),
              // height: 50,
              width: MediaQuery.of(context).size.width * 0.55,
              child: TextFormField(
                controller: context.watch<TransfertProvider>().phoneController,
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
                cursorColor: MyColors.blue3,
                decoration: InputDecoration(
                  prefix: const Text("(+216) "),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 10.0,
                    vertical: 10.0,
                  ),
                  label: null,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      TablerIcons.book_2,
                      color: context.watch<TransfertProvider>().showContact
                          ? MyColors.blue3
                          : MyColors.grey,
                    ),
                    onPressed: () {
                      context.read<TransfertProvider>().toggleShowContact();
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget buildSelectPrice(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          // width: MediaQuery.of(context).size.width,
          child: TextFormField(
            textAlign: TextAlign.center,
            controller: context.watch<TransfertProvider>().amountController,
            cursorColor: MyColors.blue3,
            style: const TextStyle(
              fontSize: 40.0,
              fontWeight: FontWeight.w600,
              decoration: TextDecoration.none,
            ),
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              errorMaxLines: 2,
              suffix: Text(
                "DT",
                style: TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.w400,
                  decoration: TextDecoration.none,
                ),
              ),
              border: InputBorder.none,
              contentPadding: EdgeInsets.zero,
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Veuillez entrer un montant";
              }

              return null;
            },
          ),
        ),
        const SizedBox(height: 10.0),
        transfertUI.divider(0.0),
        const SizedBox(height: 20.0),
        Container(
          height: 200,
          alignment: Alignment.topCenter,
          child: Wrap(
            spacing: 10.0,
            runSpacing: 20.0,
            children: context
                .watch<TransfertProvider>()
                .transfertSettings
                .authorizedAmounts
                .map((authorizedAmount) {
              return ElevatedButton(
                onPressed: () {
                  context
                      .read<TransfertProvider>()
                      .setAmount(authorizedAmount.amount);
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15.0,
                    vertical: 10.0,
                  ),
                  backgroundColor: const Color(0xffF0F5FF),
                  foregroundColor: const Color(0xff3784FB),
                  surfaceTintColor: const Color(0xffF0F5FF),
                ),
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    '${authorizedAmount.amount} DT',
                    style: const TextStyle(
                      color: Color(0xff3784FB),
                      fontSize: 14.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
        SlideAction(
          thumbWidth: 70,
          stretchThumb: true,
          trackHeight: 60,
          trackBuilder: (context, state) {
            return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: const Color(0xffF0F5FF),
              ),
              child: Center(
                child: Text(
                  state.isPerformingAction
                      ? "Chargement..."
                      : "Glisser pour continuer",
                  style: const TextStyle(
                    color: MyColors.black,
                    fontSize: 14.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            );
          },
          thumbBuilder: (context, state) {
            return Container(
              alignment: Alignment.centerRight,
              decoration: BoxDecoration(
                color: MyColors.orange,
                borderRadius: BorderRadius.circular(30),
              ),
              child: state.isPerformingAction
                  ? const Center(
                      child: CupertinoActivityIndicator(
                        color: Colors.white,
                      ),
                    )
                  : const Padding(
                      padding: EdgeInsets.only(right: 15),
                      child: Icon(
                        size: 40,
                        TablerIcons.chevrons_right,
                        color: Colors.white,
                      ),
                    ),
            );
          },
          action: () async {
            await Future.delayed(
              const Duration(seconds: 1),
              () {
                context.read<TransfertProvider>().setStep("confirmTransfert");
              },
            );
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: context.watch<TransfertProvider>().formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          buildTop(context),
          transfertUI.divider(40.0),
          context.watch<TransfertProvider>().showContact
              ? SizedBox(
                  height: MediaQuery.of(context).size.height * 0.7,
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: const ListContacts(),
                )
              : buildSelectPrice(context),
        ],
      ),
    );
  }
}
