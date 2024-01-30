import 'package:my_taraji/services/enums/financial_transaction_type.dart';
import 'package:my_taraji/views/fanpay/models/don_model.dart';

import '../imports.dart';

class DonProvider with ChangeNotifier {
  String _step = "don";
  String _title = "Don";
  DonSettings _donSettings = DonSettings(
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
  DonService donService = DonService();
  bool _isLoading = false;

  void setIsLoading(bool isLoading) {
    _isLoading = isLoading;
    notifyListeners();
  }

  void setDonTitle(String newTitle) {
    _title = newTitle;
    notifyListeners();
  }

  void setAmount(int amount) {
    _amountController.text = amount.toString();
    notifyListeners();
  }

  void setStep(String newStep) {
    switch (newStep) {
      case "confirmDon":
        if (_formKey.currentState?.validate() == true || _isValidForm) {
          _isValidForm = true;
          _step = newStep;
          setDonTitle("Confirmer don");
          convertAmount();
        }
        break;
      case "finishDon":
        _step = newStep;
        setDonTitle("");
        break;
      case "don":
        _step = "don";
        setDonTitle("Don");
        break;
      case "pinCode":
        _step = newStep;
        setDonTitle("Code PIN");
        break;
      case "connect":
        _step = newStep;
        setDonTitle("Connexion");
        break;
    }

    notifyListeners();
  }

  void setTypeCash(bool newType) {
    _isTypeCash = newType;
    notifyListeners();
  }

  void initAllData() {
    _step = "don";
    _amountController.text = "";
    _amountController.value = TextEditingValue.empty;
    _isTypeCash = true;
    _title = "Don";
    _isValidForm = false;
    _formKey.currentState?.reset();
    _convertedAmount = "";
    _isLoading = false;
    manageAmountController();
    notifyListeners();
  }

  void getDonSettingsProv() async {
    TransactionType type = getTransactionType(1);
    DonSettings donSettings = await donService.getDonSettings(type);
    donSettings.authorizedAmounts.sort((a, b) => a.amount.compareTo(b.amount));
    _donSettings = donSettings;
  }

  void manageAmountController() {
    if (_donSettings.isMinimumThresholdAmountActive) {
      _amountController.text = _donSettings.minimumThresholdAmount.toString();
    }
    notifyListeners();
  }

  void convertAmount() async {
    try {
      double amoutConverted =
          await donService.getCoinsConvertor(_amountController.text);
      // debugPrint(amoutConverted.toString());
      _convertedAmount = amoutConverted.toStringAsFixed(0);
    } catch (e) {
      throw ('Error converting amount: $e');
    }
    notifyListeners();
  }

  void createDonation(User? user) async {
    DonModel donModel = DonModel(
      contributionMethod: _isTypeCash ? 2 : 1,
      amountContributed: int.parse(_amountController.text),
      coinsCountContributed: int.parse(_convertedAmount),
    );
    debugPrint(donModel.toJson().toString());
    bool result = await donService.createDonation(donModel);

    // review here
    if ((user?.mytarajiUser?.isSubscribedIZI ?? false) && result) {
      setStep("finishDon");
    } else {
      setStep("connect");
    }
  }

  String get step => _step;
  String get title => _title;
  TextEditingController get amountController => _amountController;
  bool get isTypeCash => _isTypeCash;
  DonSettings get donSettings => _donSettings;
  GlobalKey<FormState>? get formKey => _formKey;
  String get convertedAmount => _convertedAmount;
  bool get isValidForm => _isValidForm;
  bool get isLoading => _isLoading;
}
