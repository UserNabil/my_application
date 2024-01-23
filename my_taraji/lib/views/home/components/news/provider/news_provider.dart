import 'package:my_taraji/views/fanpay/imports.dart';
import 'package:my_taraji/views/home/components/news/models/news_models.dart';

class NewsProvider with ChangeNotifier {
  bool _isShort = false;
  bool _isExpanded = false;

  bool get isShort => _isShort;
  bool get isExpanded => _isExpanded;

  void setIsShort(bool isShort) {
    _isShort = isShort;
    notifyListeners();
  }

  void setIsExpanded(bool isExpanded) {
    _isExpanded = isExpanded;
    notifyListeners();
  }

  void calculateTotalHeight(List<NewsDetailsModel> content) {
    double totalHeight = 0.0;

    for (var newsDetailsModel in content) {
      switch (newsDetailsModel.detailHTML) {
        case 'h1':
          totalHeight += 40.0;
          break;
        case 'h2':
          totalHeight += 30.0;
          break;
        case 'p':
          totalHeight += 20.0;
          break;
        case 'em':
          totalHeight += 20.0;
          break;
        case 'src':
          totalHeight += 200.0;
          break;
        default:
          break;
      }
    }

    _isShort = totalHeight <= 280.0;
  }

  void init() {
    _isShort = false;
    _isExpanded = false;
  }
}
