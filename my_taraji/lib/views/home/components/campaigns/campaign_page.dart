import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:my_taraji/core/models/compaign_model.dart';
import 'package:my_taraji/core/theme/my_color.dart';
import 'package:my_taraji/services/campaign_service.dart';
import 'pagination_form.dart';

class CompaignPage extends StatelessWidget {
  final Campaign campaign;

  const CompaignPage({
    super.key,
    required this.campaign,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actionsIconTheme: const IconThemeData(color: MyColors.yellow),
        title: const Text('Détails de la campagne'),
      ),
      body: CompaignPageDetails(campaign: campaign),
      backgroundColor: MyColors.white,
    );
  }
}

class CompaignPageDetails extends StatefulWidget {
  final Campaign campaign;

  @override
  CompaignPageDetailsState createState() => CompaignPageDetailsState();

  const CompaignPageDetails({
    super.key,
    required this.campaign,
  });
}

class CompaignPageDetailsState extends State<CompaignPageDetails> {
  late Campaign campaignFromApi = widget.campaign;
  var campaignService = CampaignService();

  @override
  void initState() {
    super.initState();
  }

  Future<Campaign> display(BuildContext context, Campaign campaign) async {
    campaignFromApi = await campaignService.getCampaignById(widget.campaign.id);
    return campaignFromApi;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: display(context, widget.campaign),
      builder: (context, AsyncSnapshot<Campaign> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 100,
                child: Center(
                  child: CircularProgressIndicator(
                    color: MyColors.yellow,
                  ),
                ),
              )
            ],
          );
        }

        if (snapshot.hasError) {
          return SizedBox(
            height: 100,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: MyColors.transparent,
                      backgroundColor: MyColors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                    onPressed: () {
                      setState(() {});
                    },
                    child: const Icon(
                      TablerIcons.refresh,
                      color: MyColors.red,
                    ),
                  ),
                ],
              ),
            ),
          );
        }

        Campaign campaign = snapshot.data!;
        return buildContent(campaign);
      },
    );
  }

  Widget buildContent(Campaign campaign) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(campaign.imageUrl),
              alignment: Alignment.topCenter,
              opacity: 1,
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
                  campaign.title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  campaignFromApi.description,
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
                    campaign.tag,
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
                  'Coins gagnés : ${campaign.rewardCoins}',
                  style: const TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                    color: MyColors.yellow,
                  ),
                ),
                const SizedBox(height: 30),
                PaginationForm(campaign: campaign),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
