import 'package:flutter/material.dart';
import 'package:my_taraji/core/theme/my_color.dart';

class UserInfoWidget extends StatelessWidget {
  final String title;
  final String subtitle;
  final String imagePath;
  const UserInfoWidget({
    super.key,
    required this.title,
    required this.subtitle,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    // Widget buildPhoto(String profileImagePath) {
    //   const photoSize = 90.0;
    //   const photoPadding = EdgeInsets.all(5.0);
    //   return GestureDetector(
    //     child: Container(
    //       width: photoSize,
    //       height: photoSize,
    //       padding: photoPadding,
    //       decoration: BoxDecoration(
    //         shape: BoxShape.circle,
    //         color: MyColors.black,
    //         image: DecorationImage(
    //           image: NetworkImage(profileImagePath),
    //           fit: BoxFit.cover,
    //         ),
    //       ),
    //     ),
    //     onTap: () {
    //       log("profile clicked photo");
    //     },
    //   );
    // }

    return ListTile(
      leading: CircleAvatar(
        radius: 30,
        backgroundImage: NetworkImage(imagePath),
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: MyColors.black,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: const TextStyle(
          color: MyColors.grey,
          fontSize: 10,
        ),
      ),
    );
  }
}
