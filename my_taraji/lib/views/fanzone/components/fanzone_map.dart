// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:my_taraji/views/fanzone/provider/fanzone_provider.dart';
// import 'package:provider/provider.dart';

// class FanzoneMap extends StatelessWidget {
//   const FanzoneMap({super.key});
//   static late GoogleMapController providerController;
//   static LatLng initialPosition = const LatLng(36.8, 10.185);
//   static CameraPosition kGooglePlex = const CameraPosition(
//     target: LatLng(36.8, 10.185),
//     zoom: 13,
//   );

//   @override
//   Widget build(BuildContext context) {
//     context.read<FanzoneProvider>().createMarkers(context);

//     return Column(
//       children: [
//         SizedBox(
//           height: MediaQuery.of(context).size.height * 0.1,
//         ),
//         SizedBox(
//           height: MediaQuery.of(context).size.height * 0.72,
//           child:
//               // GoogleMap(
//               //   rotateGesturesEnabled: false,
//               //   zoomControlsEnabled: false,
//               //   mapType: MapType.terrain,
//               //   initialCameraPosition: kGooglePlex,
//               //   markers: context.watch<FanzoneProvider>().markers,
//               //   myLocationButtonEnabled: false,
//               //   onMapCreated: (GoogleMapController controller) {
//               //     providerController = controller;
//               //   },
//               // ),
//               Stack(
//             children: [
//               GoogleMap(
//                 initialCameraPosition: kGooglePlex,
//                 markers: context.watch<FanzoneProvider>().markers,
//                 myLocationButtonEnabled: false,
//                 onMapCreated: (GoogleMapController controller) {
//                   providerController = controller;
//                 },
//               ),
//               Positioned(
//                 bottom: 50,
//                 left: 20,
//                 right: 20,
//                 child: Container(
//                     width: MediaQuery.of(context).size.width,
//                     height: 120,
//                     decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(20)),
//                     child: ListView.builder(
//                       scrollDirection: Axis.horizontal,
//                       itemCount:
//                           context.watch<FanzoneProvider>().contacts.length,
//                       itemBuilder: (context, index) {
//                         return GestureDetector(
//                           onTap: () {
//                             providerController.moveCamera(
//                                 CameraUpdate.newLatLng(context
//                                     .watch<FanzoneProvider>()
//                                     .contacts[index]["position"]));
//                           },
//                           child: Container(
//                             width: 100,
//                             height: 100,
//                             margin: const EdgeInsets.only(right: 10),
//                             child: Column(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 Image.asset(
//                                   context
//                                       .watch<FanzoneProvider>()
//                                       .contacts[index]['image'],
//                                   width: 60,
//                                 ),
//                                 const SizedBox(
//                                   height: 10,
//                                 ),
//                                 Text(
//                                   context
//                                       .watch<FanzoneProvider>()
//                                       .contacts[index]["name"],
//                                   style: const TextStyle(
//                                       color: Colors.black,
//                                       fontWeight: FontWeight.w600),
//                                 )
//                               ],
//                             ),
//                           ),
//                         );
//                       },
//                     )),
//               )
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }

// ignore_for_file: avoid_function_literals_in_foreach_calls

import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class FanzoneMap extends StatefulWidget {
  const FanzoneMap({Key? key}) : super(key: key);

  @override
  FanzoneMapState createState() => FanzoneMapState();
}

class FanzoneMapState extends State<FanzoneMap> {
  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  List<Marker> markers = [
    const Marker(
      markerId: MarkerId('initialMarker'),
      position: LatLng(37.42796133580664, -122.085749655962),
      infoWindow: InfoWindow(
        title: 'Initial Marker',
        snippet: 'This is the initial marker.',
      ),
    ),
  ];
  late GoogleMapController mapController;

  List<dynamic> contacts = [
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

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    createMarkers(context);

    return Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.1,
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.72,
          child: GoogleMap(
            initialCameraPosition: _kGooglePlex,
            // circles: Set.from([
            //   Circle(
            //     circleId: CircleId('circle'),
            //     center: LatLng(36.8, 10.185),
            //     radius: 1000,
            //     fillColor: Colors.blue.withOpacity(0.1),
            //     strokeWidth: 0,
            //   )
            // ]),
            markers: Set.from(markers),
            myLocationButtonEnabled: false,
            onMapCreated: (GoogleMapController controller) =>
                mapController = controller,
          ),
        ),
      ],
    );

    // return GoogleMap(
    //   initialCameraPosition: _kGooglePlex,
    //   // markers: markers,
    //   myLocationButtonEnabled: false,
    //   onMapCreated: (GoogleMapController controller) =>
    //       mapController = controller,
    // );

    // return Scaffold(
    //     body: Stack(
    //   children: [
    //     // GoogleMap(
    //     //   initialCameraPosition: _kGooglePlex,
    //     //   markers: markers,
    //     //   myLocationButtonEnabled: false,
    //     //   onMapCreated: (GoogleMapController controller) {
    //     //     mapController = controller;
    //     //   },
    //     // ),
    //     const Positioned(
    //       bottom: 120,
    //       child: FanzoneCarousel(),
    //     )
    //   ],
    // ));
  }

  createMarkers(BuildContext context) {
    Marker marker;

    contacts.forEach((contact) async {
      marker = Marker(
        markerId: MarkerId(contact['name']),
        position: contact['position'],
        icon: await _getAssetIcon(context, contact['marker'])
            .then((value) => value),
        infoWindow: InfoWindow(
          title: contact['name'],
          snippet: 'Street 6 . 2min ago',
        ),
      );

      setState(() {
        markers.add(marker);
      });
    });
  }

  Future<BitmapDescriptor> _getAssetIcon(
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
}
