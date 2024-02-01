import 'package:my_taraji/services/enums/financial_transaction_type.dart';
import 'package:my_taraji/views/fanpay/models/transaction_model.dart';

import '../imports.dart';

class TransfertProvider with ChangeNotifier {
  final TextEditingController _signinId = TextEditingController();
  final TextEditingController _pinCode = TextEditingController();
  final TextEditingController _signinPwd = TextEditingController();
  String _step = "transfert";
  String _title = "Transfert";
  TransactionSettings _transactionSettings = TransactionSettings(
    authorizedAmounts: [],
    isFreeInputAmountActivated: false,
    isMinimumThresholdAmountActive: false,
    minimumThresholdAmount: 0,
    minimumThresholdViloationMessage: "",
    organizationAgentCode: 0,
    isAnonymosContributionActivated: false,
    transactionType: 0,
  );
  final TextEditingController _amountController = TextEditingController();
  bool _isTypeCash = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _convertedAmount = "";
  bool _isValidForm = false;
  TransactionService transactionService = TransactionService();
  bool _isLoading = false;
  bool _showContact = false;

  bool get showContact => _showContact;

  void toggleShowContact() {
    _showContact = !_showContact;
    notifyListeners();
  }

  void setIsLoading(bool isLoading) {
    _isLoading = isLoading;
  }

  void setTransfertTitle(String newTitle) {
    _title = newTitle;
    notifyListeners();
  }

  void setAmount(int amount) {
    _amountController.text = amount.toString();
    notifyListeners();
  }

  void setStep(String newStep) {
    switch (newStep) {
      case "confirmTransfert":
        if (_formKey.currentState?.validate() == true || _isValidForm) {
          _isValidForm = true;
          _step = newStep;
          setTransfertTitle("Confirmer transfert");
          convertAmount();
        }
        break;
      case "finishTransfert":
        _step = newStep;
        setTransfertTitle("");
        break;
      case "transfert":
        _step = "transfert";
        setTransfertTitle("Transfert");
        break;
      case "pinCode":
        _step = newStep;
        setTransfertTitle("Code PIN");
        break;
      case "connect":
        _step = newStep;
        setTransfertTitle("Connexion");
        break;
    }

    notifyListeners();
  }

  void setTypeCash(bool newType) {
    _isTypeCash = newType;
    notifyListeners();
  }

  void initAllData() {
    _step = "transfert";
    _amountController.text = "";
    _amountController.value = TextEditingValue.empty;
    _pinCode.text = "";
    _pinCode.value = TextEditingValue.empty;
    _signinId.text = "";
    _signinId.value = TextEditingValue.empty;
    _signinPwd.text = "";
    _signinPwd.value = TextEditingValue.empty;
    _isTypeCash = false;
    _title = "Transfert";
    _isValidForm = false;
    _formKey.currentState?.reset();
    _convertedAmount = "";
    _isLoading = false;
    manageAmountController();
    notifyListeners();
  }

  void getTransfertSettings() async {
    TransactionType type = getTransactionType(2);
    TransactionSettings transactionSettings =
        await transactionService.getTransactionSettings(type);
    transactionSettings.authorizedAmounts
        .sort((a, b) => a.amount.compareTo(b.amount));
    _transactionSettings = transactionSettings;
  }

  void manageAmountController() {
    if (_transactionSettings.isMinimumThresholdAmountActive) {
      _amountController.text =
          _transactionSettings.minimumThresholdAmount.toString();
    }
    notifyListeners();
  }

  void convertAmount() async {
    try {
      double amoutConverted =
          await transactionService.getCoinsConvertor(_amountController.text);
      _convertedAmount = amoutConverted.toStringAsFixed(0);
    } catch (e) {
      throw ('Error converting amount: $e');
    }
    notifyListeners();
  }

  void createTransfert(User? user) async {
    setIsLoading(true);
    TransactionModel transfertModel = TransactionModel(
      contributionMethod: _isTypeCash ? 2 : 1,
      amountContributed: int.parse(_amountController.text),
      coinsCountContributed: int.parse(_convertedAmount),
    );
    await transactionService.createTransaction(transfertModel).then((value) {
      setIsLoading(false);
      // review here
      // if ((user?.mytarajiUser?.isSubscribedIZI ?? false) && value) {
      //   setStep("finishTransfert");
      // } else {
      //   setStep("connect");
      // }
    });
  }

  void validateConnectionForm(BuildContext context) async {
    _isLoading = true;
    notifyListeners();
    if (_formKey.currentState?.validate() ?? false) {
      Future.delayed(const Duration(seconds: 3), () {
        FocusScope.of(context).unfocus();
        setStep("pinCode");
        _isLoading = false;
        notifyListeners();
      });
    } else {
      _isLoading = false;
      notifyListeners();
    }
  }

  void validateVerifForm(BuildContext context) async {
    _isLoading = true;
    notifyListeners();
    if (_formKey.currentState?.validate() ?? false) {
      Future.delayed(const Duration(seconds: 3), () {
        FocusScope.of(context).unfocus();
        setStep("finishTransfert");
        _isLoading = false;
        notifyListeners();
      });
    } else {
      _isLoading = false;
      notifyListeners();
    }
  }

  String get step => _step;
  String get title => _title;
  TextEditingController get amountController => _amountController;
  bool get isTypeCash => _isTypeCash;
  TransactionSettings get transfertSettings => _transactionSettings;
  GlobalKey<FormState> get formKey => _formKey;
  String get convertedAmount => _convertedAmount;
  bool get isValidForm => _isValidForm;
  bool get isLoading => _isLoading;
  TextEditingController get signinId => _signinId;
  TextEditingController get signinPwd => _signinPwd;
  TextEditingController get pinCode => _pinCode;
}
