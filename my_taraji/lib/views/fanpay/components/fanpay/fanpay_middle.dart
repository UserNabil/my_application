import '../../imports.dart';

class FanPayMiddleContent extends StatelessWidget {
  const FanPayMiddleContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        setIconWithTitle(
          FanPayIcon.don,
          onTap: () {
            showBottomModal(context);
          },
        ),
        setIconWithTitle(
          FanPayIcon.transfer,
          onTap: () {
            showBottomModal(context);
          },
        ),
        setIconWithTitle(
          FanPayIcon.payment,
          onTap: () {
            showBottomModal(context);
          },
        ),
        setIconWithTitle(
          FanPayIcon.plus,
          onTap: () {
            showBottomModal(context);
          },
        ),
      ],
    );
  }

  Widget setIconWithTitle(FanPayIcon type, {Function()? onTap}) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        onTap!();
      },
      child: Column(
        children: [
          Container(
            decoration: const BoxDecoration(
              color: MyColors.blueLighter,
              borderRadius: BorderRadius.all(
                Radius.circular(50),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: setIconFromSvg(type),
            ),
          ),
          const SizedBox(height: 5),
          Text(
            type.value.title,
            style: const TextStyle(
              color: MyColors.grey,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }

  showBottomModal(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: Colors.white,
      context: context,
      builder: (BuildContext context) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(32),
              topRight: Radius.circular(32),
            ),
          ),
          height: MediaQuery.of(context).size.height * 0.5,
          child: Center(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  child: SvgPicture.asset(
                    'images/icons/drag.svg',
                    height: 5,
                    width: 5,
                  ),
                ),
                const Text(
                  "Plus de Services",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: Wrap(
                    alignment: WrapAlignment.start,
                    crossAxisAlignment: WrapCrossAlignment.start,
                    spacing: 20.0,
                    runSpacing: 15.0,
                    children: [
                      for (FanPayIcon icon in FanPayIcon.values
                          .where((element) => element.index != 3))
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: setIconWithTitle(icon),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget setIcon(FanPayIcon type) {
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
}

SvgPicture setIconFromSvg(FanPayIcon type) {
  return SvgPicture.asset(
    FanPayIcon.values[type.index].value.svgPath,
    height: 30,
    width: 30,
  );
}
