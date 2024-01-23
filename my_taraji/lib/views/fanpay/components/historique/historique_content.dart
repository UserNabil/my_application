import '../../imports.dart';

class FanPayHistorique extends StatelessWidget {
  const FanPayHistorique({super.key});

  Widget buildBody(BuildContext context) {
    FanPayFakeData transitions = FanPayFakeData();
    return Column(
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.17,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
            color: Colors.transparent,
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                    context.read<FanPayProvider>().openModal();
                  },
                  child: const Icon(
                    size: 25,
                    TablerIcons.arrow_left,
                    color: MyColors.white,
                  ),
                ),
                Text(
                  context.watch<HistoriqueProvider>().title,
                  style: const TextStyle(
                    color: MyColors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                GestureDetector(
                  onTap: () {},
                  child: const Icon(
                    size: 20,
                    TablerIcons.filter,
                    color: MyColors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.83,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(32),
                  topRight: Radius.circular(32),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    'images/icons/drag.svg',
                    height: 5,
                    width: 5,
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.81,
                    width: MediaQuery.of(context).size.width,
                    decoration: const BoxDecoration(
                      color: Colors.transparent,
                    ),
                    child: SingleChildScrollView(
                      child: Padding(
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
                            FanPayTransactionLister(
                                transitions: transitions.fakeData),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return buildBody(context);
  }
}
