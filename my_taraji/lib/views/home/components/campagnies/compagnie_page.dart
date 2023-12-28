import 'package:flutter/material.dart';
import 'package:my_taraji/core/theme/my_color.dart';

import 'pagination_form.dart';

class CompaignPage extends StatelessWidget {
  final String compagneName;
  final String title;
  final String subtitle;
  final String imagePath;
  final String coins;

  const CompaignPage({
    super.key,
    required this.compagneName,
    required this.title,
    required this.subtitle,
    required this.imagePath,
    required this.coins,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actionsIconTheme: IconThemeData(color: MyColors.yellow),
        title: const Text('Détails de la campagne'),
      ),
      body: CompaignPageDetails(
        compagneName: compagneName,
        title: title,
        subtitle: subtitle,
        imagePath: imagePath,
        coins: coins,
      ),
      backgroundColor: MyColors.black,
    );
  }
}

class CompaignPageDetails extends StatelessWidget {
  final String compagneName;
  final String title;
  final String subtitle;
  final String imagePath;
  final String coins;

  const CompaignPageDetails({
    super.key,
    required this.compagneName,
    required this.title,
    required this.subtitle,
    required this.imagePath,
    required this.coins,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(imagePath),
              alignment: Alignment.topCenter,
              opacity: 0.8,
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            height: 500,
            padding: const EdgeInsets.all(16.0),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10.0),
                bottomRight: Radius.circular(10.0),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 14.0,
                  ),
                ),
                const SizedBox(height: 30),
                Container(
                  decoration: BoxDecoration(
                    color: MyColors.red,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  padding: const EdgeInsets.only(
                      left: 20, right: 20, top: 5, bottom: 5),
                  child: Text(
                    compagneName,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                Text(
                  'Coins gagnés : $coins',
                  style: const TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                    color: MyColors.yellow,
                  ),
                ),
                const SizedBox(height: 30),
                PaginationForm(title: title),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
