import 'package:flutter/material.dart';

import 'my_color.dart';

class MyNavBar extends StatelessWidget {
  final List<NavBarItem> items;
  final ValueChanged<int> onItemSelected;

  const MyNavBar({
    Key? key,
    required this.items,
    required this.onItemSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(items.length, (index) {
          return GestureDetector(
            onTap: () {
              onItemSelected(index);
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: index == 0 ? MyColors.red : MyColors.transparent,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(items[index].icon, size: 20, color: MyColors.grey),
                  const Padding(padding: EdgeInsets.all(5.0)),
                  Text(
                    items[index].label,
                    style: const TextStyle(fontSize: 12, color: MyColors.grey),
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
