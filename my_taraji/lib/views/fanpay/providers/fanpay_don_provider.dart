import '../imports.dart';

class DonProvider with ChangeNotifier {
  String _step = "don";
  String _title = "Don";
  final List<String> _amounts = [
    "1.000",
    "5.000",
    "10.000",
    "15.000",
    "25.000"
  ];
  final TextEditingController _amountController = TextEditingController(
    text: "25.000",
  );
  bool _isTypeCash = true;

  void setDonTitle(String newTitle) {
    _title = newTitle;
    notifyListeners();
  }

  void setAmount(String amount) {
    _amountController.text = amount;
    notifyListeners();
  }

  void setStep(String newStep) {
    if (newStep == "confirmDon") {
      setDonTitle("Confirmer don");
    }
    if (newStep == "finishDon") {
      setDonTitle("");
    }
    _step = newStep;
    notifyListeners();
  }

  void setTypeCash(bool newType) {
    _isTypeCash = newType;
    notifyListeners();
  }

  void initAllData() {
    _step = "don";
    _amountController.text = "";
    _isTypeCash = true;
    _title = "Don";
    notifyListeners();
  }

  String get step => _step;
  String get title => _title;
  List<String> get amounts => _amounts;
  TextEditingController get amountController => _amountController;
  bool get isTypeCash => _isTypeCash;
}
