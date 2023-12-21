import 'package:flutter/material.dart';
import 'package:my_taraji/core/theme/my_color.dart';

import 'compagnie_modal.dart';
import 'compagnie_page.dart';

class CompaignCard extends StatelessWidget {
  const CompaignCard({
    super.key,
    required this.context,
    required this.imagePath,
    required this.title,
    required this.subtitle,
    required this.compagneName,
    required this.titleFontSize,
    required this.subtitleFontSize,
    required this.coins,
    required this.isLister,
  });
  final BuildContext context;
  final String imagePath;
  final String title;
  final String subtitle;
  final String compagneName;
  final double titleFontSize;
  final double subtitleFontSize;
  final String coins;
  final bool isLister;

  @override
  Widget build(BuildContext context) {
    return buildCarouselItem(imagePath, title, subtitle, compagneName,
        titleFontSize, subtitleFontSize, coins);
  }

  Widget buildCarouselItem(
    String imagePath,
    String title,
    String subtitle,
    String comagneName,
    double titleFontSize,
    double subtitleFontSize,
    String coins,
  ) {
    return InkWell(
      onTap: () => goToCompagneDetails(
          context, comagneName, title, subtitle, imagePath, coins),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 5.0),
        // Remove const BoxConstraints.expand()
        constraints: isLister ? null : const BoxConstraints.expand(),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          image: DecorationImage(
            image: AssetImage(imagePath),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          width: 100,
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            gradient: LinearGradient(
              begin: Alignment.centerRight,
              end: Alignment.centerLeft,
              colors: [
                MyColors.red.withOpacity(0.3),
                MyColors.red,
              ],
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                padding: const EdgeInsets.only(
                    left: 20, right: 20, top: 5, bottom: 5),
                decoration: const BoxDecoration(
                  color: MyColors.white,
                  borderRadius: BorderRadius.all(Radius.circular(50.0)),
                ),
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    comagneName,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 150,
                child: Text(
                  title,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 3,
                  style: TextStyle(
                    fontSize: titleFontSize,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(
                width: 150,
                child: Text(
                  subtitle,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 3,
                  style: TextStyle(
                    fontSize: subtitleFontSize,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void goToCompagneDetails(BuildContext context, String compagneName,
      String title, String subtitle, String imagePath, String coins) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CompaignPage(
          compagneName: compagneName,
          title: title,
          subtitle: subtitle,
          imagePath: imagePath,
          coins: coins,
        ),
      ),
    );
  }

  void showCompagneModal(BuildContext context, String compagneName,
      String title, String subtitle, String imagePath, String coins) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return CompaignModal(
            compagneName: compagneName,
            title: title,
            subtitle: subtitle,
            imagePath: imagePath,
            coins: coins);
      },
    );
  }
}
