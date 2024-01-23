import '../../../../import.dart';

class NewsContent extends StatelessWidget {
  const NewsContent({super.key, required this.news});
  final News news;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            news.title,
            style: const TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              color: MyColors.white,
            ),
          ),
          const SizedBox(height: 10.0),
          Text(
            news.date,
            style: const TextStyle(fontSize: 12.0, color: MyColors.grey),
          ),
          // NewsSocialSection(news: news),
          const SizedBox(height: 10.0),
          NewsTextContent(news: news),
        ],
      ),
    );
  }
}
