import 'dart:async';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:my_taraji/views/fanzone/components/fanzone_carousel.dart';
import 'package:my_taraji/views/fanzone/model/filter_enum.dart';

class FanzoneProvider with ChangeNotifier {
  final Set<FilterFanzone> _filters = <FilterFanzone>{};
  final Set<Marker> _markers = {};
  late GoogleMapController? _providerController;
  LatLng _initialPosition = const LatLng(36.8, 10.185);
  CameraPosition _kGooglePlex = const CameraPosition(
    target: LatLng(36.8, 10.185),
    zoom: 13,
  );
  static final List<dynamic> _contacts = [
    {
      "name": "Me",
      "position": const LatLng(36, 10),
      "marker": 'images/pngs/marker.png',
      "image": 'images/pngs/avatar.png',
    },
    {
      "name": "Samantha",
      "position": const LatLng(37, 9),
      "marker": 'images/pngs/marker.png',
      "image": 'images/pngs/avatar.png',
    },
    {
      "name": "Malte",
      "position": const LatLng(35, 11),
      "marker": 'images/pngs/marker.png',
      "image": 'images/pngs/avatar.png',
    },
    {
      "name": "Julia",
      "position": const LatLng(36, 10.185),
      "marker": 'images/pngs/marker.png',
      "image": 'images/pngs/avatar.png',
    },
  ];
  static final List<FanZoneModel> _mapData = [
    FanZoneModel(
      imageUrl: 'https://picsum.photos/200',
      location: 'Marseille',
      price: '100 DT',
      position: const LatLng(43.296482, 5.36978),
    ),
    FanZoneModel(
      imageUrl: 'https://picsum.photos/200',
      location: 'Paris',
      price: '1000 DT',
      position: const LatLng(43.296482, 5.36978),
    ),
    FanZoneModel(
      imageUrl: 'https://picsum.photos/200',
      location: 'Cannes',
      price: '2000 DT',
      position: const LatLng(43.296482, 5.36978),
    ),
  ];

  Set<FilterFanzone> get filters => _filters;
  List<FanZoneModel> get mapData => _mapData;
  Set<Marker> get markers => _markers;
  GoogleMapController? get providerController => _providerController;
  LatLng get initialPosition => _initialPosition;
  CameraPosition get kGooglePlex => _kGooglePlex;
  List<dynamic> get contacts => _contacts;

  void setPosition(LatLng position) {
    _initialPosition = position;
    _providerController?.animateCamera(
      CameraUpdate.newLatLng(position),
    );
    _kGooglePlex = CameraPosition(
      target: position,
      zoom: 13,
    );
    notifyListeners();
  }

  void toggleFilter(FilterFanzone filter) {
    if (_filters.contains(filter)) {
      _filters.remove(filter);
    } else {
      _filters.add(filter);
    }
    notifyListeners();
  }

  void setProviderController(GoogleMapController controller) {
    _providerController = controller;
    notifyListeners();
  }

  void createMarkers(BuildContext context) {
    Marker marker;

    Future<BitmapDescriptor> getAssetIcon(
        BuildContext context, String icon) async {
      final Completer<BitmapDescriptor> bitmapIcon =
          Completer<BitmapDescriptor>();
      final ImageConfiguration config =
          createLocalImageConfiguration(context, size: const Size(5, 5));

      AssetImage(icon)
          .resolve(config)
          .addListener(ImageStreamListener((ImageInfo image, bool sync) async {
        final ByteData? bytes =
            await image.image.toByteData(format: ImageByteFormat.png);
        final BitmapDescriptor bitmap =
            BitmapDescriptor.fromBytes(bytes!.buffer.asUint8List());
        bitmapIcon.complete(bitmap);
      }));

      return await bitmapIcon.future;
    }

    _contacts.forEach((contact) async {
      marker = Marker(
        markerId: MarkerId(contact.price),
        position: contact.position,
        icon: await getAssetIcon(context, 'images/pngs/marker.png')
            .then((value) => value),
      );

      _markers.add(marker);
    });
    notifyListeners();
  }

  void moveCamera(CameraUpdate cameraUpdate) {
    _providerController?.animateCamera(cameraUpdate);
  }

  void initController() {
    _providerController?.animateCamera(
      CameraUpdate.newLatLng(_mapData[0].position),
    );
  }
}
