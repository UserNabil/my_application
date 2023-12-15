import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_taraji/core/models/menu_item.dart';
import '../../../../core/theme/my_color.dart';

class Item extends StatelessWidget {
  const Item({
    Key? key,
    required this.item,
    required this.onTap,
    required this.active,
  }) : super(key: key);

  final MenuItem item;
  final Function(MenuItem) onTap;
  final MenuItem active;

  @override
  Widget build(BuildContext context) {
    final isItemActive = item.index == active.index;

    return GestureDetector(
      onTap: () => onTap(item),
      child: AspectRatio(
        aspectRatio: .3,
        child: Padding(
          padding: EdgeInsets.only(top: isItemActive ? 20 : 50, bottom: 40),
          child: AnimatedCrossFade(
            crossFadeState: isItemActive
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
            duration: const Duration(milliseconds: 0),
            firstChild: _buildChild(MyColors.white, isItemActive),
            secondChild: _buildChild(MyColors.yellow, isItemActive),
          ),
        ),
      ),
    );
  }

  Widget _buildChild(Color color, bool isItemActive) {
    return FutureBuilder(
      future: Future.delayed(
          Duration(milliseconds: isItemActive ? 300 : 0), () => true),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container();
        } else {
          return Container(
            color: MyColors.transparent,
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    'images/icons/${item.fileName}.svg',
                    color: color,
                    width: 22,
                    height: 22,
                  ),
                  if (item.index == active.index) ...[
                    const SizedBox(height: 13),
                    Text(
                      item.name,
                      maxLines: 1,
                      style: const TextStyle(
                        fontSize: 8,
                        color: MyColors.yellow,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          );
        }
      },
    );
  }
}
