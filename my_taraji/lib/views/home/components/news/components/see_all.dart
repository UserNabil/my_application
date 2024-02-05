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
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: itemWidgetNews(news, context),
        ),
      ),
    ];

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: MyColors.white),
        title: const Text(
          'Toutes les activités',
          style: TextStyle(color: MyColors.white),
        ),
        backgroundColor: const Color.fromARGB(184, 136, 20, 28),
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

Widget itemWidgetNews(News news, BuildContext context) {
  String formatDate(String date) {
    var dateParse = DateTime.parse(date);
    var formattedDate =
        "${dateParse.day}.${dateParse.month}.${dateParse.year}  •  ${dateParse.hour}h${dateParse.minute}";
    return formattedDate.toString();
  }

  Widget buildContentV2(News news) {
    return SizedBox(
      height: 100,
      width: MediaQuery.of(context).size.width / 1.2,
      child: Row(
        children: [
          Container(
            margin: const EdgeInsets.only(left: 10.0),
            width: 140.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              image: DecorationImage(
                image: NetworkImage(news.imagePath ?? ''),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                news.title,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style: const TextStyle(
                  fontSize: 15.0,
                  fontWeight: FontWeight.w600,
                  color: MyColors.red,
                ),
              ),
              const SizedBox(height: 6.0),
              Text(
                [formatDate(news.date)].join(""),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 12.0, color: MyColors.grey),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildContent(News news) {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        Container(
          width: MediaQuery.of(context).size.width / 1.2,
          height: 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            image: DecorationImage(
              image: NetworkImage(news.imagePath ?? ''),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width / 1.2,
          height: 100,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                MyColors.red.withOpacity(0.2),
                MyColors.black.withOpacity(0.9),
              ],
            ),
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        Positioned(
          child: Center(
            child: SizedBox(
              width: MediaQuery.of(context).size.width / 1.2,
              height: 100,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      news.title,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: const TextStyle(
                        fontSize: 17.0,
                        fontWeight: FontWeight.w600,
                        color: MyColors.yellow,
                      ),
                    ),
                  ),
                  const SizedBox(height: 6.0),
                  Text(
                    [formatDate(news.date)].join(""),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 14.0,
                      color: MyColors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  void goToNewsDetails(BuildContext context, News news) {
    Navigator.push(
      context,
      MaterialPageRoute(
        barrierDismissible: true,
        builder: (context) => NewsPageDetails(news: news),
      ),
    );
  }

  return InkWell(
    child: buildContent(news),
    onTap: () => goToNewsDetails(context, news),
  );
}
