import 'package:my_taraji/views/fanpay/imports.dart';

// ignore: must_be_immutable
class ConfirmDon extends StatefulWidget {
  ConfirmDon({
    super.key,
    required this.amountController,
    required this.step,
    required this.cashType,
    required this.setStep,
    required this.setTypeCash,
  });
  final TextEditingController amountController;
  late String step;
  late bool cashType;
  late Function(String) setStep;
  late Function(bool) setTypeCash;

  @override
  ConfirmDonState createState() => ConfirmDonState();
}

class ConfirmDonState extends State<ConfirmDon> {
  DonUI donUI = DonUI();
  @override
  Widget build(BuildContext context) {
    Widget confirmDon() {
      return Column(
        children: [
          Container(
            alignment: Alignment.center,
            child: SvgPicture.asset(
                width: 150, height: 150, "images/svgs/fanpay/confirm_don.svg"),
          ),
          donUI.divider(20.0),
          Text(
            "${widget.amountController.text} DT",
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 32.0,
            ),
          ),
          const SizedBox(height: 10.0),
          donUI.textType1("Votre don pour Taraji", false),
          const SizedBox(height: 20.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              donUI.textType1("Payer par", false),
              donUI.textType2("Solde wallet"),
              Switch(
                thumbColor: MaterialStateProperty.all(MyColors.white),
                trackColor: MaterialStateProperty.all(MyColors.orange),
                trackOutlineWidth: MaterialStateProperty.all(0),
                trackOutlineColor:
                    MaterialStateProperty.all(Colors.transparent),
                value: widget.cashType,
                onChanged: (value) {
                  widget.setTypeCash(value);
                },
              ),
              donUI.textType2("Coins"),
            ],
          ),
          donUI.divider(40.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              donUI.textType1("Nombre des coins", false),
              donUI.textType2("${widget.amountController.text} Coins"),
            ],
          ),
          donUI.divider(40.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              donUI.textType1("Don destination", false),
              donUI.textType2("Taraji"),
            ],
          ),
          donUI.divider(40.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              donUI.textType1("Date", false),
              donUI.textType2("22 Avril, 2024 • 12:00"),
            ],
          ),
          const SizedBox(height: 50),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              fixedSize: const Size(300.0, 50.0),
              backgroundColor: MyColors.orange,
            ),
            onPressed: () {
              widget.setStep("finishDon");
            },
            child: const Text(
              "Confirmer",
              style: TextStyle(
                color: MyColors.white,
                fontSize: 16.0,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      );
    }

    return confirmDon();
  }
}
