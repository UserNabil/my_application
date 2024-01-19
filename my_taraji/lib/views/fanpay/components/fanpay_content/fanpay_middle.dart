import '../../imports.dart';

class FanPayMiddleContent extends StatelessWidget {
  const FanPayMiddleContent({super.key, required this.setModalStat});
  final Function setModalStat;

  @override
  Widget build(BuildContext context) {
    FanPayModal modal = FanPayModal(
      title: '',
      content: Container(),
    );
    setIconWithTitle(FanPayMenuItem type, BuildContext context, Widget? child,
        {Function? onTap}) {
      return GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          if (onTap != null) {
            onTap();
          } else {
            modal = FanPayModal(
              title: type.value.title,
              content: child!,
            );
            modal.show(context, setModalStat, type.value.action);
          }
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
                        for (FanPayMenuItem icon in FanPayMenuItem.values
                            .where((element) => element.index != 3))
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: setIconWithTitle(
                                icon, context, icon.value.widget),
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

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        setIconWithTitle(
          FanPayMenuItem.don,
          context,
          const MyDon(),
        ),
        setIconWithTitle(FanPayMenuItem.transfer, context,
            FanPayMenuItem.transfer.value.widget),
        setIconWithTitle(FanPayMenuItem.payment, context,
            FanPayMenuItem.payment.value.widget),
        setIconWithTitle(
          FanPayMenuItem.plus,
          context,
          FanPayMenuItem.plus.value.widget,
          onTap: () {
            showBottomModal(context);
          },
        ),
      ],
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
