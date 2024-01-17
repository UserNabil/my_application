import '../../../../import.dart';

class NewsSocialSection extends StatelessWidget {
  const NewsSocialSection({super.key, required this.news});

  final News news;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        newsAuthorContent(),
        socialContent(),
      ],
    );
  }

  Widget newsAuthorContent() {
    return Row(
      children: [
        Container(
          width: 37.0,
          height: 37.0,
          decoration: BoxDecoration(
            color: MyColors.white,
            borderRadius: BorderRadius.circular(50.0),
            image: DecorationImage(
              image: NetworkImage(news.social!.imgAuthor),
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(width: 14.0),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              news.admin,
              style: const TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w600,
                color: MyColors.white,
              ),
            ),
            Text(
              news.date,
              style: const TextStyle(
                fontSize: 12.0,
                fontWeight: FontWeight.w400,
                color: MyColors.grey,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget socialContent() {
    return Row(
      children: [
        socialItem(
            const Icon(
              TablerIcons.heart,
              size: 18,
              color: MyColors.white,
            ),
            news.social!.like),
        const SizedBox(width: 10.0),
        socialItem(
            const Icon(
              TablerIcons.message_dots,
              size: 18,
              color: MyColors.white,
            ),
            news.social!.comment),
      ],
    );
  }

  Widget socialItem(Icon icon, String text) {
    return Row(
      children: [
        icon,
        const SizedBox(width: 5.0),
        Text(
          text,
          style: const TextStyle(
            fontSize: 12.0,
            fontWeight: FontWeight.w500,
            color: MyColors.white,
          ),
        ),
      ],
    );
  }
}
