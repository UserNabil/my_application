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
  bool _isTypeCoins = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _convertedAmount = "";
  bool _isValidForm = false;
  TransactionService transactionService = TransactionService();
  UserService userService = UserService();
  bool _isLoading = false;
  bool _isValid = false;
  bool _userHaveCoins = false;
  double _userCoins = 0;
  String _error = "";

  void calculateCoins(User? user) {
    if (user?.myRewards?.coins != null) {
      _userCoins =
          (user?.myRewards?.coins ?? 0) - double.parse(_convertedAmount);
      if (_userCoins >= 0) {
        _userHaveCoins = true;
      } else {
        _userHaveCoins = false;
      }
    } else {
      _userHaveCoins = false;
    }
    notifyListeners();
  }

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
        break;
      case "finishDon":
        _step = newStep;
        setDonTitle("");
        break;
      case "don":
        _step = "don";
        initAllData();
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

  void setTypeCash(bool newType, User? user) {
    _isTypeCoins = newType;
    _error = "";
    calculateCoins(user);
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
    _isTypeCoins = false;
    _title = "Don";
    _isValidForm = false;
    _formKey.currentState?.reset();
    _convertedAmount = "";
    _isLoading = false;
    _isValid = false;
    _userHaveCoins = false;
    _userCoins = 0;
    _error = "";

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
      contributionMethod: _isTypeCoins ? 2 : 1,
      amountContributed: int.parse(_amountController.text),
      coinsCountContributed: int.parse(_convertedAmount),
    );

    if (_isTypeCoins == true) {
      if (_userHaveCoins == true) {
        await transactionService.createTransaction(donModel).then((value) {
          setIsLoading(false);
          setStep("finishDon");
        });
      } else {
        setIsLoading(false);
        _error = "Votre solde est insuffisant pour le don souhaité en coins.";
      }
    } else {
      await transactionService.createTransaction(donModel).then((value) {
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
      });
    }
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
  bool get isTypeCash => _isTypeCoins;
  TransactionSettings get donSettings => _donSettings;
  GlobalKey<FormState> get formKey => _formKey;
  String get convertedAmount => _convertedAmount;
  bool get isValidForm => _isValidForm;
  bool get isLoading => _isLoading;
  TextEditingController get signinId => _signinId;
  TextEditingController get signinPwd => _signinPwd;
  TextEditingController get pinCode => _pinCode;
  bool get isValid => _isValid;
  bool get userHaveCoins => _userHaveCoins;
  double get userCoins => _userCoins;
  String get error => _error;
}
