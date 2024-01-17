import 'package:flutter/material.dart';
import '../../../core/theme/my_color.dart';

enum TextPositionLogo {
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
  final TextPositionLogo textPosition;

  const MyTarajiLogo({
    super.key,
    required this.logoImagePath,
    required this.firstText,
    required this.secondText,
    required this.logoSize,
    required this.textSize,
    this.textPosition = TextPositionLogo.bottom,
  });

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
      case TextPositionLogo.left:
        return Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            buildTextWidget(),
            buildImage(),
          ],
        );
      case TextPositionLogo.right:
        return Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            buildImage(),
            buildTextWidget(),
          ],
        );
      case TextPositionLogo.top:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            buildTextWidget(),
            buildImage(),
          ],
        );
      case TextPositionLogo.bottom:
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
