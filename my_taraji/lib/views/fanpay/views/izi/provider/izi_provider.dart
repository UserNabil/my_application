import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:intl/intl.dart';
import 'package:my_taraji/services/user_service.dart';
import 'package:my_taraji/views/fanpay/imports.dart';
import 'package:my_taraji/views/fanpay/models/transaction_response.dart';
import 'package:my_taraji/views/init/providers/init_taraji_provider.dart';

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
  Color _selfiColorInput = Colors.black54;
  Color _cinRectoColorInput = Colors.black54;
  Color _cinVersoColorInput = Colors.black54;
  bool _wallet = true;
  bool _showPassword = false;
  String _connectionStep = "connection";
  bool _isConnectProcissing = false;
  bool _isVerifProcissing = false;
  int _countVerif = 0;
  bool _wrongVerif = false;

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
        _selfiColorInput = MyColors.iziBlue;
      } else {
        _selfiColorInput = MyColors.iziOrange;
      }
    } else {
      _selfiColorInput = Colors.black54;
    }
    notifyListeners();
  }

  void checkCinRecto() {
    if (_isSubmitted) {
      if (_cinRectoFile != null) {
        _cinRectoColorInput = MyColors.iziBlue;
      } else {
        _cinRectoColorInput = MyColors.iziOrange;
      }
    } else {
      _cinRectoColorInput = Colors.black54;
    }
    notifyListeners();
  }

  void checkCinVerso() {
    if (_isSubmitted) {
      if (_cinVersoFile != null) {
        _cinVersoColorInput = MyColors.iziBlue;
      } else {
        _cinVersoColorInput = MyColors.iziOrange;
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
    UserService userService = UserService();
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

  // review here
  void setVerif(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    UserService userService = UserService();
    userService.confirmAuthIzi(_pinCode.text).then((value) {
      if (_countVerif < 3) {
        incrementCountVerif();
        if (value) {
          setWrongVerif(!value);
          setVerifProcissing(false);
          _formKey.currentState?.reset();
          init();
          Navigator.pop(context);
          context.read<InitProvider>().setCurrentIndex(2);
          notifyListeners();
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

  void validateSignUpForm(BuildContext context) async {
    setSubmitted();
    checkSelfie();
    checkCinRecto();
    checkCinVerso();
    if (_formKey.currentState?.validate() ?? false) {
      setValid();
      if (_isValid) {
        Future.delayed(const Duration(seconds: 2), () {
          _formKey.currentState?.reset();
          init();
          _wallet = true;
          Navigator.pop(context);
        });
      }
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
    _lastNameController.text = userData?.pseudo ?? 'Doe';
    _firstNameController.text = userData?.pseudo ?? 'John';
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
}
