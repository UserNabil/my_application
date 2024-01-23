import '../imports.dart';

class HistoriqueProvider extends ChangeNotifier {
  String _title = 'Historique';

  String get title => _title;

  void setTitle(String title) {
    _title = title;
    notifyListeners();
  }
}
