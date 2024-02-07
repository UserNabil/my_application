import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:intl/intl.dart';
import 'package:my_taraji/services/user_service.dart';
import 'package:my_taraji/views/fanpay/imports.dart';
import 'package:my_taraji/views/fanpay/models/register_izi_model.dart';
import 'package:my_taraji/views/fanpay/models/transaction_response.dart';

class IziProvider with ChangeNotifier {
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _signinId = TextEditingController();
  final TextEditingController _pinCode = TextEditingController();
  final TextEditingController _signinPwd = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _cinController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _sexeController = TextEditingController();
  final TextEditingController _birthDateController = TextEditingController();
  DateTime? _birthDate;
  final TextEditingController _addressController = TextEditingController();
  File? _selfie;
  File? _cinRectoFile;
  File? _cinVersoFile;
  final _formKey = GlobalKey<FormState>();
  bool _isSubmitted = false;
  bool _isValid = false;
  Color _selfiColorInput = MyColors.yellow;
  Color _cinRectoColorInput = MyColors.yellow;
  Color _cinVersoColorInput = MyColors.yellow;
  bool _wallet = false;
  bool _showPassword = false;
  String _connectionStep = "connection";
  bool _isConnectProcissing = false;
  bool _isVerifProcissing = false;
  bool _isProcessing = false;
  int _countVerif = 0;
  bool _wrongVerif = false;
  final UserService userService = UserService();

  void setIsProcessing(bool value) {
    _isProcessing = value;
    notifyListeners();
  }

  void setWrongVerif(bool value) {
    _wrongVerif = value;
    notifyListeners();
  }

  void incrementCountVerif() {
    _countVerif++;
    notifyListeners();
  }

  void setConnectProcissing(bool value) {
    _isConnectProcissing = value;
    notifyListeners();
  }

  void setVerifProcissing(bool value) {
    _isVerifProcissing = value;
    notifyListeners();
  }

  void togglePassword() {
    _showPassword = !_showPassword;
    notifyListeners();
  }

  void checkSelfie() {
    if (_isSubmitted) {
      if (_selfie != null) {
        _selfiColorInput = MyColors.yellow;
      } else {
        _selfiColorInput = MyColors.redLight;
      }
    } else {
      _selfiColorInput = Colors.black54;
    }
    notifyListeners();
  }

  void checkCinRecto() {
    if (_isSubmitted) {
      if (_cinRectoFile != null) {
        _cinRectoColorInput = MyColors.yellow;
      } else {
        _cinRectoColorInput = MyColors.redLight;
      }
    } else {
      _cinRectoColorInput = Colors.black54;
    }
    notifyListeners();
  }

  void checkCinVerso() {
    if (_isSubmitted) {
      if (_cinVersoFile != null) {
        _cinVersoColorInput = MyColors.yellow;
      } else {
        _cinVersoColorInput = MyColors.redLight;
      }
    } else {
      _cinVersoColorInput = Colors.black54;
    }
    notifyListeners();
  }

