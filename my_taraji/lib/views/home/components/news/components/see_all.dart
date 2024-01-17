import '../../../import.dart';

class AllContentNews extends StatelessWidget {
  const AllContentNews({
    super.key,
    required this.news,
  });

  final List<News> news;

  @override
  Widget build(BuildContext context) {
    final List<Widget> allActivities = [
      ...news.map(
        (news) => Padding(
          padding: const EdgeInsets.all(20),
          child: SizedBox(
              height: 195,
              child: NewsCarouselItem(
                news: news,
              )),
        ),
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Toutes les activités'),
      ),
      body: ListView.builder(
        itemCount: allActivities.length,
        itemBuilder: (context, index) {
          return allActivities[index];
        },
      ),
    );
  }
}
