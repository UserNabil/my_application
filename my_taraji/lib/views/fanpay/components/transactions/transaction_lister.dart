import 'package:my_taraji/views/fanpay/imports.dart';

class FanPayTransactionLister extends StatelessWidget {
  const FanPayTransactionLister({super.key, required this.transitions});
  final List<Transaction> transitions;

  @override
  Widget build(BuildContext context) {
    orderTransationByDate(transitions);
    List<Transaction> transitionsreduced = transitions;
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: transitionsreduced.length,
      padding: const EdgeInsets.all(8.0),
      itemBuilder: (context, index) {
        return buildCard(
          transitionsreduced[index],
          index,
          transitionsreduced.length - 1,
        );
      },
    );
  }

  orderTransationByDate(List<Transaction> transitions) {
    transitions.sort((a, b) => a.date.compareTo(b.date));
  }

  String separateTime(DateTime date) {
    return '${date.hour}:${date.minute} • ${date.day}/${date.month}/${date.year}';
  }

  Widget buildCard(Transaction transition, int index, int lastIndex) {
    return Column(
      children: [
        Row(
          children: [
            Image.asset(
              'images/pngs/${transition.imageName}.png',
              fit: BoxFit.cover,
            ),
            const SizedBox(width: 8.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  transition.title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16.0,
                  ),
                ),
                const SizedBox(height: 5.0),
                Text(
                  style: const TextStyle(
                    fontSize: 12.0,
                    color: Colors.grey,
                  ),
                  separateTime(transition.date),
                ),
              ],
            ),
            const Spacer(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  transition.coin,
                  style: const TextStyle(
                    fontSize: 13.0,
                    color: MyColors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ],
        ),
        if (index != lastIndex)
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
