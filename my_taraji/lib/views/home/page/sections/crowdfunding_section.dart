import 'package:carousel_slider/carousel_slider.dart';
import 'package:my_taraji/views/challenge/import.dart';

import 'package:my_taraji/views/home/models/crowdfunding_output.dart';
import 'package:my_taraji/views/home/components/crowdfunding/crowdfunding_card.dart';
import 'package:my_taraji/views/home/services/home_services.dart';

Widget crowdfundingSection(BuildContext context) {
  return FutureBuilder(
    future: getCrowdfundingList(),
    builder: (context, AsyncSnapshot<CrowdfundingOutput> snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting ||
          !snapshot.hasData) {
        return const SizedBox(
          height: 100,
          child: Center(
            child: CircularProgressIndicator(
              color: MyColors.yellow,
            ),
          ),
        );
      } else {
        return CrowdFundingWidget(crowdfundingOutput: snapshot.data!);
      }
    },
  );
}

class CrowdFundingWidget extends StatefulWidget {
  final CrowdfundingOutput crowdfundingOutput;
  const CrowdFundingWidget({super.key, required this.crowdfundingOutput});

  @override
  State<CrowdFundingWidget> createState() => _CrowdFundingWidgetState();
}

class _CrowdFundingWidgetState extends State<CrowdFundingWidget> {
  int _currentPage = 0;
  CarouselController carouselController = CarouselController();
  List _pages = [];

  @override
  void initState() {
    super.initState();
    _pages = widget.crowdfundingOutput.data!;
  }

  @override
  Widget build(BuildContext context) {
    return buildContainer(context);
  }

  Widget buildContainer(BuildContext context) {
    print('leeeeeeenght ${widget.crowdfundingOutput.data?.length}');
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
                'Crowdfunding ',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 20.0,
                  color: MyColors.yellow,
                ),
              ),
              InkWell(
                onTap: () {},
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
            items: widget.crowdfundingOutput.data!.map((i) {
              return Builder(
                builder: (BuildContext context) {
                  return CrowdfundingCard(
                    crowdfunding: i,
                  );
                },
              );
            }).toList(),
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
