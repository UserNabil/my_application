import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class FanZoneElement {
  final String imageUrl;
  final String location;
  final String price;

  FanZoneElement({
    required this.imageUrl,
    required this.location,
    required this.price,
  });
}

class FanzoneCarousel extends StatelessWidget {
  const FanzoneCarousel({super.key});

  @override
  Widget build(BuildContext context) {
    List<FanZoneElement> mapData = [
      FanZoneElement(
        imageUrl: 'https://picsum.photos/200',
        location: 'Marseille',
        price: '100 DT',
      ),
      FanZoneElement(
        imageUrl: 'https://picsum.photos/200',
        location: 'Paris',
        price: '1000 DT',
      ),
      FanZoneElement(
        imageUrl: 'https://picsum.photos/200',
        location: 'Cannes',
        price: '2000 DT',
      ),
    ];
    CarouselController carouselController = CarouselController();
    return CarouselSlider(
      carouselController: carouselController,
      options: CarouselOptions(
        height: 110,
        enlargeCenterPage: false,
        enableInfiniteScroll: true,
        viewportFraction: .9,
      ),
      items: mapData.map((element) {
        return Builder(
          builder: (BuildContext context) {
            return carouselElement(element);
          },
        );
      }).toList(),
    );
  }

  Widget carouselElement(FanZoneElement element) {
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
