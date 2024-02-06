import 'package:flutter/cupertino.dart';
import 'package:my_taraji/core/theme/style.dart';
import 'package:my_taraji/views/fanpay/imports.dart';
import 'package:my_taraji/views/home/models/crowdfunding.dart';
import 'package:simple_animation_progress_bar/simple_animation_progress_bar.dart';

class CrowdfundingPage extends StatefulWidget {
  final Crowdfunding? crowdfunding;
  const CrowdfundingPage({super.key, this.crowdfunding});
  static String routeName = "/crowdfunding";

  @override
  State<CrowdfundingPage> createState() => _CrowdfundingPageState();
}

class _CrowdfundingPageState extends State<CrowdfundingPage> {
  List<String> images = [
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQTIZccfNPnqalhrWev-Xo7uBhkor57_rKbkw&usqp=CAU",
    "https://wallpaperaccess.com/full/2637581.jpg"
  ];
  int activePage = 0;

  List<Widget> indicators(imagesLength, currentIndex) {
    return List<Widget>.generate(imagesLength, (index) {
      return Container(
        margin: const EdgeInsets.all(3),
        width: 10,
        height: 10,
        decoration: BoxDecoration(
            color: currentIndex == index ? Colors.white : Colors.grey,
            shape: BoxShape.circle),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final contributionRatio = 0.6;
    // widget.crowdfunding!.totalAmountContributed! /
    //     widget.crowdfunding!.targetAmount!;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 255,
              child: PageView.builder(
                  itemCount: 2,
                  pageSnapping: true,
                  onPageChanged: (page) {
                    setState(() {
                      activePage = page;
                    });
                  },
                  itemBuilder: (context, pagePosition) {
                    return FittedBox(
                      fit: BoxFit.cover,
                      child: Image.network(images[pagePosition]),
                    );
                  }),
            ),
            Positioned(
              right: MediaQuery.of(context).size.width / 2.2,
              top: 200,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: indicators(images.length, activePage),
              ),
            ),
            Positioned(
              top: -20,
              left: 0,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height - 220,
                margin: const EdgeInsets.only(top: 250),
                padding: const EdgeInsets.all(10),
                decoration: const BoxDecoration(
                  color: Colors.yellow,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 25, right: 25, top: 10),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.crowdfunding!.title,
                          style: stylePrimary.copyWith(fontSize: 23),
                        ),
                        const SizedBox(height: 5),
                        Text.rich(
                          TextSpan(
                            text:
                                '${widget.crowdfunding!.totalAmountContributed} TND ',
                            style: stylePrimary.copyWith(
                              fontSize: 25,
                              color: Colors.red,
                              fontWeight: FontWeight.w500,
                            ),
                            children: <InlineSpan>[
                              TextSpan(
                                text:
                                    '/ ${widget.crowdfunding!.targetAmount} TND',
                                style: stylePrimary.copyWith(
                                  fontSize: 20,
                                  color: Colors.red,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        Stack(
                          children: [
                            SimpleAnimationProgressBar(
                              height: 44,
                              width: MediaQuery.of(context).size.width - 20,
                              backgroundColor: Colors.white,
                              foregrondColor: Colors.red,
                              ratio: contributionRatio,
                              direction: Axis.horizontal,
                              curve: Curves.fastLinearToSlowEaseIn,
                              duration: const Duration(seconds: 3),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: Colors.red,
                                width: 2,
                              ),
                            ),
                            Positioned(
                              left: MediaQuery.of(context).size.width / 2.75,
                              top: 8.5,
                              child: Text(
                                "${contributionRatio * 100}%",
                                style: stylePrimary.copyWith(
                                  fontSize: 20,
                                  color: contributionRatio > 0.59
                                      ? Colors.white
                                      : Colors.black,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            const Icon(
                              TablerIcons.users,
                              size: 30,
                              color: Colors.red,
                            ),
                            const SizedBox(width: 10),
                            Text(
                              '${widget.crowdfunding!.audienceSize} donateurs',
                              style: stylePrimary.copyWith(
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                                color: Colors.red,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Text(
                          widget.crowdfunding!.description ?? '',
                          style: stylePrimary.copyWith(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const SizedBox(height: 35),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: 63,
                              width: 220,
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    CupertinoIcons.heart_solid,
                                    color: Colors.yellow,
                                    size: 26,
                                  ),
                                  const SizedBox(width: 10),
                                  Text(
                                    'Participer',
                                    style: stylePrimary.copyWith(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.yellow,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              height: 63,
                              width: 90,
                              decoration: BoxDecoration(
                                color: Colors.yellow,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: Colors.red,
                                  width: 2,
                                ),
                              ),
                              child: const Icon(
                                TablerIcons.send,
                                color: Colors.red,
                                size: 32,
                              ),
                            )
                          ],
                        ),
                        const SizedBox(height: 30),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
