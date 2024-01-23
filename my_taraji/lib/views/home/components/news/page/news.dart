import 'package:my_taraji/views/home/components/news/service/news_service.dart';

import '../../../import.dart';
import '../components/fakedata.dart';

class ListNews extends StatefulWidget {
  const ListNews({super.key});

  @override
  ListNewsState createState() => ListNewsState();
}

class ListNewsState extends State<ListNews> {
  FakeData fakeData = FakeData();
  NewsService newsService = NewsService();
  List<News> newsDataList = [];

  @override
  void initState() {
    super.initState();
  }

  Future<List<News>> _getAllNews() async {
    return await newsService.getAllNews();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return FutureBuilder(
      future: _getAllNews(),
      builder: (context, AsyncSnapshot<List<News>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container();
          // return const Center(
          //   child: CircularProgressIndicator(),
          // );
        }

        if (snapshot.hasError || snapshot.data == null) {
          return Center(
            child: Text('${snapshot.error}'),
          );
        }

        newsDataList = snapshot.data!;
        return Column(
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
