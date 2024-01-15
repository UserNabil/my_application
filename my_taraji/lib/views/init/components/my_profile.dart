import 'package:flutter/material.dart';
import 'package:my_taraji/core/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/theme/my_color.dart';
import 'my_taraji_logo.dart';

class MyProfile extends StatelessWidget {
  final TextPosition textPosition;
  final String greetingText;
  final double photoSize;
  final EdgeInsets photoPadding;
  final EdgeInsets infoPadding;
  final Color greetingTextColor;
  final Color nameTextColor;
  final Color coinsTextColor;

  const MyProfile({
    super.key,
    this.textPosition = TextPosition.left,
    this.greetingText = '',
    this.photoSize = 50.0,
    this.photoPadding = const EdgeInsets.all(5.0),
    this.infoPadding = const EdgeInsets.all(8.0),
    this.greetingTextColor = MyColors.grey,
    this.nameTextColor = MyColors.white,
    this.coinsTextColor = MyColors.white,
  });

  Future<UserData> getUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    UserData userData = UserData(
      id: prefs.getString('id')!,
      pseudo: prefs.getString('name')!,
      phone: prefs.getString('phone')!,
      myRewards: MyRewards(coins: int.parse(prefs.getString('coins')!)),
      myGamification: MyGamification(
        id: prefs.getString('id')!,
        expPoints: int.parse(prefs.getString('xp')!),
        expPointsHistory: [],
        createdAt: '',
        updatedAt: '',
      ),
    );

    return userData;
  }

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
      onTap: () {
        // ignore: avoid_print
        print("profile clicked photo");
      },
    );
  }

  Widget buildInfo(TextPosition textPosition, String name, String coins) {
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
          coins,
          style: TextStyle(
            fontSize: 10,
            color: coinsTextColor,
          ),
        ),
      ],
    );
  }

  Widget buildContent(UserData userData) {
    final String pseudo = userData.pseudo;
    final String coins = userData.myRewards.coins.toString();
    const String profileImagePath =
        'https://e-s-tunis.com/images/news/2023/03/03/1677831592_img.jpg';

    switch (textPosition) {
      case TextPosition.left:
        return Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            buildInfo(textPosition, pseudo, coins),
            const SizedBox(width: 15),
            buildPhoto(profileImagePath),
          ],
        );
      case TextPosition.right:
        return Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            buildPhoto(profileImagePath),
            const SizedBox(width: 15),
            buildInfo(textPosition, pseudo, coins),
          ],
        );
      case TextPosition.top:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            buildInfo(textPosition, pseudo, coins),
            const SizedBox(height: 15),
            buildPhoto(profileImagePath),
          ],
        );
      case TextPosition.bottom:
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
      alignment: Alignment.topLeft, // Align content to the left
      child: FutureBuilder(
        future: getUserData(),
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

          final userData = snapshot.data!;
          return buildContent(userData);
        },
      ),
    );
  }
}
