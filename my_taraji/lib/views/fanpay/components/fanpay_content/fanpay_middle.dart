import 'package:my_taraji/views/fanpay/providers/transfert_provider.dart';

import '../../imports.dart';

class FanPayMiddleContent extends StatelessWidget {
  const FanPayMiddleContent({super.key});
  @override
  Widget build(BuildContext context) {
    DonUI donUI = DonUI();
    FanPayModal modal = FanPayModal(
      title: '',
      content: Container(),
    );

    setIconWithTitle(FanPayMenuItem type, BuildContext context,
        {Function? onTap}) {
      // ignore: unrelated_type_equality_checks
      if (type.value.title == FanPayMenuItem.don.value.title) {
        type.value.action?.onTap =
            () => context.read<DonProvider>().getDonSettings();
      } else if (type.value.title == FanPayMenuItem.transfer.value.title) {
        type.value.action?.onTap =
            () => context.read<TransfertProvider>().getTransfertSettings();
      }
      return GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          context.read<FanPayProvider>().initPositionScroller();
          if (onTap != null) {
            onTap();
          } else {
            modal = FanPayModal(
              title: type.value.title,
              content: type.value.widget!,
            );
            modal.show(context, type.value.action);
            context.read<FanPayProvider>().openModal();
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
                child: donUI.setIconFromSvg(type),
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
                            child: setIconWithTitle(icon, context),
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
        ),
        setIconWithTitle(
          FanPayMenuItem.transfer,
          context,
        ),
        setIconWithTitle(
          FanPayMenuItem.payment,
          context,
        ),
        setIconWithTitle(
          FanPayMenuItem.plus,
          context,
          onTap: () {
            showBottomModal(context);
          },
        ),
      ],
    );
  }
}
