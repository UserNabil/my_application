import 'package:flutter/material.dart';
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
    Key? key,
    this.textPosition = TextPosition.left,
    this.greetingText = '',
    this.photoSize = 50.0,
    this.photoPadding = const EdgeInsets.all(5.0),
    this.infoPadding = const EdgeInsets.all(8.0),
    this.greetingTextColor = MyColors.grey,
    this.nameTextColor = MyColors.white,
    this.coinsTextColor = MyColors.white,
  }) : super(key: key);

  Future<Map<String, String>> _getUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String name = prefs.getString('name') ?? 'John Doe';
    final String coins = prefs.getString('coins') ?? '0';
    final String profileImagePath = prefs.getString('profileImagePath') ??
        'https://e-s-tunis.com/images/news/2023/03/03/1677831592_img.jpg';

    return {
      'name': name,
      'coins': coins,
      'profileImagePath': profileImagePath,
    };
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _getUserData(),
      builder: (context, AsyncSnapshot<Map<String, String>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // You can return a loading indicator here if needed.
          return const CircularProgressIndicator();
        }

        if (snapshot.hasError) {
          // Handle error
          return Text('Error: ${snapshot.error}');
        }

        final userData = snapshot.data!;
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [buildContent(userData)],
        );
      },
    );
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

  Widget buildContent(Map<String, String> userData) {
    final String name = userData['name']!;
    final String coins = userData['coins']!;
    final String profileImagePath = userData['profileImagePath']!;

    switch (textPosition) {
      case TextPosition.left:
        return Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            buildInfo(textPosition, name, coins),
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
            buildInfo(textPosition, name, coins),
          ],
        );
      case TextPosition.top:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            buildInfo(textPosition, name, coins),
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
            buildInfo(textPosition, name, coins),
          ],
        );
    }
  }
}
