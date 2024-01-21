import '../imports.dart';

class FanPayProvider with ChangeNotifier {
  bool _isOpen = false;

  void openModal() {
    _isOpen = !_isOpen;
    notifyListeners();
  }

  bool get isOpen => _isOpen;
}
