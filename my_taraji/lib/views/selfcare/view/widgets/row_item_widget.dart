import 'package:my_taraji/views/fanpay/imports.dart';

class RowItemWidget extends StatelessWidget {
  final String title;
  final String location;
  final IconData icon;
  final void Function()? onTap;
  const RowItemWidget({
    super.key,
    required this.title,
    required this.location,
    required this.icon,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: InkWell(
        onTap: onTap,
        child: Row(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.red[50],
                borderRadius: BorderRadius.circular(50),
              ),
              child: Icon(
                icon,
                color: MyColors.yellow,
              ),
            ),
            const SizedBox(width: 20),
            Text(
              title,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),
            const Spacer(),
            const Icon(
              TablerIcons.chevron_right,
              color: MyColors.grey,
            ),
          ],
        ),
      ),
    );
  }
}