  void takePicture() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      _selfie = File(pickedFile.path);
      notifyListeners();
    }
    checkSelfie();
  }

  Future<void> importRectoFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      _cinRectoFile = File(result.files.single.path!);
      notifyListeners();
    }
    checkCinRecto();
  }

  Future<void> importVersoFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      _cinVersoFile = File(result.files.single.path!);
      notifyListeners();
    }
    checkCinVerso();
  }

  void setSubmitted() {
    _isSubmitted = true;
    notifyListeners();
  }

  void setValid() {
    if (_selfie == null || _cinRectoFile == null || _cinVersoFile == null) {
      _isValid = false;
    } else {
      _isValid = true;
    }
    notifyListeners();
  }

  Future<TransactionResponse> setConnected() async {
    return userService.authUserIzi(_signinId.text, _signinPwd.text);
  }

  void validateSignInForm(BuildContext context) async {
    if (_formKey.currentState?.validate() ?? false) {
      FocusScope.of(context).unfocus();
      setConnectProcissing(true);
      setConnected().then((value) {
        if (value.isIZIAuthenticated == true &&
            value.isIZIAuthorized == false) {
          _connectionStep = "pinCode";
          notifyListeners();
        } else if (value.isIZIAuthenticated == false &&
            value.isIZIAuthorized == false) {
          _connectionStep = "connection";
          notifyListeners();
        } else if (value.isIZIAuthenticated == true &&
            value.isIZIAuthorized == true) {
          Navigator.pop(context);
          notifyListeners();
        }
        setConnectProcissing(false);
      });
    }
  }

  void setVerif(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    userService.confirmAuthIzi(_pinCode.text).then((value) {
      if (_countVerif < 3) {
        incrementCountVerif();
        if (value) {
          setWrongVerif(!value);
          setVerifProcissing(false);
          _formKey.currentState?.reset();
          init();

          context.read<FanPayProvider>().notifyListeners();
          // Navigator.pop(context);
          Future.delayed(
              const Duration(seconds: 1), () => Navigator.pop(context));
        } else {
          setWrongVerif(!value);
          setVerifProcissing(false);
          _connectionStep = "pinCode";
        }
      } else {
        setVerifProcissing(false);
        prefs.setBool('isIzi', value);
        _formKey.currentState?.reset();
        init();
        Navigator.pop(context);
      }
    });
  }

  void resendCode() {
    setVerifProcissing(true);
    setConnected().then((value) {
      setVerifProcissing(false);
    });
  }

  String formatDate(String date) {
    List<String> dateList = date.split('/');
    String day = dateList[0];
    String month = dateList[1];
    String year = dateList[2];
    return '$year-$month-$day';
  }

  void validateSignUpForm(BuildContext context) async {
    setIsProcessing(true);
    setSubmitted();
    checkSelfie();
    checkCinRecto();
    checkCinVerso();

    if (_formKey.currentState?.validate() ?? false) {
      setValid();
      if (_isValid) {
        RegisterModel register = RegisterModel(
          lastName: _lastNameController.text,
          firstName: _firstNameController.text,
          email: _emailController.text,
          phone: _phoneController.text,
          legalId: _cinController.text,
          gender: int.parse(_sexeController.text),
          birthDate: formatDate(_birthDateController.text),
          address: _addressController.text,
          selfie: _selfie,
          legalIdFront: _cinRectoFile,
          legalIdBack: _cinVersoFile,
        );
        userService.registerIzi(register).then((value) {
          setIsProcessing(false);
          if (value) {
            _wallet = true;
            _formKey.currentState?.reset();
            init();
            Navigator.popAndPushNamed(context, '/');
          } else {
            _wallet = true;
            Navigator.pop(context);
          }
        });
      }
    } else {
      setIsProcessing(false);
    }
    notifyListeners();
  }

  void validateVerifForm(BuildContext context) async {
    if (_formKey.currentState?.validate() ?? false) {
      FocusScope.of(context).unfocus();
      setVerifProcissing(true);
      setVerif(context);
    }
    notifyListeners();
  }

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _birthDate,
      firstDate: DateTime(2015, 8),
      lastDate: DateTime(2101),
    );

    if (picked != null && picked != _birthDate) {
      _birthDate = picked;
      _birthDateController.text = DateFormat('dd/MM/yyyy').format(picked);
      notifyListeners();
    }
  }

  void prefillForm(User? userData) {
    // _lastNameController.text = userData?.pseudo ?? 'Doe';
    // _firstNameController.text = userData?.pseudo ?? 'John';
    _emailController.text = 'test@test.com';
    _phoneController.text = userData?.phone ?? '';
    _sexeController.text = '0';
    _birthDateController.text = DateFormat('dd/MM/yyyy').format(
        DateTime.parse(userData?.birthday ?? '1998-12-22T00:00:00.000Z'));
    _addressController.text = userData?.address?.address ?? '';
    notifyListeners();
  }

  void init() {
    _lastNameController.clear();
    _firstNameController.clear();
    _cinController.clear();
    _emailController.clear();
    _phoneController.clear();
    _sexeController.clear();
    _birthDateController.clear();
    _addressController.clear();
    _selfie = null;
    _cinRectoFile = null;
    _cinVersoFile = null;
    _birthDate = null;
    _isSubmitted = false;
    _isValid = false;
    _formKey.currentState?.reset();
    _pinCode.clear();
    _signinId.clear();
    _signinPwd.clear();
    _connectionStep = "connection";
    _isConnectProcissing = false;
    _isVerifProcissing = false;
    _showPassword = false;
    _countVerif = 0;
    _wrongVerif = false;
    _isProcessing = false;

    _selfiColorInput = Colors.black54;
    _cinRectoColorInput = Colors.black54;
    _cinVersoColorInput = Colors.black54;
    _showPassword = false;

    notifyListeners();
  }

  File? get selfie => _selfie;
  File? get cinRectoFile => _cinRectoFile;
  File? get cinVersoFile => _cinVersoFile;
  GlobalKey<FormState> get formKey => _formKey;
  TextEditingController get lastName => _lastNameController;
  TextEditingController get firstName => _firstNameController;
  TextEditingController get cin => _cinController;
  TextEditingController get email => _emailController;
  TextEditingController get phone => _phoneController;
  TextEditingController get sexe => _sexeController;
  TextEditingController get address => _addressController;
  TextEditingController get birthDate => _birthDateController;
  DateTime? get birthDateValue => _birthDate;
  TextEditingController get signinId => _signinId;
  TextEditingController get signinPwd => _signinPwd;
  bool get isSubmitted => _isSubmitted;
  bool get isValid => _isValid;
  Color get selfiColorInput => _selfiColorInput;
  Color get cinRectoColorInput => _cinRectoColorInput;
  Color get cinVersoColorInput => _cinVersoColorInput;
  bool get wallet => _wallet;
  bool get showPassword => _showPassword;
  TextEditingController get pinCode => _pinCode;
  String get connectionStep => _connectionStep;
  bool get isConnectProcissing => _isConnectProcissing;
  bool get isVerifProcissing => _isVerifProcissing;
  int get countVerif => _countVerif;
  bool get verifIsWrong => _wrongVerif;
  bool get isProcessing => _isProcessing;
}
