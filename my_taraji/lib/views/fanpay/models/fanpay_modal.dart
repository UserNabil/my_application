import 'package:my_taraji/views/fanpay/providers/fanpay_provider.dart';
import 'package:my_taraji/views/home/import.dart';

class FanPayAction {
  Icon icon;
  Function onTap;

  FanPayAction({required this.icon, required this.onTap});
}

class FanPayModal {
  String title;
  Widget content;
  String? topModalSvg;

  FanPayModal({required this.title, required this.content});

  show(BuildContext context, FanPayAction? action) {
    showModalBottomSheet(
      enableDrag: false,
      useRootNavigator: true,
      barrierColor: Colors.black.withOpacity(0),
      isDismissible: false,
      scrollControlDisabledMaxHeightRatio: 1,
      backgroundColor: Colors.transparent,
      context: context,
      builder: (BuildContext context) {
        // ignore: deprecated_member_use
        return WillPopScope(
          onWillPop: () async {
            context.read<FanPayProvider>().openModal();
            return true;
          },
          child: content,
        );
      },
    );
  }
}
