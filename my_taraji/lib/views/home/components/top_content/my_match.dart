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
        )
      ],
    );
  }
}
