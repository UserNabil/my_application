import 'package:flutter/Material.dart';
import 'package:my_taraji/core/theme/my_color.dart';

class CardTransaction extends StatelessWidget {
  final String imageName;
  final String title;
  final String description;
  final String xpText;
  final String coin;
  const CardTransaction({
    super.key,
    required this.imageName,
    required this.title,
    required this.description,
    required this.xpText,
    required this.coin,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Image.asset(
              'images/pngs/$imageName.png',
              fit: BoxFit.cover,
            ),
            const SizedBox(width: 8.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 15.0,
                  ),
                ),
                Text(
                  description,
                  style: const TextStyle(
                    fontSize: 10.0,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            const Spacer(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  xpText,
                  style: const TextStyle(
                    fontSize: 13.0,
                    color: Colors.green,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                    style: const TextStyle(
                      fontSize: 13.0,
                      color: Colors.red,
                      fontWeight: FontWeight.w500,
                    ),
                    coin),
              ],
            ),
          ],
        ),
        const SizedBox(
          height: 40.0,
          child: Divider(
            color: MyColors.grey,
            thickness: .3,
          ),
        ),
      ],
    );
  }
}
