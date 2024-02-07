import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:my_taraji/views/fanzone/provider/fanzone_provider.dart';
import 'package:provider/provider.dart';

class FanZoneModel {
  final String imageUrl;
  final String location;
  final String price;
  final LatLng position;

  FanZoneModel({
    required this.imageUrl,
    required this.location,
    required this.price,
    required this.position,
  });
}

class FanzoneCarousel extends StatelessWidget {
  const FanzoneCarousel({super.key});

  @override
  Widget build(BuildContext context) {
    CarouselController carouselController = CarouselController();
    return CarouselSlider(
      carouselController: carouselController,
      options: CarouselOptions(
        onPageChanged: (index, reason) {
          final provider = context.read<FanzoneProvider>();
          provider.setPosition(provider.mapData[index].position);
        },
        height: 110,
        enlargeCenterPage: false,
        enableInfiniteScroll: true,
        viewportFraction: .9,
      ),
      items: context.watch<FanzoneProvider>().mapData.map((element) {
        return Builder(
          builder: (BuildContext context) {
            return carouselElement(element);
          },
        );
      }).toList(),
    );
  }

  Widget carouselElement(FanZoneModel element) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      decoration: BoxDecoration(
        boxShadow: const [
          BoxShadow(
            color: Color.fromARGB(255, 157, 157, 157),
            blurRadius: 3,
            spreadRadius: .2,
            offset: Offset(0, 0),
          ),
        ],
        border: Border.all(color: const Color(0xffE9E9F2), width: 1),
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 130,
            height: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(element.imageUrl),
                fit: BoxFit.fill,
              ),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                bottomLeft: Radius.circular(10),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                element.location,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                element.price,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
