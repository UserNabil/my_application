import '../../import.dart';

class CompaignCard extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return buildCarouselItem(
      campaign,
      titleFontSize,
      subtitleFontSize,
    );
  }

  Widget buildCarouselItem(
    Campaign campaign,
    double titleFontSize,
    double subtitleFontSize,
  ) {
    return InkWell(
      onTap: () => goToCompagneDetails(context, campaign),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 5.0),
        constraints: isLister ? null : const BoxConstraints.expand(),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          image: DecorationImage(
            image: NetworkImage(campaign.imageUrl),
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
                  campaign.tag != "null"
                      ? Container(
                          padding: const EdgeInsets.only(
                              left: 20, right: 20, top: 5, bottom: 5),
                          decoration: const BoxDecoration(
                            color: MyColors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(50.0)),
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
                        )
                      : Container(),
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
            ],
          ),
        ),
      ),
    );
  }

  void goToCompagneDetails(BuildContext context, Campaign campaign) {
    Navigator.push(
      context,
      MaterialPageRoute(
        barrierDismissible: true,
        builder: (context) => CompaignPage(campaign: campaign),
      ),
    );
  }
}
