import '../../../../import.dart';

class NewsCarouselItem extends StatelessWidget {
  const NewsCarouselItem({super.key, required this.news});

  final News news;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: buildContext(),
      onTap: () => goToNewsDetails(context, news),
    );
  }

  Widget buildContext() {
    return Row(
      children: [
        Container(
          margin: const EdgeInsets.only(left: 30.0, right: 10.0),
          width: 140.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            image: DecorationImage(
              // image: AssetImage(news.imagePath ?? ''),
              image: NetworkImage(news.imagePath ?? ''),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Expanded(
          child: Column(
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
                // [news.social?.views ?? '', news.date].join(" • "),
                [news.date].join(""),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 12.0, color: MyColors.grey),
              ),
              // const SizedBox(height: 6.0),
              // Text(
              //   news.admin,
              //   maxLines: 1,
              //   overflow: TextOverflow.ellipsis,
              //   style: const TextStyle(fontSize: 13.0, color: MyColors.grey),
              // ),
            ],
          ),
        )
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
}
