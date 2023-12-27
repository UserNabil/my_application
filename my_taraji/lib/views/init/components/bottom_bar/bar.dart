import 'package:flutter/widgets.dart';
import '../../../../core/models/menu_item.dart';
import '../../../../core/theme/my_color.dart';
import 'background.dart';
import 'item.dart';
import 'slider.dart';

List items = [
  MenuItem(
      index: 0,
      x: -1.0,
      name: "Home",
      fileName: 'home',
      color: MyColors.yellow),
  MenuItem(
      index: 1,
      x: -0.5,
      name: "Selfcare",
      fileName: 'selfcare',
      color: MyColors.yellow),
  MenuItem(
      index: 2,
      x: 0.0,
      name: "Fanpay",
      fileName: 'fanpay',
      color: MyColors.yellow),
  MenuItem(
      index: 3,
      x: 0.5,
      name: "Fanzone",
      fileName: 'fanzone',
      color: MyColors.yellow),
  MenuItem(
      index: 4, x: 1.0, name: "Shop", fileName: 'shop', color: MyColors.yellow),
];

class MyBottomBar extends StatelessWidget {
  const MyBottomBar({super.key, required this.active, required this.onTap});
  final MenuItem active;
  final Function(MenuItem) onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: MyColors.transparent),
      height: 120,
      width: 360,
      child: Stack(
        children: [
          Padding(
              padding: const EdgeInsets.only(top: 30),
              child: BackgroundBar(currentIndex: active.index)),
          Padding(
            padding: const EdgeInsets.only(top: 5),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              alignment: Alignment(active.x, -1),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 0),
                height: 50,
                width: active.index != 0 && active.index != 4
                    ? 330 * 0.38
                    : 330 * 0.41,
                color: MyColors.transparent,
                child: Slider(currentIndex: active.index),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 45),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: items
                  .map((item) => Item(item: item, onTap: onTap, active: active))
                  .toList(),
            ),
          )
        ],
      ),
    );
  }
}
