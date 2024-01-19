import 'package:my_taraji/views/fanpay/imports.dart';
import 'package:my_taraji/views/selfcare/components/transations/fakedata.dart';

class TransactionLister extends StatelessWidget {
  const TransactionLister({super.key});

  @override
  Widget build(BuildContext context) {
    SelfcareFakeData fakeData = SelfcareFakeData();
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: fakeData.cardData.length,
      padding: const EdgeInsets.all(8.0),
      itemBuilder: (context, index) {
        return buildCard(
          fakeData.cardData[index]['imageName']!,
          fakeData.cardData[index]['title']!,
          fakeData.cardData[index]['description']!,
          fakeData.cardData[index]['xpText']!,
          fakeData.cardData[index]['coin']!,
        );
      },
    );
  }

  Widget buildCard(String imageName, String title, String description,
      String xpText, String coin) {
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
                    style: const TextStyle(
                      fontSize: 10.0,
                      color: Colors.grey,
                    ),
                    description),
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
