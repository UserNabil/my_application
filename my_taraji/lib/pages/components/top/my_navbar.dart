// ignore_for_file: library_private_types_in_public_api
import 'package:flutter/material.dart';
import '../../core/my_color.dart';

class MyNavBar extends StatefulWidget {
  final List<NavBarItem> items;
  final ValueChanged<int> onItemSelected;

  const MyNavBar({
    Key? key,
    required this.items,
    required this.onItemSelected,
  }) : super(key: key);

  @override
  _MyNavBarState createState() => _MyNavBarState();
}

class _MyNavBarState extends State<MyNavBar> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(widget.items.length, (index) {
          return GestureDetector(
            onTap: () {
              setState(() {
                selectedIndex = index;
              });
              widget.onItemSelected(index);
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: index == selectedIndex
                    ? MyColors.red
                    : MyColors.transparent,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(widget.items[index].icon,
                      size: 30,
                      color: index == selectedIndex
                          ? Colors.white
                          : MyColors.grey),
                  const Padding(padding: EdgeInsets.all(5.0)),
                  Text(
                    widget.items[index].label,
                    style: TextStyle(
                      fontSize: 17,
                      color:
                          index == selectedIndex ? Colors.white : MyColors.grey,
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
