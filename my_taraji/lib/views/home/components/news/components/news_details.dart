import '../../../import.dart';

class NewsPageDetails extends StatefulWidget {
  const NewsPageDetails({super.key, required this.news});

  final News news;

  @override
  NewsPageDetailsState createState() => NewsPageDetailsState();
}

class NewsPageDetailsState extends State<NewsPageDetails> {
  bool isExpanded = false;
  bool isShort = false;

  @override
  void initState() {
    super.initState();
    checkTextLength(widget.news.texts);
  }

  void checkTextLength(List<String> texts) {
    const int maxCharacters = 280;

    int totalCharacters = texts.join().length;
    bool isTextShort = totalCharacters <= maxCharacters;

    setState(() {
      isShort = isTextShort;
      isExpanded = isTextShort;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.blue2,
      appBar: buildAppbar(context),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          AnimatedContainer(
            width: double.infinity,
            decoration: const BoxDecoration(
              color: MyColors.blue2,
            ),
            duration: const Duration(milliseconds: 250),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // Image
                  SizedBox(
                    width: double.infinity,
                    height: 350.0,
                    child: Image.asset(
                      widget.news.imagePath,
                      fit: BoxFit.cover,
                    ),
                  ),

                  // Content
                  NewsContent(isExpanded: isExpanded, news: widget.news),
                ],
              ),
            ),
          ),
          isShort
              ? const SizedBox()
              : Positioned(
                  bottom: 20.0,
                  left: 70,
                  right: 70,
                  child: buildBottomBar(),
                ),
        ],
      ),
    );
  }

  ElevatedButton buildBottomBar() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        // ignore: deprecated_member_use
        primary: MyColors.yellow,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(50.0)),
        ),
        padding: const EdgeInsets.all(20.0),
      ),
      onPressed: () {
        setState(() {
          isExpanded = !isExpanded;
        });
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            isExpanded ? 'Réduire' : 'Afficher tout',
            style: const TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.w400,
              color: MyColors.white,
            ),
          ),
          const SizedBox(width: 10.0),
          Icon(
            isExpanded ? TablerIcons.chevron_up : TablerIcons.chevron_down,
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
            color: MyColors.blue2,
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
