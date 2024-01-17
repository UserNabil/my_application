import '../../../../import.dart';

class NewsTopContent extends StatelessWidget {
  const NewsTopContent({super.key, required this.news});

  final List<News> news;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: MyColors.transparent,
      padding: const EdgeInsets.all(15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Latest News',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 20.0,
              color: MyColors.yellow,
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AllContentNews(
                    news: news,
                  ),
                ),
              );
            },
            child: const Text(
              'VOIR TOUS',
              style: TextStyle(
                backgroundColor: MyColors.transparent,
                fontSize: 12.0,
                fontWeight: FontWeight.w500,
                color: MyColors.grey,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
