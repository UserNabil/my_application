import 'package:flutter/Material.dart';
import 'package:my_taraji/views/selfcare/models/pages_enum.dart';

class SelfCareProvider with ChangeNotifier {
  PageViewEnum _page = PageViewEnum.selfcare;
  void switchPage(PageViewEnum value) {
    _page = value;
    notifyListeners();
  }

  PageViewEnum get page => _page;
}
