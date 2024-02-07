import 'package:flutter/material.dart';
import 'package:my_taraji/core/theme/my_color.dart';
import 'package:my_taraji/services/enums/financial_transaction_type.dart';
import 'package:my_taraji/services/transaction_service.dart';
import 'package:my_taraji/services/user_service.dart';
import 'package:my_taraji/views/fanpay/models/transaction_model.dart';
import 'package:my_taraji/views/init/models/user.dart';

class CrowdFundingProvider with ChangeNotifier {
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
    // organizationAgentCode: 0,
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
    // notifyListeners();
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
    _amountController.text = "0";
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

  Future<TransactionSettings> getDonSettings() async {
    TransactionType type = getTransactionType(1);
    TransactionSettings donSettings =
        await transactionService.getTransactionSettings(type);
    donSettings.authorizedAmounts.sort((a, b) => a.amount.compareTo(b.amount));
    _donSettings = donSettings;
    notifyListeners();
    return donSettings;
  }

  void manageAmountController() {
    if (_donSettings.isMinimumThresholdAmountActive) {
      // _amountController.text = _donSettings.minimumThresholdAmount.toString();
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

  void showMySnackBar(String message, Color color, BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        showCloseIcon: true,
        content: Text(message),
        backgroundColor: color,
        duration: const Duration(seconds: 5),
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(20),
      ),
    );
  }

  void createDonation(User? user, BuildContext context) async {
    setIsLoading(true);

    TransactionModel donModel = TransactionModel(
      contributionMethod: _isTypeCoins ? 1 : 2,
      amountContributed: int.parse(_amountController.text),
      coinsCountContributed: int.parse(_convertedAmount),
      isAnonymosContributionActivated: false,
      crowdFundingQueneyId: "",
      queneyLevelId: user?.level?.currentLevel.id ?? "",
    );

    debugPrint("donModel: ${donModel.toJson().toString()}");

    if (_isTypeCoins && _userHaveCoins) {
      await transactionService.createTransaction(donModel).then((value) {
        setIsLoading(false);
        if (value.data?.isSuccess == true) {
          setStep("finishDon");
        } else {
          handleError(context);
        }
      });
    } else if (!_isTypeCoins) {
      await transactionService.createTransaction(donModel).then((value) {
        setIsLoading(false);
        if (value.data?.isSuccess == true) {
          if (value.data?.isIZIAuthenticated == true &&
              value.data?.isIZIAuthorized == true) {
            setStep("finishDon");
          } else {
            setStep(
                value.data?.isIZIAuthorized == false ? "pinCode" : "connect");
          }
        } else {
          handleError(context);
        }
      });
    } else {
      setIsLoading(false);
      _error = "Votre solde est insuffisant pour le don souhaité en coins.";
    }
  }

  void handleError(BuildContext context) {
    Navigator.pop(context);
    initAllData();
    showMySnackBar(
      _isTypeCoins
          ? "Une erreur s'est produite lors du don par coins."
          : "Une erreur s'est produite lors du don.",
      MyColors.red,
      context,
    );
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
          setIsLoading(false);
        } else if (value.isIZIAuthenticated == true &&
            value.isIZIAuthorized == false) {
          setStep("pinCode");
          setIsLoading(false);
        } else if (value.isIZIAuthenticated == false &&
            value.isIZIAuthorized == false) {
          setStep("connect");
          setIsLoading(false);
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
