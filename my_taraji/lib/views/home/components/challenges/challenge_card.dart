import 'package:flutter/material.dart';
import 'package:my_taraji/core/theme/my_color.dart';
import 'package:my_taraji/views/challenge/pages/leader_bord_screen.dart';

class ChallengeCard extends StatelessWidget {
  const ChallengeCard({
    super.key,
    required this.context,
    required this.imagePath,
    required this.title,
    required this.subtitle,
    required this.challengeName,
    required this.titleFontSize,
    required this.subtitleFontSize,
    required this.coins,
    required this.isLister,
  });
  final BuildContext context;
  final String imagePath;
  final String title;
  final String subtitle;
  final String challengeName;
  final double titleFontSize;
  final double subtitleFontSize;
  final String coins;
  final bool isLister;

  @override
  Widget build(BuildContext context) {
    return buildCarouselItem(imagePath, title, subtitle, challengeName,
        titleFontSize, subtitleFontSize, coins);
  }

  Widget buildCarouselItem(
    String imagePath,
    String title,
    String subtitle,
    String challengeName,
    double titleFontSize,
    double subtitleFontSize,
    String coins,
  ) {
    return InkWell(
      onTap: () => goToCompagneDetails(
          context, challengeName, title, subtitle, imagePath, coins),
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
                    challengeName,
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
                  "Coins : $coins",
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
        builder: (context) => const LeaderBord(),
      ),
    );
  }
}
