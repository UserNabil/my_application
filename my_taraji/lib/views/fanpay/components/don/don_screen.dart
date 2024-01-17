import '../../imports.dart';

class DonScreen extends StatelessWidget {
  const DonScreen({super.key});
  static const routeName = '/don';

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: Don(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class Don extends StatefulWidget {
  const Don({super.key});

  @override
  DonScreenState createState() => DonScreenState();
}

class DonScreenState extends State<Don> {
  bool isParent = true;

  @override
  void initState() {
    super.initState();
  }

  void onPressed() {
    setState(() {
      isParent = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> widgetsToDisplay = [
      Stack(
        children: [
          const CustomContainer(
            colorTo: MyColors.red,
            colorFrom: MyColors.redDarker,
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(children: [
              const SizedBox(height: 10),
              TopNavigation(
                title: "Don",
                onPressed: onPressed,
                currentContent: '',
              ),
              const Padding(
                  padding: EdgeInsets.only(top: 15),
                  child: CustomCard(
                      svgUrl: '',
                      color: MyColors.yellow,
                      width: 347,
                      height: 237)),
            ]),
          ),
          const Column(children: [
            SizedBox(height: 125),
            MyDon(),
            SizedBox(height: 50),
          ]),
        ],
      )
    ];

    return ListView.builder(
      itemCount: widgetsToDisplay.length,
      itemBuilder: (context, index) {
        return widgetsToDisplay[index];
      },
    );
  }
}
