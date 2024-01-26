import 'package:flutter/material.dart';
import 'package:my_taraji/views/init/models/user.dart';
import 'package:my_taraji/core/theme/my_color.dart';
import 'package:my_taraji/views/home/provider/home_provider.dart';
import 'package:provider/provider.dart';

class UserInfoWidget extends StatelessWidget {
  final String imagePath;
  const UserInfoWidget({
    super.key,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: context.watch<HomeProvider>().getUserData(),
      builder: (context, AsyncSnapshot<User?> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }

        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }
        final userData = snapshot.data;
        return ListTile(
          leading: CircleAvatar(
            radius: 30,
            backgroundImage: NetworkImage(imagePath),
          ),
          title: Text(
            userData?.pseudo ?? '',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: MyColors.black,
            ),
          ),
          subtitle: Text(
            userData?.myRewards?.coins.toString() ?? '',
            style: const TextStyle(
              color: MyColors.grey,
              fontSize: 10,
            ),
          ),
        );
      },
    );
  }
}
