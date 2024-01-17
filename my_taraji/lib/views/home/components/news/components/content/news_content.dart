import '../../../../import.dart';

class NewsContent extends StatelessWidget {
  const NewsContent({super.key, required this.isExpanded, required this.news});

  final bool isExpanded;
  final News news;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        children: [
          const Text(
            "LIVE Transfer Talk: Ronaldo pushing for Man City move",
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              color: MyColors.white,
            ),
          ),
          const SizedBox(height: 10.0),
          NewsSocialSection(news: news),
          const SizedBox(height: 10.0),
          NewsTextContent(isExpanded: isExpanded, news: news),
        ],
      ),
    );
  }
}
