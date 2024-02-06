import 'dart:ui';

import '../../import.dart';

class MyMatch extends StatelessWidget {
  const MyMatch({super.key, required this.carouselController});
  final CarouselController carouselController;
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TeamCarousel(carouselController: carouselController),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: GestureDetector(
                onTap: () {
                  carouselController.previousPage();
                },
                child: const Icon(Icons.chevron_left),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 15),
              child: GestureDetector(
                onTap: () {
                  carouselController.nextPage();
                },
                child: const Icon(Icons.chevron_right),
              ),
            ),
          ],
        ),
        ClipRect(
          child: BackdropFilter(
            blendMode: BlendMode.screen,
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.7),
              ),
              child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.83, height: 185),
            ),
          ),
        ),
        const Text(
          "Coming soon...",
          style: TextStyle(
            color: MyColors.yellow,
            fontSize: 30,
            fontWeight: FontWeight.w500,
            shadows: [
              Shadow(
                blurRadius: 20.0,
                color: MyColors.black,
                offset: Offset(0, 0),
              ),
            ],
          ),
        )
      ],
    );
  }
}
