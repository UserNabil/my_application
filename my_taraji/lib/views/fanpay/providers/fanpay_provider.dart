import 'package:my_taraji/views/fanpay/models/account_card.dart';

import '../imports.dart';

class FanPayProvider with ChangeNotifier {
  bool _isOpen = false;
  final ScrollController _scrollController = ScrollController();
  bool _iziAccount = false;
  TransactionService transactionService = TransactionService();
  AccountCard? _accountCard;

  String formatCardNumber(String cardNumber) {
    String cleanedCardNumber = cardNumber.replaceAll(RegExp(r'\D'), '');

    if (cleanedCardNumber.length < 4) {
      return "";
    }

    String lastFourDigits =
        cleanedCardNumber.substring(cleanedCardNumber.length - 4);

    String maskedCardNumber = "•••• •••• •••• •••• $lastFourDigits";

    return maskedCardNumber;
  }

  Future<AccountCard> getAccountCard() async {
    await transactionService.getWalletDetails().then((value) {
      _accountCard = value.data;
    });
    return _accountCard!;
  }

  void setAccountCard(AccountCard accountCard) {
    _accountCard = accountCard;
    notifyListeners();
  }

  void openModal() {
    _isOpen = !_isOpen;
    notifyListeners();
  }

  void initPositionScroller() {
    _scrollController.animateTo(
      0.0,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  void setIziAccount(bool value) {
    _iziAccount = value;
    notifyListeners();
  }

  bool get isOpen => _isOpen;
  ScrollController get scroll => _scrollController;
  bool get iziAccount => _iziAccount;
  AccountCard? get accountCard => _accountCard;
}
