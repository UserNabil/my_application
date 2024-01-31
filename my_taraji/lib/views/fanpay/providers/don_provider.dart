import 'package:my_taraji/services/enums/financial_transaction_type.dart';
import 'package:my_taraji/services/user_service.dart';
import 'package:my_taraji/views/fanpay/models/transaction_model.dart';
import '../imports.dart';

class DonProvider with ChangeNotifier {
  final TextEditingController _signinId = TextEditingController();
  final TextEditingController _pinCode = TextEditingController();
  final TextEditingController _signinPwd = TextEditingController();
  String _step = "don";
  String _title = "Don";
  TransactionSettings _donSettings = TransactionSettings(
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
  UserService userService = UserService();
  bool _isLoading = false;
  bool _isValid = false;

  void setIsValid(bool isValid) {
    _isValid = isValid;
    notifyListeners();
  }

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
    print("test $newStep");
    switch (newStep) {
      case "confirmDon":
        if (_formKey.currentState?.validate() == true || _isValidForm) {
          _isValidForm = true;
          _step = newStep;
          setDonTitle("Confirmer don");
          convertAmount();
        }
        // notifyListeners();
        break;
      case "finishDon":
        _step = newStep;
        setDonTitle("");
        // notifyListeners();
        break;
      case "don":
        _step = "don";
        setDonTitle("Don");
        // notifyListeners();
        break;
      case "pinCode":
        _step = newStep;
        setDonTitle("Code PIN");
        // notifyListeners();
        break;
      case "connect":
        _step = newStep;
        setDonTitle("Connexion");
        // notifyListeners();
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
    _pinCode.text = "";
    _pinCode.value = TextEditingValue.empty;
    _signinId.text = "";
    _signinId.value = TextEditingValue.empty;
    _signinPwd.text = "";
    _signinPwd.value = TextEditingValue.empty;
    _isTypeCash = false;
    _title = "Don";
    _isValidForm = false;
    _formKey.currentState?.reset();
    _convertedAmount = "";
    _isLoading = false;
    _isValid = false;

    manageAmountController();
    notifyListeners();
  }

  void getDonSettings() async {
    TransactionType type = getTransactionType(1);
    TransactionSettings donSettings =
        await transactionService.getTransactionSettings(type);
    donSettings.authorizedAmounts.sort((a, b) => a.amount.compareTo(b.amount));
    _donSettings = donSettings;
    notifyListeners();
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
          await transactionService.getCoinsConvertor(_amountController.text);

      _convertedAmount = amoutConverted.toStringAsFixed(0);
    } catch (e) {
      throw ('Error converting amount: $e');
    }
    notifyListeners();
  }

  void createDonation(User? user) async {
    setIsLoading(true);
    TransactionModel donModel = TransactionModel(
      contributionMethod: _isTypeCash ? 2 : 1,
      amountContributed: int.parse(_amountController.text),
      coinsCountContributed: int.parse(_convertedAmount),
    );
    await transactionService.createTransaction(donModel).then((value) {
      setIsLoading(false);
      debugPrint("value: ${value.data?.isIZIAuthenticated.toString()}");
      if (_isTypeCash == true) {
        setStep("finishDon");
      } else {
        if (value.data?.isIZIAuthenticated == true &&
            value.data?.isIZIAuthorized == true) {
          setStep("finishDon");
        } else if (value.data?.isIZIAuthenticated == true &&
            value.data?.isIZIAuthorized == false) {
          setStep("pinCode");
        } else if (value.data?.isIZIAuthenticated == false &&
            value.data?.isIZIAuthorized == false) {
          setStep("connect");
        }
      }
    });
  }

  void validateConnectionForm(BuildContext context) async {
    setIsLoading(true);
    if (_formKey.currentState?.validate() ?? false) {
      FocusScope.of(context).unfocus();
      AuthenticationModel authModel = AuthenticationModel(
        username: _signinId.text,
        password: _signinPwd.text,
      );
      await userService
          .authUserIzi(authModel.username, authModel.password)
          .then((value) {
        setIsLoading(false);
        if (value.isIZIAuthenticated == true && value.isIZIAuthorized == true) {
          setStep("finishDon");
        } else if (value.isIZIAuthenticated == true &&
            value.isIZIAuthorized == false) {
          setStep("pinCode");
        } else if (value.isIZIAuthenticated == false &&
            value.isIZIAuthorized == false) {
          setStep("connect");
        }
      });
    } else {
      setIsLoading(false);
    }
  }

  void validateVerifForm(BuildContext context) async {
    setIsLoading(true);
    setIsValid(true);
    if (_formKey.currentState?.validate() ?? false) {
      FocusScope.of(context).unfocus();
      await userService.confirmAuthIzi(_pinCode.text).then((value) {
        setIsLoading(false);
        if (value) {
          setStep("finishDon");
        } else {
          setIsValid(false);
          setStep("pinCode");
        }
      });
    } else {
      setIsLoading(false);
    }
  }

  String get step => _step;
  String get title => _title;
  TextEditingController get amountController => _amountController;
  bool get isTypeCash => _isTypeCash;
  TransactionSettings get donSettings => _donSettings;
  GlobalKey<FormState> get formKey => _formKey;
  String get convertedAmount => _convertedAmount;
  bool get isValidForm => _isValidForm;
  bool get isLoading => _isLoading;
  TextEditingController get signinId => _signinId;
  TextEditingController get signinPwd => _signinPwd;
  TextEditingController get pinCode => _pinCode;
  bool get isValid => _isValid;
}
