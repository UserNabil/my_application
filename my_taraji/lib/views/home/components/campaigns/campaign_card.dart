import 'package:flutter/material.dart';
import 'package:my_taraji/core/models/compaign_model.dart';
import 'package:my_taraji/core/theme/my_color.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'campaign_page.dart';

class CompaignCard extends StatefulWidget {
  const CompaignCard({
    super.key,
    required this.context,
    required this.campaign,
    required this.titleFontSize,
    required this.subtitleFontSize,
    required this.isLister,
  });
  final BuildContext context;
  final Campaign campaign;
  final double titleFontSize;
  final double subtitleFontSize;
  final bool isLister;

  @override
  CompaignCardState createState() => CompaignCardState();
}

class CompaignCardState extends State<CompaignCard> {
  bool? isCardAvailable = false;

  @override
  Widget build(BuildContext context) {
    return buildCarouselItem(
      widget.campaign,
      widget.titleFontSize,
      widget.subtitleFontSize,
    );
  }

  @override
  void initState() {
    super.initState();
    onInitData();
  }

  void onInitData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isCardAvailable = prefs.getBool(
        widget.campaign.id,
      );
    });
  }

  Widget buildCarouselItem(
    Campaign campaign,
    double titleFontSize,
    double subtitleFontSize,
  ) {
    return InkWell(
      onTap: () => isCardAvailable == true
          ? goToCompagneDetails(context, campaign)
          : null,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 5.0),
        constraints: widget.isLister ? null : const BoxConstraints.expand(),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          image: DecorationImage(
            image: AssetImage(campaign.imageUrl),
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
            child: Stack(
              children: [
                Column(
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
                          campaign.tag,
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
                        campaign.title,
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
                        campaign.description,
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
                if (isCardAvailable == false)
                  Positioned(
                    top: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.all(8.0),
                      decoration: const BoxDecoration(
                        color: MyColors.yellow,
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                      child: const Text(
                        'Réalisée',
                        style: TextStyle(
                          fontSize: 12.0,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
              ],
            )),
      ),
    );
  }

  void goToCompagneDetails(BuildContext context, Campaign campaign) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CompaignPage(campaign: campaign),
      ),
    );
  }
}
