import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';

class TopNavigation extends StatelessWidget {
  const TopNavigation(
      {super.key,
      required this.title,
      required this.onPressed,
      required this.isParent});
  final String title;
  final Function onPressed;
  final bool isParent;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: IconButton(
        color: Colors.white,
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          if (isParent) {
            Navigator.pushNamed(context, '/');
          } else {
            onPressed();
          }
        },
      ),
      title: Center(
        child: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      actions: [
        IconButton(
          color: Colors.white,
          icon: const Icon(TablerIcons.dots_vertical),
          onPressed: () {},
        ),
      ],
    );
  }
}
