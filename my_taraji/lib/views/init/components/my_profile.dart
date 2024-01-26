import 'package:flutter/material.dart';
import 'package:my_taraji/views/init/models/user.dart';
import 'package:my_taraji/views/home/provider/home_provider.dart';
import 'package:provider/provider.dart';
import '../../../core/theme/my_color.dart';
import 'my_taraji_logo.dart';

class MyProfile extends StatelessWidget {
  final TextPositionLogo textPosition;
  final String greetingText;
  final double photoSize;
  final EdgeInsets photoPadding;
  final EdgeInsets infoPadding;
  final Color greetingTextColor;
  final Color nameTextColor;
  final Color coinsTextColor;

  const MyProfile({
    super.key,
    this.textPosition = TextPositionLogo.left,
    this.greetingText = '',
    this.photoSize = 50.0,
    this.photoPadding = const EdgeInsets.all(5.0),
    this.infoPadding = const EdgeInsets.all(8.0),
    this.greetingTextColor = MyColors.grey,
    this.nameTextColor = MyColors.white,
    this.coinsTextColor = MyColors.white,
  });

  Widget buildPhoto(String profileImagePath) {
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
      onTap: () {},
    );
  }

  Widget buildInfo(TextPositionLogo textPosition, String name, String coins) {
    return Column(
      crossAxisAlignment: textPosition == TextPositionLogo.left
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
          coins,
          style: TextStyle(
            fontSize: 10,
            color: coinsTextColor,
          ),
        ),
      ],
    );
  }

  Widget buildContent(User? userData) {
    final String pseudo = userData?.pseudo ?? '';
    final String coins = userData?.myRewards?.coins.toString() ?? '';

    const String profileImagePath =
        'https://e-s-tunis.com/images/news/2023/03/03/1677831592_img.jpg';

    switch (textPosition) {
      case TextPositionLogo.left:
        return Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            buildInfo(textPosition, pseudo, coins),
            const SizedBox(width: 15),
            buildPhoto(profileImagePath),
          ],
        );
      case TextPositionLogo.right:
        return Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            buildPhoto(profileImagePath),
            const SizedBox(width: 15),
            buildInfo(textPosition, pseudo, coins),
          ],
        );
      case TextPositionLogo.top:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            buildInfo(textPosition, pseudo, coins),
            const SizedBox(height: 15),
            buildPhoto(profileImagePath),
          ],
        );
      case TextPositionLogo.bottom:
      default:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            buildPhoto(profileImagePath),
            const SizedBox(height: 15),
            buildInfo(textPosition, pseudo, coins),
          ],
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      child: FutureBuilder(
        future: context.read<HomeProvider>().getUserData(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const SizedBox(
              height: 100,
              child: Center(
                child: CircularProgressIndicator(
                  color: MyColors.yellow,
                ),
              ),
            );
          }

          if (snapshot.hasError) {
            return const Text('Error', style: TextStyle(color: MyColors.red));
          }

          final userData = snapshot.data;
          return buildContent(userData);
        },
      ),
    );
  }
}
