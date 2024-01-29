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
  );
  final TextEditingController _amountController = TextEditingController();
  bool _isTypeCash = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _convertedAmount = "";
  bool _isValidForm = false;
  DonService donService = DonService();

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
    manageAmountController();
    notifyListeners();
  }

  void setDonSettings(DonSettings newDonSettings) {
    _donSettings = newDonSettings;
    notifyListeners();
  }

  void getDonSettings() async {
    DonSettings donSettings = await donService.getDonSettings();
    donSettings.authorizedAmounts.sort((a, b) => a.amount.compareTo(b.amount));
    setDonSettings(donSettings);
  }

  void manageAmountController() {
    if (_donSettings.isMinimumThresholdAmountActive) {
      _amountController.text = _donSettings.minimumThresholdAmount.toString();
    }
    notifyListeners();
  }

  void convertAmount() async {
    double convertedAmount = await donService
        .getCoinsConvertor(double.parse(_amountController.text));
    _convertedAmount = convertedAmount.toStringAsFixed(0);
    notifyListeners();
  }

  void createDonation(bool isConnected, BuildContext context, User user) async {
    DonModel donModel = DonModel(
      iziPinCode: 0,
      contributionMethod: _isTypeCash ? 2 : 1,
      amountContributed: int.parse(_amountController.text),
      coinsCountContributed: int.parse(_convertedAmount),
    );
    donModel = await donService.createDonation(donModel);
    // ignore: use_build_context_synchronously
    isConnected = user.isIzi ?? false;

    if (isConnected) {
      if (donModel.iziPinCode != 0) {
        setStep("finishDon");
      } else {
        setStep("pinCode");
      }
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
}
