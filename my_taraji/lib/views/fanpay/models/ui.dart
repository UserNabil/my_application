import 'package:my_taraji/views/fanpay/imports.dart';

class DonUI {
  Text textType1(String title, bool centred, bool? isLittle) {
    return Text(
      title,
      textAlign: centred == true ? TextAlign.center : TextAlign.start,
      style: TextStyle(
        color: MyColors.grey,
        fontWeight: FontWeight.w300,
        fontSize: isLittle == true ? 14.0 : 16.0,
      ),
    );
  }

  Text textType2(String title) {
    return Text(
      title,
      style: const TextStyle(
        color: MyColors.black,
        fontWeight: FontWeight.w400,
        fontSize: 16.0,
      ),
    );
  }

  SizedBox divider(height) {
    return SizedBox(
      height: height,
      child: const Divider(
        thickness: .5,
        color: MyColors.grey,
      ),
    );
  }

  LayoutBuilder dottedDivider(height, color) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final boxWidth = constraints.constrainWidth();
        const dashWidth = 10.0;
        final dashHeight = height;
        final dashCount = (boxWidth / (2 * dashWidth)).floor();

        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            for (var _ in List.generate(dashCount, (_) => null))
              SizedBox(
                width: dashWidth,
                height: dashHeight,
                child: DecoratedBox(
                  decoration: BoxDecoration(color: color),
                ),
              ),
          ],
        );
      },
    );
  }

  setIcon(FanPayMenuItem type) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {},
      child: Container(
        decoration: const BoxDecoration(
          color: MyColors.blueLighter,
          borderRadius: BorderRadius.all(
            Radius.circular(50),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(0),
          child: setIconFromSvg(type),
        ),
      ),
    );
  }

  setIconFromSvg(FanPayMenuItem type) {
    return SvgPicture.asset(
      FanPayMenuItem.values[type.index].value.svgPath,
      height: 30,
      width: 30,
    );
  }
}
