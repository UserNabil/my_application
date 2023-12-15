import 'package:flutter/material.dart';
import 'package:my_taraji/feature/fanpay/components/don/my_don_screen.dart';
import '../../../core/components/background_top.dart';
import '../../../core/components/top_navigation.dart';
import '../../init/components/my_card.dart';
import '../../../core/theme/my_color.dart';

void main() {
  runApp(const MaterialApp(
    home: DonScreen(),
  ));
}

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
  // ignore: library_private_types_in_public_api
  _DonScreenState createState() => _DonScreenState();
}

class _DonScreenState extends State<Don> {
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
          const CustomContainer(),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(children: [
              const SizedBox(height: 10),
              TopNavigation(
                  title: "Don", onPressed: onPressed, isParent: isParent),
              const Padding(
                  padding: EdgeInsets.only(top: 15),
                  child: DeformedContainer(width: 347, color: MyColors.yellow)),
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
