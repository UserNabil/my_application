import 'package:flutter_svg/svg.dart';
import 'package:my_taraji/views/home/import.dart';

class StarsResult extends StatefulWidget {
  const StarsResult({super.key});

  @override
  StarsResultState createState() => StarsResultState();
}

class StarsResultState extends State<StarsResult> {
  Widget buildStar(Color? color, String svgUrl) {
    return SvgPicture.asset(
      svgUrl,
      // ignore: deprecated_member_use
      color: color,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        buildStar(MyColors.yellow, "images/svgs/stars.svg"),
        buildStar(MyColors.yellow, "images/svgs/big_stars.svg"),
        buildStar(MyColors.yellow, "images/svgs/stars.svg"),
      ],
    );
  }
}
