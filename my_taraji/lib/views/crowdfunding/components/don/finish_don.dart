import 'package:intl/intl.dart';
import 'package:my_taraji/views/fanpay/imports.dart';

class FinishDon extends StatelessWidget {
  const FinishDon({super.key, required this.user});
  final User? user;

  static DonUI donUI = DonUI();

  String formatDate(DateTime date) {
    String formattedDate = DateFormat('• HH:mm').format(date);

    return formattedDate;
  }

  String formatPhoneNumber(String phoneNumber) {
    if (phoneNumber.length < 8) return phoneNumber;
    return '(+216) ${phoneNumber.substring(0, 2)} ${phoneNumber.substring(2, 5)} XXX';
  }

  Container destinationCard() {
    String? imagePath = "images/pngs/taraji.png";
    return Container(
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: const Color(0xffF9FAFD),
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Row(
        children: [
          Container(
            decoration: const BoxDecoration(
              color: MyColors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(16),
              ),
            ),
            // ignore: unnecessary_null_comparison
            child: imagePath != null
                ? Image.asset(
                    'images/pngs/taraji.png',
                    fit: BoxFit.cover,
                    width: 50,
                    height: 50,
                  )
                : const SizedBox(
                    width: 50.0,
                    height: 50,
                  ),
          ),
          const SizedBox(width: 20.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              donUI.textType2('Taraji'),
              donUI.textType1(
                  '${formatPhoneNumber(user?.phone ?? "")} ${formatDate(DateTime.now())}',
                  false,
                  true),
            ],
          )
        ],
      ),
    );
  }

  Widget finishDon(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              const Text(
                "Bravo!",
                style: TextStyle(color: MyColors.blue3),
              ),
              const SizedBox(height: 10),
              const Text(
                "Don avec succès",
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 10),
              donUI.textType1(
                  "Votre don à été réalisé pour le compte de Taraji",
                  true,
                  false),
              const SizedBox(height: 10),
              donUI.dottedDivider(1.5, MyColors.grey),
              const SizedBox(height: 40),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  donUI.textType1("Don destination", false, false),
                  destinationCard(),
                ],
              ),
              const SizedBox(height: 20),
              donUI.textType1("Total don", false, false),
              Text(
                context.watch<DonProvider>().isTypeCash
                    ? "${context.watch<DonProvider>().convertedAmount} Coins"
                    : "${context.watch<DonProvider>().amountController.text} DT",
                style: const TextStyle(
                  color: MyColors.blue,
                  fontWeight: FontWeight.w600,
                  fontSize: 32.0,
                ),
              ),
              Text(
                context.watch<DonProvider>().isTypeCash
                    ? "${context.watch<DonProvider>().convertedAmount} Experience Points"
                    : "${context.watch<DonProvider>().amountController.text} Experience Points",
                style: const TextStyle(
                  color: Color(0xff08849D),
                  fontSize: 16.0,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            fixedSize: const Size(300.0, 50.0),
            backgroundColor: MyColors.orange,
          ),
          onPressed: () {
            context.read<DonProvider>().initAllData();
            context.read<FanPayProvider>().openModal();
            Navigator.pop(context);
          },
          child: const Text(
            "Retour à l'accueil",
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

  @override
  Widget build(BuildContext context) {
    return finishDon(context);
  }
}
