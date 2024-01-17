import '../../import.dart';

class AllContent extends StatefulWidget {
  const AllContent({super.key, required this.allContent});
  final AllDataContent allContent;

  @override
  AllContentState createState() => AllContentState();
}

class AllContentState extends State<AllContent> {
  int _currentPage = 0;
  CarouselController carouselController = CarouselController();
  List _pages = [];

  @override
  void initState() {
    super.initState();
    _pages = [
      ...widget.allContent.campagnes,
      ...widget.allContent.challenges,
    ];
  }

  @override
  Widget build(BuildContext context) {
    return buildContainer(context);
  }

  Widget buildContainer(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          color: MyColors.transparent,
          padding: const EdgeInsets.all(15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Campagnes',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 20.0,
                  color: MyColors.yellow,
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AllContentPage(
                        compagnes: widget.allContent.campagnes,
                        challenges: widget.allContent.challenges,
                      ),
                    ),
                  );
                },
                child: const Text(
                  'VOIR TOUS',
                  style: TextStyle(
                    backgroundColor: MyColors.transparent,
                    fontSize: 12.0,
                    fontWeight: FontWeight.w500,
                    color: MyColors.grey,
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.zero,
          child: CarouselSlider(
            carouselController: carouselController,
            options: CarouselOptions(
              initialPage: _currentPage,
              height: 195,
              enlargeCenterPage: true,
              autoPlay: true,
              autoPlayInterval: const Duration(milliseconds: 5000),
              enlargeFactor: 0.2,
              onPageChanged: (index, reason) {
                setState(() {
                  _currentPage = index;
                });
              },
            ),
            items: [
              ...widget.allContent.campagnes.map(
                (campaign) => CompaignCard(
                  context: context,
                  campaign: campaign,
                  titleFontSize: 15.0,
                  subtitleFontSize: 12.0,
                  isLister: false,
                ),
              ),
              ...widget.allContent.challenges.map(
                (challenge) => ChallengeCard(
                    context: context,
                    challengeName: challenge.title,
                    title: challenge.title,
                    description: challenge.description,
                    imageUrl: "images/pngs/challenge1.jpg",
                    coins: challenge.title,
                    titleFontSize: 13.0,
                    subtitleFontSize: 12.0,
                    isLister: false,
                    id: challenge.id),
              ),
            ],
          ),
        ),
        const SizedBox(height: 15),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: _pages
              .map((item) => AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    width: _currentPage == _pages.indexOf(item) ? 35 : 5,
                    height: 5,
                    margin: const EdgeInsets.all(3.0),
                    decoration: BoxDecoration(
                        color: MyColors.redLight,
                        borderRadius: BorderRadius.circular(10.0)),
                  ))
              .toList(),
        ),
      ],
    );
  }
}
