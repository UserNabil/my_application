import 'package:my_taraji/views/home/provider/home_provider.dart';

import '../../import.dart';

class MyNavBar extends StatefulWidget {
  final List<NavBarItem> items;
  final ValueChanged<int> onItemSelected;

  const MyNavBar({
    super.key,
    required this.items,
    required this.onItemSelected,
  });

  @override
  MyNavBarState createState() => MyNavBarState();
}

class MyNavBarState extends State<MyNavBar> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(widget.items.length, (index) {
          return GestureDetector(
            onTap: () {
              context.read<HomeProvider>().setCurrentCardIndex(index);
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: index == context.watch<HomeProvider>().currentCardIndex
                    ? MyColors.red
                    : MyColors.transparent,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(widget.items[index].icon,
                      size: 25,
                      color: index ==
                              context.watch<HomeProvider>().currentCardIndex
                          ? Colors.white
                          : MyColors.grey),
                  const Padding(padding: EdgeInsets.all(5.0)),
                  Text(
                    widget.items[index].label,
                    style: TextStyle(
                      fontSize: 15,
                      color: index ==
                              context.watch<HomeProvider>().currentCardIndex
                          ? Colors.white
                          : MyColors.grey,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}

class NavBarItem {
  final IconData icon;
  final String label;

  NavBarItem({
    required this.icon,
    required this.label,
  });
}
