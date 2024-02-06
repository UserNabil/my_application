import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:my_taraji/core/components/background_top.dart';
import 'package:my_taraji/core/components/custom_card.dart';
import 'package:my_taraji/core/theme/my_color.dart';
import 'package:my_taraji/views/fanzone/components/fanzone_carousel.dart';
import 'package:my_taraji/views/fanzone/components/fanzone_search.dart';

class MyFanZone extends StatelessWidget {
  const MyFanZone({super.key});
  static const routeName = '/fanzone';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: IconButton(
          color: Colors.white,
          icon: const Icon(Icons.arrow_back),
          onPressed: () {},
        ),
        title: const Text(
          "Fanzone",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
            color: Colors.white,
            icon: const Icon(TablerIcons.calendar_time),
            onPressed: () {},
          ),
        ],
      ),
      body: Stack(
        children: [
          const CustomContainer(
            colorTo: MyColors.red,
            colorFrom: MyColors.redDarker,
          ),
          const Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                SizedBox(height: 70),
                Padding(
                  padding: EdgeInsets.only(top: 15),
                  child: CustomCard(
                    svgUrl: '',
                    color: MyColors.yellow,
                    width: 347,
                    height: 237,
                  ),
                ),
              ],
            ),
          ),
          Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.18),
              Stack(
                alignment: Alignment.topCenter,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.82,
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          MyColors.white,
                          MyColors.transparent,
                        ],
                      ),
                      color: MyColors.white,
                      image: DecorationImage(
                        image: AssetImage('images/pngs/map.png'),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50),
                        topRight: Radius.circular(50),
                      ),
                    ),
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(bottom: 120),
                          child: FanzoneCarousel(),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.3,
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.center,
                        end: Alignment.bottomCenter,
                        colors: [
                          MyColors.white,
                          MyColors.white.withOpacity(0.3),
                          const Color.fromARGB(0, 255, 255, 255),
                        ],
                      ),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(50),
                        topRight: Radius.circular(50),
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(
                      top: 20,
                    ),
                    child: FanzoneSearch(),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
