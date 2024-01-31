import 'package:flutter/cupertino.dart';
import 'package:my_taraji/views/fanpay/imports.dart';
import 'package:my_taraji/views/fanpay/providers/transfert_provider.dart';
import 'package:flutter_contacts/flutter_contacts.dart';

class FlutterContactsExample extends StatefulWidget {
  const FlutterContactsExample({super.key});

  @override
  FlutterContactsExampleState createState() => FlutterContactsExampleState();
}

class FlutterContactsExampleState extends State<FlutterContactsExample> {
  List<Contact>? _contacts;
  bool _permissionDenied = false;

  @override
  void initState() {
    super.initState();
    _fetchContacts();
  }

  Future _fetchContacts() async {
    if (!await FlutterContacts.requestPermission(readonly: true)) {
      setState(() => _permissionDenied = true);
    } else {
      final contacts = await FlutterContacts.getContacts();
      setState(() => _contacts = contacts);
    }
  }

  @override
  Widget build(BuildContext context) => MaterialApp(
      home: Scaffold(
          appBar: AppBar(title: const Text('flutter_contacts_example')),
          body: _body()));

  Widget _body() {
    if (_permissionDenied) {
      return const Center(child: Text('Permission denied'));
    }
    if (_contacts == null) {
      return const Center(child: CircularProgressIndicator());
    }
    return ListView.builder(
        itemCount: _contacts!.length,
        itemBuilder: (context, i) => ListTile(
            title: Text(_contacts![i].displayName),
            onTap: () async {
              final fullContact =
                  await FlutterContacts.getContact(_contacts![i].id);
              // ignore: use_build_context_synchronously
              await Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => ContactPage(fullContact!)));
            }));
  }
}

class ContactPage extends StatelessWidget {
  final Contact contact;
  const ContactPage(this.contact, {super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(title: Text(contact.displayName)),
      body: Column(children: [
        Text('First name: ${contact.name.first}'),
        Text('Last name: ${contact.name.last}'),
        Text(
            'Phone number: ${contact.phones.isNotEmpty ? contact.phones.first.number : '(none)'}'),
        Text(
            'Email address: ${contact.emails.isNotEmpty ? contact.emails.first.address : '(none)'}'),
      ]));
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
            child: SvgPicture.asset(
              "images/svgs/user_icon.svg",
            ),
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
              height: 50,
              width: 220,
              child: TextFormField(
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

  Widget buildContactList(contact) {
    return FlutterContactsExample();
  }

  Widget buildSelectPrice(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.5,
              child: Form(
                key: context.watch<RechargeProvider>().formKey,
                child: TextFormField(
                  textAlign: TextAlign.center,
                  controller:
                      context.watch<RechargeProvider>().numberController,
                  cursorColor: MyColors.blue3,
                  style: const TextStyle(
                    fontSize: 40.0,
                    fontWeight: FontWeight.w600,
                    decoration: TextDecoration.none,
                  ),
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
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
            ),
            const SizedBox(width: 50.0),
            const Text(
              "DT",
              style: TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.w400,
                decoration: TextDecoration.none,
              ),
            ),
          ],
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
                .watch<RechargeProvider>()
                .rechargeSettings
                .authorizedAmounts
                .map((authorizedAmount) {
              return ElevatedButton(
                onPressed: () {
                  context
                      .read<RechargeProvider>()
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        buildTop(context),
        transfertUI.divider(40.0),
        context.watch<TransfertProvider>().showContact
            ? buildContactList(context)
            : buildSelectPrice(context),
      ],
    );
  }
}
