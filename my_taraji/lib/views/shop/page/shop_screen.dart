import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:my_taraji/core/components/background_top.dart';
import 'package:my_taraji/core/theme/my_color.dart';

class MyShop extends StatelessWidget {
  const MyShop({super.key});
  static const routeName = '/market';
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            leading: IconButton(
              color: Colors.white,
              icon: const Icon(Icons.arrow_back),
              onPressed: () {},
            ),
            title: const Text("Market place",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                )),
            centerTitle: true,
            backgroundColor: Colors.transparent,
            actions: [
              IconButton(
                color: Colors.white,
                icon: const Icon(TablerIcons.shopping_bag),
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
              Column(
                children: [
                  const SizedBox(height: 140),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.7,
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    decoration: const BoxDecoration(
                      color: MyColors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50),
                        topRight: Radius.circular(50),
                      ),
                    ),
                    child: Column(
                      children: [
                        const SizedBox(height: 20),
                        SvgPicture.asset(
                          'images/icons/drag.svg',

                          // ignore: deprecated_member_use
                          color: MyColors.grey,
                          height: 5,
                          width: 5,
                        ),
                        const SizedBox(height: 20),
                        Container(
                          width: 250,
                          height: 50,
                          decoration: ShapeDecoration(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          child: Container(
                            padding: const EdgeInsets.only(left: 20),
                            decoration: ShapeDecoration(
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15)),
                              shadows: const [
                                BoxShadow(
                                  color: Color(0x3F000000),
                                  blurRadius: 5,
                                  offset: Offset(0, 0),
                                  spreadRadius: 0,
                                )
                              ],
                            ),
                            child: const Row(
                              children: [
                                Icon(
                                  TablerIcons.search,
                                  color: MyColors.red,
                                ),
                                SizedBox(width: 10),
                                Text(
                                  "Rechercher",
                                  style: TextStyle(
                                      color: MyColors.red,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          height: 430,
                          child: GridView.builder(
                            padding: const EdgeInsets.only(top: 20),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 20.0,
                              mainAxisSpacing: 20.0,
                            ),
                            itemCount: 10,
                            itemBuilder: (BuildContext context, int index) {
                              return Center(child: item());
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ],
          ),
        ),
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
          child: const SizedBox(),
        ),
        const Center(
          child: Text(
            "Coming soon...",
            style: TextStyle(
              color: MyColors.white,
              fontSize: 20,
              fontWeight: FontWeight.w500,
              shadows: [
                Shadow(
                  blurRadius: 20.0,
                  color: MyColors.black,
                  offset: Offset(0, 0),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget item() {
    return Container(
      width: 133,
      height: 159,
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        shadows: const [
          BoxShadow(
            color: Color(0x3F000000),
            blurRadius: 10,
            offset: Offset(0, 0),
            spreadRadius: 0,
          )
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            left: 0,
            top: 0,
            child: Container(
              width: 133,
              height: 159,
              decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
              ),
            ),
          ),
          const Positioned(
            left: 12.02,
            top: 113.03,
            child: SizedBox(
              width: 108.95,
              height: 15.07,
              child: Text(
                'Tickets',
                style: TextStyle(
                  color: Color(0xFF265BAA),
                  fontSize: 15,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w700,
                  height: 0,
                ),
              ),
            ),
          ),
          const Positioned(
            left: 101.45,
            top: 135.64,
            child: Text(
              '(56)',
              style: TextStyle(
                color: Color(0x7F265BAA),
                fontSize: 12,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w400,
                height: 0,
              ),
            ),
          ),
          Positioned(
            left: 0,
            top: 0,
            child: Container(
              width: 133,
              height: 105.50,
              decoration: const ShapeDecoration(
                image: DecorationImage(
                  image: NetworkImage("https://via.placeholder.com/133x105"),
                  fit: BoxFit.contain,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8),
                    topRight: Radius.circular(8),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
