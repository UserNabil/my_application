import 'package:my_taraji/views/fanpay/imports.dart';
import 'package:my_taraji/views/fanpay/providers/transfert_provider.dart';

class FinishTransfert extends StatefulWidget {
  const FinishTransfert({super.key});

  @override
  FinishTransfertState createState() => FinishTransfertState();
}

class FinishTransfertState extends State<FinishTransfert> {
  DonUI transfertUI = DonUI();

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
              transfertUI.textType2('Taraji'),
              transfertUI.textType1('(+216) 90 443 XXX • 7:55', false, true),
            ],
          )
        ],
      ),
    );
  }

  Widget finishTransfert() {
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
                "Transfert avec succès",
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 10),
              transfertUI.textType1(
                  "Votre transfert à été réalisé pour le compte de Taraji",
                  true,
                  false),
              const SizedBox(height: 10),
              transfertUI.dottedDivider(1.5, MyColors.grey),
              const SizedBox(height: 40),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  transfertUI.textType1("Transfert destination", false, false),
                  destinationCard(),
                ],
              ),
              const SizedBox(height: 20),
              transfertUI.textType1("Total Transfert", false, false),
              Text(
                context.watch<TransfertProvider>().isTypeCash
                    ? "${context.watch<TransfertProvider>().convertedAmount} Coins"
                    : "${context.watch<TransfertProvider>().amountController.text} DT",
                style: const TextStyle(
                  color: MyColors.blue,
                  fontWeight: FontWeight.w600,
                  fontSize: 32.0,
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
            context.read<TransfertProvider>().initAllData();
            context.read<FanPayProvider>().openModal();
            // context.read<InitProvider>().initCurrentIndex();
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
    return finishTransfert();
  }
}
