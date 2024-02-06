import '../../import.dart';

class CompaignPage extends StatelessWidget {
  final Campaign campaign;

  const CompaignPage({
    super.key,
    required this.campaign,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.black.withOpacity(0.3),
        iconTheme: const IconThemeData(color: MyColors.white),
        title: const Text(
          'Détails de la campagne',
          style: TextStyle(
            color: MyColors.white,
            fontSize: 20.0,
            fontWeight: FontWeight.w500,
          ),
        ),
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

  Future<Campaign> display() async {
    campaignFromApi = await campaignService
        .getCampaignById(widget.campaign.id)
        .then((value) => value.data!);
    return campaignFromApi;
  }

  @override
  Widget build(BuildContext context) {
    Campaign campaign = widget.campaign;

    return SizedBox(
      // height: MediaQuery.of(context).size.height * 0.2,
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              height: 300.0,
              child: Image.asset(
                campaign.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            buildContent(campaign),
          ],
        ),
      ),
    );
  }

  Widget buildContent(Campaign campaign) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Container(
        //   height: 300,
        //   width: double.infinity,
        //   decoration: BoxDecoration(
        //     image: DecorationImage(
        //       image: AssetImage(campaign.imageUrl),
        //       alignment: Alignment.topCenter,
        //       opacity: 1,
        //       fit: BoxFit.cover,
        //     ),
        //   ),
        // ),
        Padding(
          padding: const EdgeInsets.all(10),
          child: Text(
            campaign.title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18.0,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10),
          child: Text(
            campaignFromApi.description,
            style: const TextStyle(
              fontSize: 14.0,
            ),
          ),
        ),
        campaign.tag.isNotEmpty && campaign.tag != "null"
            ? Padding(
                padding: const EdgeInsets.all(10),
                child: Container(
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
              )
            : Container(),
        Padding(
          padding: const EdgeInsets.all(20),
          child: Text(
            'Coins gagnés : ${campaign.rewardCoins}',
            style: const TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.bold,
              color: MyColors.yellow,
            ),
          ),
        ),
        PaginationForm(campaign: campaign),
      ],
    );
  }
}
