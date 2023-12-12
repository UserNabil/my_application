import 'package:flutter/material.dart';
import 'my_color.dart';
import 'my_taraji_logo.dart';

class MyProfile extends StatelessWidget {
  final TextPosition textPosition;
  final String name;
  final String phoneNumber;
  final String profileImagePath;
  final String greetingText;
  final double photoSize;
  final EdgeInsets photoPadding;
  final EdgeInsets infoPadding;
  final Color greetingTextColor;
  final Color nameTextColor;
  final Color phoneNumberTextColor;

  const MyProfile({
    Key? key,
    this.textPosition = TextPosition.left,
    required this.name,
    required this.phoneNumber,
    required this.profileImagePath,
    this.greetingText = '',
    this.photoSize = 50.0,
    this.photoPadding = const EdgeInsets.all(5.0),
    this.infoPadding = const EdgeInsets.all(8.0),
    this.greetingTextColor = MyColors.grey,
    this.nameTextColor = MyColors.white,
    this.phoneNumberTextColor = MyColors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [buildContent()],
    );
  }

  Widget buildPhoto() {
    return GestureDetector(
      child: Container(
        width: photoSize,
        height: photoSize,
        padding: photoPadding,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: MyColors.black,
          image: DecorationImage(
            image: NetworkImage(profileImagePath),
            fit: BoxFit.cover,
          ),
        ),
      ),
      onTap: () {
        // ignore: avoid_print
        print("profile clicked photo");
      },
    );
  }

  Widget buildInfo(TextPosition textPosition) {
    return Column(
      crossAxisAlignment: textPosition == TextPosition.left
          ? CrossAxisAlignment.end
          : CrossAxisAlignment.start,
      children: [
        greetingText.isNotEmpty
            ? Text(
                greetingText,
                style: TextStyle(
                  fontSize: 10,
                  color: greetingTextColor,
                ),
              )
            : Container(),
        Text(
          name,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: nameTextColor,
          ),
        ),
        Text(
          phoneNumber,
          style: TextStyle(
            fontSize: 10,
            color: phoneNumberTextColor,
          ),
        ),
      ],
    );
  }

  Widget buildContent() {
    switch (textPosition) {
      case TextPosition.left:
        return Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            buildInfo(textPosition),
            const SizedBox(width: 15),
            buildPhoto(),
          ],
        );
      case TextPosition.right:
        return Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            buildPhoto(),
            const SizedBox(width: 15),
            buildInfo(textPosition),
          ],
        );
      case TextPosition.top:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            buildInfo(textPosition),
            const SizedBox(height: 15),
            buildPhoto(),
          ],
        );
      case TextPosition.bottom:
      default:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            buildPhoto(),
            const SizedBox(height: 15),
            buildInfo(textPosition),
          ],
        );
    }
  }
}
