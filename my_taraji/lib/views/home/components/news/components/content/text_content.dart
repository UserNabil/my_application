import '../../../../import.dart';

class NewsTextContent extends StatefulWidget {
  const NewsTextContent(
      {super.key, required this.isExpanded, required this.news});

  final bool isExpanded;
  final News news;

  @override
  NewsTextContentState createState() => NewsTextContentState();
}

class NewsTextContentState extends State<NewsTextContent> {
  bool isShort = true;

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
            crossFadeState: widget.isExpanded
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
            firstChild: buildDescription(
                widget.news.texts.join("\n\n"), widget.isExpanded),
            secondChild: buildDescription(
                widget.news.texts.join("\n\n"), widget.isExpanded),
          ),
        ],
      ),
    );
  }

  Widget buildDescription(String text, bool isExpanded) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        isExpanded
            ? buildText(text, isExpanded)
            : buildExpandedText(text, isExpanded),
        const SizedBox(height: 50.0),
      ],
    );
  }

  Widget buildExpandedText(String text, bool isExpanded) {
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
      child: buildText(text, isExpanded),
    );
  }

  Widget buildText(String text, bool isExpanded) {
    return Text(
      text,
      maxLines: isExpanded ? null : 10,
      overflow: isExpanded ? null : TextOverflow.ellipsis,
      style: const TextStyle(
        color: MyColors.white,
        fontSize: 16.0,
      ),
    );
  }
}
