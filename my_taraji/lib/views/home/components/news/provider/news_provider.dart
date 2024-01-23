import 'package:flutter/material.dart';
import 'package:my_taraji/views/home/components/news/models/news_models.dart';

class NewsProvider with ChangeNotifier {
  bool _isShort = false;
  bool _isExpanded = false;
  double _totalHeight = 0.0;

  bool get isShort => _isShort;
  bool get isExpanded => _isExpanded;
  double get totalHeight => _totalHeight;

  void setIsShort(bool isShort) {
    _isShort = isShort;
    notifyListeners();
  }

  void setIsExpanded(bool isExpanded) {
    _isExpanded = isExpanded;
    notifyListeners();
  }

  void calculateTotalHeight(List<NewsDetailsModel> content) {
    for (var newsDetailsModel in content) {
      switch (newsDetailsModel.detailHTML) {
        case 'h1':
          _totalHeight += 40.0;
          break;
        case 'h2':
          _totalHeight += 30.0;
          break;
        case 'p':
          _totalHeight += 100.0;
          break;
        case 'em':
          _totalHeight += 20.0;
          break;
        case 'src':
          _totalHeight += 200.0;
          break;
        default:
          break;
      }
    }

    notifyListeners();
  }

  void init() {
    _isShort = false;
    _isExpanded = false;
    _totalHeight = 0.0;
    notifyListeners();
  }
}
