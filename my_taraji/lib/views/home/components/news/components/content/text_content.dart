import '../../../../import.dart';

class NewsTextContent extends StatelessWidget {
  const NewsTextContent({super.key, required this.news});

  final News news;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          AnimatedCrossFade(
            duration: const Duration(milliseconds: 300),
            crossFadeState: context.watch<NewsProvider>().isExpanded
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
            firstChild: buildDescription(news.content, context),
            secondChild: buildDescription(news.content, context),
          ),
        ],
      ),
    );
  }

  Widget buildDescription(
      List<NewsDetailsModel> content, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        context.watch<NewsProvider>().isExpanded
            ? buildRichText(content)
            : buildNotExpandedText(content),
        const SizedBox(height: 50.0),
      ],
    );
  }

  Widget buildNotExpandedText(List<NewsDetailsModel> content) {
    List<NewsDetailsModel> contentToDisplay = content.getRange(0, 3).toList();
    return ShaderMask(
      shaderCallback: (Rect bounds) {
        return const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            MyColors.blue2,
            Colors.transparent,
          ],
        ).createShader(bounds);
      },
      blendMode: BlendMode.dstIn,
      child: buildRichText(contentToDisplay),
    );
  }

  Widget buildRichText(List<NewsDetailsModel> content) {
    return Column(
      children: content.map((newsDetailsModel) {
        switch (newsDetailsModel.detailHTML) {
          case 'h1':
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: RichText(
                text: TextSpan(
                  text: newsDetailsModel.detailValue,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 17.0,
                    color: MyColors.white,
                  ),
                ),
              ),
            );
          case 'h2':
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: RichText(
                text: TextSpan(
                  text: newsDetailsModel.detailValue,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15.0,
                    color: MyColors.white,
                  ),
                ),
              ),
            );
          case 'p':
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: RichText(
                text: TextSpan(
                  text: newsDetailsModel.detailValue,
                  style: const TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 12.0,
                    color: MyColors.white,
                  ),
                ),
              ),
            );
          case 'em':
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: RichText(
                text: TextSpan(
                  text: newsDetailsModel.detailValue,
                  style: const TextStyle(
                    fontSize: 13.0,
                    fontWeight: FontWeight.bold,
                    color: MyColors.white,
                  ),
                ),
              ),
            );
          case 'src':
            return Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              width: double.infinity,
              height: 200.0,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(newsDetailsModel.detailValue),
                ),
                borderRadius: const BorderRadius.all(Radius.circular(20)),
              ),
            );
          default:
            return const SizedBox.shrink();
        }
      }).toList(),
    );
  }
}
