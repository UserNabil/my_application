import 'package:my_taraji/views/fanpay/models/don_model.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../imports.dart';

class RechargeProvider with ChangeNotifier {
  String _step = "recharge";
  String _title = "Recharge";
  final DonSettings _rechargeSettings = DonSettings(
    authorizedAmounts: [
      AuthorizedAmounts(amount: 1000),
      AuthorizedAmounts(amount: 2000),
      AuthorizedAmounts(amount: 5000),
      AuthorizedAmounts(amount: 10000),
      AuthorizedAmounts(amount: 20000),
      AuthorizedAmounts(amount: 50000),
      AuthorizedAmounts(amount: 100000),
      AuthorizedAmounts(amount: 200000),
      AuthorizedAmounts(amount: 500000),
      AuthorizedAmounts(amount: 1000000),
    ],
    isFreeInputAmountActivated: false,
    isMinimumThresholdAmountActive: false,
    minimumThresholdAmount: 0,
    minimumThresholdViloationMessage: "",
    organizationAgentCode: 0,
    isAnonymosContributionActivated: false,
  );
  final TextEditingController _numberController = TextEditingController();
  bool _isTypeRecharge = true;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  DonService donService = DonService();
  bool _isValidForm = false;
  int _selectedRadio = 2;
  String _mask = '#### ##### #### #### ##';
  String _maskHint = '**** ***** **** **** **';
  Icon _icon = const Icon(TablerIcons.ticket, color: Color(0xff256DC1));
  late WebViewController _webViewController;
  bool _showWebView = false;

  void setRechargeTitle(String newTitle) {
    _title = newTitle;
    notifyListeners();
  }

  void setAmount(int amount) {
    _numberController.text = amount.toString();
    notifyListeners();
  }

  void setStep(String newStep) {
    switch (newStep) {
      case "finishRecharge":
        _step = newStep;
        setRechargeTitle("");
        break;
      case "confirmRecharge":
        _step = newStep;
        setRechargeTitle("Confirmer la recharge");
        break;
      case "recharge":
        _step = "recharge";
        setRechargeTitle("Recharge");
        break;
    }
    _step = newStep;

    notifyListeners();
  }

  void setTypeCash(bool newType) {
    _isTypeRecharge = newType;
    notifyListeners();
  }

  void initAllData() {
    _step = "recharge";
    _numberController.text = "";
    _numberController.value = TextEditingValue.empty;
    _isTypeRecharge = true;
    _title = "Recharge";
    _isValidForm = false;
    _formKey.currentState?.reset();
    notifyListeners();
  }

  void setSelectRadio(int value) {
    _selectedRadio = value;
    setMask();
    notifyListeners();
  }

  void setMask() {
    if (_selectedRadio == 2) {
      _mask = '#### ##### #### #### ##';
      _maskHint = '**** ***** **** **** **';
      _icon = const Icon(TablerIcons.ticket, color: Color(0xff256DC1));
    } else {
      _mask = '##### ##### ##### #####';
      _maskHint = '***** ***** ***** *****';
      _icon = const Icon(TablerIcons.credit_card, color: Color(0xff256DC1));
    }
    notifyListeners();
  }

  void setWebViewController(WebViewController controller) {
    _webViewController = controller;
    notifyListeners();
  }

  void setShowWebView(bool value) {
    _showWebView = value;
    notifyListeners();
  }

  void initWebViewController() {
    _webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0xffffffff))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            print("test");
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            // if (request.url.startsWith('https://www.youtube.com/')) {
            //   return NavigationDecision.prevent;
            // }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse('https://forms.office.com/e/Cpe2t2rdJ7'));
    notifyListeners();
  }

  String get step => _step;
  String get title => _title;
  TextEditingController get numberController => _numberController;
  bool get isTypeCash => _isTypeRecharge;
  GlobalKey<FormState>? get formKey => _formKey;
  bool get isValidForm => _isValidForm;
  int get selectedRadio => _selectedRadio;
  String get mask => _mask;
  String get maskHint => _maskHint;
  Icon get icon => _icon;
  bool get isTypeRecharge => _isTypeRecharge;
  DonSettings get rechargeSettings => _rechargeSettings;
  WebViewController get webViewController => _webViewController;
  bool get showWebView => _showWebView;
}
