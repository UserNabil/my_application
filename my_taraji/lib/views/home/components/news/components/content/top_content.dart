import '../../../../import.dart';

class NewsTopContent extends StatelessWidget {
  const NewsTopContent({super.key});

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
              // setState(() {});
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
