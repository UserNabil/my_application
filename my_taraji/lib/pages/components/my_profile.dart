import 'package:flutter/material.dart';

import 'my_color.dart';

class ProfileSection extends StatelessWidget {
  final String name;
  final String phoneNumber;
  final String profileImagePath;

  const ProfileSection({
    Key? key,
    required this.name,
    required this.phoneNumber,
    required this.profileImagePath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        buildInfo('Bonjour', name, phoneNumber),
        const Padding(padding: EdgeInsets.all(5.0)),
        buildPhoto(profileImagePath),
      ],
    );
  }
}

Widget buildPhoto(String profileImagePath) {
  return GestureDetector(
      child: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: MyColors.black,
            image: DecorationImage(
                image: NetworkImage(profileImagePath), fit: BoxFit.cover),
          )),
      onTap: () {
        // ignore: avoid_print
        print("profile clicked photo");
      });
}

Widget buildInfo(String text, String name, String phoneNumber) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.end,
    children: [
      Text(
        text,
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: MyColors.grey,
        ),
      ),
      Text(
        name,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: MyColors.white,
        ),
      ),
      Text(
        phoneNumber,
        style: const TextStyle(
          fontSize: 10,
          color: MyColors.white,
        ),
      ),
    ],
  );
}
