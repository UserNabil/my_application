import '../../../../import.dart';

class NewsCarouselBuilder extends StatelessWidget {
  const NewsCarouselBuilder({super.key, required this.newsDataList});

  final List<News> newsDataList;

  @override
  CarouselSlider build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        aspectRatio: double.infinity,
        height: 100.0,
        enlargeCenterPage: false,
        autoPlay: true,
        autoPlayInterval: const Duration(milliseconds: 3000),
        viewportFraction: 0.95,
      ),
      items: [
        for (final newsData in newsDataList) NewsCarouselItem(news: newsData),
      ],
    );
  }
}
