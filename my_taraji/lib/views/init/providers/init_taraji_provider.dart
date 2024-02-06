import 'package:flutter/material.dart';
import 'package:my_taraji/views/fanpay/views/fanpay/fanpay.dart';
import 'package:my_taraji/views/selfcare/view/self_care_page.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../fanzone/views/fanzone.dart';
import '../../home/page/home_screen.dart';
import '../../shop/page/shop_screen.dart';

class InitProvider with ChangeNotifier {
  int _currentIndex = 0;
  PermissionStatus _statusLocation = PermissionStatus.restricted;
  // PermissionStatus _statusPhoto = PermissionStatus.restricted;
  PermissionStatus _statusCamera = PermissionStatus.restricted;
  // PermissionStatus _statusStorage = PermissionStatus.restricted;

  final List<Widget> _pages = [
    const HomeScreen(),
    const SelfCarePage(),
    const MyFanPay(),
    const MyFanZone(),
    const MyShop(),
  ];

  void setCurrentIndex(int index) {
    if (index != _currentIndex) {
      _currentIndex = index;
    }
    notifyListeners();
  }

  void initCurrentIndex() {
    _currentIndex = 0;
    notifyListeners();
  }

  void initStatusPermissions() async {
    _statusLocation = await Permission.location.request();
    // _statusPhoto = await Permission.photos.request();
    _statusCamera = await Permission.camera.request();
    // _statusStorage = await Permission.storage.request();

    notifyListeners();
  }

  int get currentIndex => _currentIndex;
  List<Widget> get pages => _pages;
  PermissionStatus get status => _statusLocation;
  // PermissionStatus get statusPhoto => _statusPhoto;
  PermissionStatus get statusCamera => _statusCamera;
  // PermissionStatus get statusFile => _statusStorage;
}
