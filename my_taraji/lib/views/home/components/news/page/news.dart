import '../../../import.dart';
import '../components/fakedata.dart';

class ListNews extends StatefulWidget {
  const ListNews({super.key});

  @override
  ListNewsState createState() => ListNewsState();
}

class ListNewsState extends State<ListNews> {
  FakeData fakeData = FakeData();
  List<News> newsDataList = [];

  @override
  void initState() {
    super.initState();
  }

  Future<List<News>> getNews() async {
    return await fakeData.newNews();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return FutureBuilder(
      future: getNews(),
      builder: (context, AsyncSnapshot<List<News>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // return const SizedBox(
          //   height: 100,
          //   child: Center(
          //     child: CircularProgressIndicator(
          //       color: MyColors.yellow,
          //     ),
          //   ),
          // );
          return Container();
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
