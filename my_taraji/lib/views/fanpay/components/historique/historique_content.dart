import '../../imports.dart';

class FanPayHistorique extends StatelessWidget {
  const FanPayHistorique({super.key});

  @override
  Widget build(BuildContext context) {
    FanPayFakeData transitions = FanPayFakeData();
    return Padding(
      padding: const EdgeInsets.all(30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Category Chart",
            style: TextStyle(
              color: MyColors.black,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          const DonutChartWithSections(),
          const SizedBox(height: 20),
          const Text(
            "Historique des transactions",
            style: TextStyle(
              color: MyColors.black,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          FanPayTransactionLister(transitions: transitions.fakeData),
        ],
      ),
    );
  }
}
