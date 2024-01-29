import 'package:my_taraji/views/fanpay/imports.dart';

class FinishRecharge extends StatelessWidget {
  const FinishRecharge({super.key});

  @override
  Widget build(BuildContext context) {
    DonUI transfertUI = DonUI();
    Container destinationCard(BuildContext context) {
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
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                child: SvgPicture.asset(
                  "images/svgs/user_icon.svg",
                ),
              ),
            ),
            const SizedBox(width: 20.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                transfertUI.textType2('Numéro personnel'),
                transfertUI.textType1('(+216) 90 443 XXX • 7:55', false, true),
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
                  "Recharge terminée",
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 10),
                transfertUI.textType1(
                    "Votre recharge à été bien éffectuée", true, false),
                const SizedBox(height: 10),
                transfertUI.dottedDivider(1.5, MyColors.grey),
                const SizedBox(height: 40),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    transfertUI.textType1(
                        "Mobile recharge destination", false, false),
                    destinationCard(context),
                  ],
                ),
                const SizedBox(height: 20),
                transfertUI.textType1("Total recharge", false, false),
                const Text(
                  "5 000 DT",
                  style: TextStyle(
                    color: MyColors.blue,
                    fontWeight: FontWeight.w600,
                    fontSize: 32.0,
                  ),
                ),
                const Text(
                  "10 Experience Points",
                  style: TextStyle(
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
              context.read<RechargeProvider>().initAllData();
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

    return finishDon(context);
  }
}
