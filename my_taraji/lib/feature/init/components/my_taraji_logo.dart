import 'package:flutter/material.dart';
import '../../../core/theme/my_color.dart';

enum TextPosition {
  bottom,
  left,
  right,
  top,
}

class MyTarajiLogo extends StatelessWidget {
  final String logoImagePath;
  final String firstText;
  final String secondText;
  final double logoSize;
  final double textSize;
  final TextPosition textPosition;

  const MyTarajiLogo({
    Key? key,
    required this.logoImagePath,
    required this.firstText,
    required this.secondText,
    required this.logoSize,
    required this.textSize,
    this.textPosition = TextPosition.bottom,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        buildContent(),
      ],
    );
  }

  Widget buildImage() {
    return Image.asset(
      logoImagePath,
      width: logoSize,
      height: logoSize,
    );
  }

  Widget buildTextWidget() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$firstText ',
            style: TextStyle(
              color: MyColors.yellow,
              fontSize: textSize,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            secondText,
            style: TextStyle(
              color: MyColors.redLight,
              fontSize: textSize,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildContent() {
    switch (textPosition) {
      case TextPosition.left:
        return Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            buildTextWidget(),
            buildImage(),
          ],
        );
      case TextPosition.right:
        return Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            buildImage(),
            buildTextWidget(),
          ],
        );
      case TextPosition.top:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            buildTextWidget(),
            buildImage(),
          ],
        );
      case TextPosition.bottom:
      default:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            buildImage(),
            buildTextWidget(),
          ],
        );
    }
  }
}
