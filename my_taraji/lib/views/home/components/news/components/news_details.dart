import 'package:my_taraji/views/home/components/news/service/news_service.dart';
import 'package:my_taraji/views/home/import.dart';

class NewsPageDetails extends StatelessWidget {
  const NewsPageDetails({super.key, required this.news});
  final News news;

  Future<News> _getNewsById(int id) async {
    NewsService newsService = NewsService();
    News newsApi = await newsService.getNewsById(id);
    return newsApi;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _getNewsById(news.id),
      builder: (BuildContext newsContext, AsyncSnapshot<News> snapshot) {
        if (snapshot.hasError || snapshot.data == null) {
          return Container();
        }

        final finalNews = snapshot.data!;

        return Scaffold(
          backgroundColor: MyColors.red,
          appBar: buildAppbar(newsContext),
          extendBodyBehindAppBar: true,
          body: Stack(
            children: [
              AnimatedContainer(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: MyColors.red,
                ),
                duration: const Duration(milliseconds: 250),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        height: 300.0,
                        child: Image.network(
                          news.imagePath ?? '',
                          fit: BoxFit.cover,
                        ),
                      ),
                      NewsContent(news: finalNews),
                    ],
                  ),
                ),
              ),
              newsContext.watch<NewsProvider>().isShort
                  ? const SizedBox()
                  : Positioned(
                      bottom: 20.0,
                      left: 70,
                      right: 70,
                      child: buildBottomBar(context),
                    ),
            ],
          ),
        );
      },
    );
  }

  ElevatedButton buildBottomBar(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        // ignore: deprecated_member_use
        primary: MyColors.yellow,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(50.0)),
        ),
        padding: const EdgeInsets.all(14.0),
      ),
      onPressed: () {
        context
            .read<NewsProvider>()
            .setIsExpanded(!context.read<NewsProvider>().isExpanded);
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            context.watch<NewsProvider>().isExpanded
                ? 'Réduire'
                : 'Afficher tout',
            style: const TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.w400,
              color: MyColors.white,
            ),
          ),
          const SizedBox(width: 10.0),
          Icon(
            context.watch<NewsProvider>().isExpanded
                ? TablerIcons.chevron_up
                : TablerIcons.chevron_down,
            size: 20,
            color: MyColors.white,
          ),
        ],
      ),
    );
  }
}

PreferredSizeWidget? buildAppbar(context) {
  return AppBar(
    toolbarHeight: 150,
    backgroundColor: MyColors.transparent,
    elevation: 0.0,
    leading: IconButton(
      icon: const Icon(
        size: 30,
        TablerIcons.arrow_left,
        color: MyColors.white,
      ),
      onPressed: () => Navigator.pop(context),
    ),
    actions: [
      Padding(
        padding: const EdgeInsets.only(right: 20.0),
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: MyColors.red,
            borderRadius: BorderRadius.circular(50.0),
          ),
          width: 55.0,
          height: 55.0,
          child: IconButton(
            icon: const Icon(
              size: 25,
              TablerIcons.share,
              color: MyColors.white,
            ),
            onPressed: () {},
          ),
        ),
      ),
    ],
  );
}
