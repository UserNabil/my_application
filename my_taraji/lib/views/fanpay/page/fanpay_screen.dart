import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';

import '../imports.dart';

class MyFanPay extends StatefulWidget {
  const MyFanPay({super.key});
  static const routeName = '/fanpay';

  @override
  MyFanPayState createState() => MyFanPayState();
}

class MyFanPayState extends State<MyFanPay> {
  bool isOpen = false;
  ScrollController scrollController = ScrollController();
  FanPayModal transactionModal = FanPayModal(
    title: "Historiques",
    content: const FanPayHistorique(),
  );

  setModalStat() {
    setState(() {
      isOpen = !isOpen;
    });
  }

  Future<Map<String, String>> getUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String name = prefs.getString('name') ?? 'Error';

    return {
      'name': name,
    };
  }

  Widget menuSection(modal, scrollController, context, isOpen) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            "Transactions Récentes",
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w500,
            ),
          ),
          TextButton(
            style: TextButton.styleFrom(
              padding: const EdgeInsets.all(0),
              shadowColor: Colors.transparent,
              backgroundColor: Colors.transparent,
              foregroundColor: Colors.transparent,
              surfaceTintColor: Colors.transparent,
            ),
            onPressed: () {
              FanPayAction action = FanPayAction(
                icon: const Icon(
                  size: 20,
                  TablerIcons.filter,
                  color: MyColors.white,
                ),
                onTap: () {},
              );
              modal.show(context, setModalStat, action);
              scrollController.animateTo(
                0.0,
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeInOut,
              );
            },
            child: const Text(
              "Voir tout",
              style: TextStyle(
                color: MyColors.blue3,
                fontSize: 13,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildPage(
      Map<String, String> userData, BuildContext context, bool isOpen) {
    List<Widget> widgetsToDisplay = [
      FanPayTop(userData: userData, isOpen: isOpen, setModalStat: setModalStat),
      menuSection(transactionModal, scrollController, context, isOpen),
      const FanPayBottomContent(),
    ];

    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: ListView.builder(
                  controller: scrollController,
                  itemCount: widgetsToDisplay.length,
                  itemBuilder: (context, index) {
                    return widgetsToDisplay[index];
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getUserData(),
      builder: (context, AsyncSnapshot<Map<String, String>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }

        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }
        final userData = snapshot.data!;
        return buildPage(userData, context, isOpen);
      },
    );
  }
}
