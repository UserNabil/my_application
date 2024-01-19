import '../../imports.dart';

class FanPayBottomContent extends StatelessWidget {
  const FanPayBottomContent({super.key});

  @override
  Widget build(BuildContext context) {
    FanPayFakeData transitions = FanPayFakeData();

    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          FanPayTransactionLister(
              transitions: transitions.fakeData.sublist(0, 3)),
          const SizedBox(height: 100),
        ],
      ),
    );
  }
}
