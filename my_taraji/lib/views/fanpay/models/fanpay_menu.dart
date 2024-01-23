import 'package:my_taraji/views/fanpay/imports.dart';

enum FanPayMenuItem { don, transfer, payment, plus, recharge, retrait }

extension FanPayIconExtension on FanPayMenuItem {
  FanPayIconRedirection get value {
    switch (this) {
      case FanPayMenuItem.don:
        return FanPayIconRedirection(
            'images/svgs/fanpay/wallet.svg', 'Don', const MyDon(), null);
      case FanPayMenuItem.transfer:
        return FanPayIconRedirection('images/svgs/fanpay/transfer.svg',
            'Transfert', Scaffold(appBar: AppBar()), null);
      case FanPayMenuItem.payment:
        return FanPayIconRedirection('images/svgs/fanpay/payment.svg',
            'Paiement', Scaffold(appBar: AppBar()), null);
      case FanPayMenuItem.plus:
        return FanPayIconRedirection(
            'images/svgs/fanpay/more.svg', 'Plus', null, null);
      case FanPayMenuItem.recharge:
        return FanPayIconRedirection('images/svgs/fanpay/recharge.svg',
            'Recharge', Scaffold(appBar: AppBar()), null);
      case FanPayMenuItem.retrait:
        return FanPayIconRedirection('images/svgs/fanpay/retrait.svg',
            'Retrait', Scaffold(appBar: AppBar()), null);
    }
  }
}

class FanPayIconRedirection {
  String svgPath;
  String title;
  Widget? widget;
  FanPayAction? action;

  FanPayIconRedirection(this.svgPath, this.title, this.widget, this.action);
}
