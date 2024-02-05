import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:my_taraji/services/enums/financial_transaction_type.dart';
import 'package:my_taraji/services/user_service.dart';
import 'package:my_taraji/views/fanpay/models/transaction_model.dart';

import '../imports.dart';

class TransfertProvider with ChangeNotifier {
  final TextEditingController _signinId = TextEditingController();
  final TextEditingController _pinCode = TextEditingController();
  final TextEditingController _signinPwd = TextEditingController();
  String _step = "transfert";
  String _title = "Transfert";
  TransactionSettings _transfertSettings = TransactionSettings(
    authorizedAmounts: [],
    isFreeInputAmountActivated: false,
    isMinimumThresholdAmountActive: false,
    minimumThresholdAmount: 0,
    minimumThresholdViloationMessage: "",
    // organizationAgentCode: 0,
    isAnonymosContributionActivated: false,
    transactionType: 0,
  );
  UserService userService = UserService();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  bool _isTypeCoins = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _convertedAmount = "";
  bool _isValidForm = false;
  TransactionService transactionService = TransactionService();
  bool _isLoading = false;
  bool _showContact = false;
  bool _permissionDenied = false;
  List<Contact> _contacts = [];
  Contact _contactSelected = Contact();
  List<Contact> _filtredContacts = [];
  String _suffix = "";
  bool _isValid = false;

  void setIsValid(bool isValid) {
    _isValid = isValid;
    notifyListeners();
  }

  void searchContacts(String query) {
    final normalizedQuery = query.toLowerCase();

    _filtredContacts = _contacts.where((contact) {
      final displayName = contact.displayName.toLowerCase();
      final phoneNumbers = contact.phones
          .map((phone) => phone.normalizedNumber.toLowerCase())
          .toList();

      return displayName.contains(normalizedQuery) ||
          phoneNumbers.any((number) => number.contains(normalizedQuery));
    }).toList();

    notifyListeners();
  }

  void setListContact(List<Contact> listContact) {
    _contacts = listContact;
    // notifyListeners();
  }

  void setFiltredContacts(List<Contact> listContact) {
    _filtredContacts = listContact;
  }

  Future<List<Contact>> fetchContacts() async {
    if (!await FlutterContacts.requestPermission(readonly: true)) {
      _permissionDenied = true;
      return _contacts;
    } else {
      await FlutterContacts.getContacts(
        withProperties: true,
        withPhoto: true,
        sorted: true,
      ).then((value) => _contacts = value);
      return _contacts;
    }
  }

  void setNumberPhone(Contact? contact) {
    _contactSelected = contact!;
    _suffix = contact.phones[0].normalizedNumber.substring(0, 3);
    _phoneController.text = contact.phones[0].normalizedNumber.substring(3);
    notifyListeners();
  }

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
    // notifyListeners();
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
        initAllData();
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
    _isTypeCoins = newType;
    notifyListeners();
  }

  void initAllData() {
    _step = "transfert";
    _amountController.text = "";
    _amountController.value = TextEditingValue.empty;
    _phoneController.text = "";
    _phoneController.value = TextEditingValue.empty;
    _pinCode.text = "";
    _pinCode.value = TextEditingValue.empty;
    _signinId.text = "";
    _signinId.value = TextEditingValue.empty;
    _signinPwd.text = "";
    _signinPwd.value = TextEditingValue.empty;
    _isTypeCoins = false;
    _title = "Transfert";
    _isValidForm = false;
    _formKey.currentState?.reset();
    _convertedAmount = "";
    _isLoading = false;
    _showContact = false;
    _permissionDenied = false;
    _filtredContacts = [];
    _isValid = false;

    notifyListeners();
  }

  Future<TransactionSettings> getTransfertSettings() async {
    TransactionType type = getTransactionType(2);
    TransactionSettings transactionSettings =
        await transactionService.getTransactionSettings(type);
    transactionSettings.authorizedAmounts
        .sort((a, b) => a.amount.compareTo(b.amount));
    _transfertSettings = transactionSettings;
    notifyListeners();
    return transactionSettings;
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
      contributionMethod: _isTypeCoins ? 2 : 1,
      amountContributed: int.parse(_amountController.text),
      coinsCountContributed: int.parse(_convertedAmount),
    );

    await transactionService.createTransaction(transfertModel).then((value) {
      if (value.data?.isIZIAuthenticated == true &&
          value.data?.isIZIAuthorized == true) {
        setStep("finishTransfert");
        setIsLoading(false);
      } else if (value.data?.isIZIAuthenticated == true &&
          value.data?.isIZIAuthorized == false) {
        setStep("pinCode");
        setIsLoading(false);
      } else if (value.data?.isIZIAuthenticated == false &&
          value.data?.isIZIAuthorized == false) {
        setStep("connect");
        setIsLoading(false);
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
          setStep("finishTransfert");
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
          setStep("finishTransfert");
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
  TransactionSettings get transfertSettings => _transfertSettings;
  GlobalKey<FormState> get formKey => _formKey;
  String get convertedAmount => _convertedAmount;
  bool get isValidForm => _isValidForm;
  bool get isLoading => _isLoading;
  TextEditingController get signinId => _signinId;
  TextEditingController get signinPwd => _signinPwd;
  TextEditingController get pinCode => _pinCode;
  bool get showContact => _showContact;
  bool get permissionDenied => _permissionDenied;
  List<Contact> get contacts => _contacts;
  TextEditingController get phoneController => _phoneController;
  String get suffix => _suffix;
  List<Contact> get filtredContacts => _filtredContacts;
  bool get isValid => _isValid;
  Contact get contactSelected => _contactSelected;
}
