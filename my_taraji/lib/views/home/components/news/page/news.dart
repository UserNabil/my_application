import 'package:my_taraji/views/home/components/news/service/news_service.dart';
import '../../../import.dart';

class ListNews extends StatelessWidget {
  const ListNews({super.key});

  @override
  Widget build(BuildContext context) {
    NewsService newsService = NewsService();
    List<News> newsDataList = [];
    Future<List<News>> getAllNews() async {
      return await newsService.getAllNews();
    }

    var width = MediaQuery.of(context).size.width;
    return FutureBuilder(
      future: getAllNews(),
      builder: (context, AsyncSnapshot<List<News>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container();
        }

        if (snapshot.hasError || snapshot.data == null) {
          return Center(
            child: Text('${snapshot.error}'),
          );
        }

        newsDataList = snapshot.data!;
        return newsDataList.isEmpty
            ? Container()
            : Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  NewsTopContent(news: newsDataList),
                  Container(
                    width: width,
                    transform: Matrix4.translationValues(-width / 25, 0, 0),
                    child: NewsCarouselBuilder(newsDataList: newsDataList),
                  ),
                ],
              );
      },
    );
  }
}
