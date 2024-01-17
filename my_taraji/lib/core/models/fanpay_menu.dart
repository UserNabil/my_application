enum FanPayIcon { don, transfer, payment, plus, recharge, retrait }

extension FanPayIconExtension on FanPayIcon {
  FanPayIconRedirection get value {
    switch (this) {
      case FanPayIcon.don:
        return FanPayIconRedirection('images/svgs/fanpay/wallet.svg', 'Don');
      case FanPayIcon.transfer:
        return FanPayIconRedirection(
            'images/svgs/fanpay/transfer.svg', 'Transfert');
      case FanPayIcon.payment:
        return FanPayIconRedirection(
            'images/svgs/fanpay/payment.svg', 'Paiement');
      case FanPayIcon.plus:
        return FanPayIconRedirection('images/svgs/fanpay/more.svg', 'Plus');
      case FanPayIcon.recharge:
        return FanPayIconRedirection(
            'images/svgs/fanpay/recharge.svg', 'Recharge');
      case FanPayIcon.retrait:
        return FanPayIconRedirection(
            'images/svgs/fanpay/retrait.svg', 'Retrait');
    }
  }
}

class FanPayIconRedirection {
  String svgPath;
  String title;

  FanPayIconRedirection(this.svgPath, this.title);
}
