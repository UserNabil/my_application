import '../imports.dart';

class FanPayProvider with ChangeNotifier {
  bool _isOpen = false;
  final ScrollController _scrollController = ScrollController();
  bool _iziAccount = false;

  void openModal() {
    _isOpen = !_isOpen;
    notifyListeners();
  }

  void initPositionScroller() {
    _scrollController.animateTo(
      0.0,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  void setIziAccount(bool value) {
    _iziAccount = value;
    notifyListeners();
  }

  bool get isOpen => _isOpen;
  ScrollController get scroll => _scrollController;
  bool get iziAccount => _iziAccount;
}
