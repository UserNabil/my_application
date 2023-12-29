import 'package:flutter/material.dart';
import 'package:my_taraji/core/theme/my_color.dart';
import 'package:my_taraji/feature/challenge/coin-challenge/pages/step_one_coin_challenge_screen.dart';
import 'package:my_taraji/views/fanpay/page/fanpay_screen.dart';
import 'package:my_taraji/views/fanzone/page/fanzone_screen.dart';
import 'package:my_taraji/views/home/page/home_screen.dart';
import 'package:my_taraji/views/init/components/bottom_bar/bar.dart';
import 'package:my_taraji/views/init/page/init_screen.dart';
import 'package:my_taraji/views/selfcare/page/selfcare_screen.dart';
import 'package:my_taraji/views/shop/page/shop_screen.dart';
import 'package:simple_animation_progress_bar/simple_animation_progress_bar.dart';

void main() {
  runApp(const MaterialApp(
    home: LeaderBord(),
  ));
}

class LeaderBord extends StatefulWidget {
  const LeaderBord({Key? key}) : super(key: key);

  @override
  LeaderBordState createState() => LeaderBordState();
}

class LeaderBordState extends State<LeaderBord> {
  int currentSelectedIndex = 0;
  void updateCurrentIndex(int index) {
    if (index != currentSelectedIndex) {
      setState(() {
        currentSelectedIndex = index;
      });
    }
  }

  final pages = const [
    HomeScreen(),
    MySelfCare(),
    MyFanPay(),
    MyFanZone(),
    MyShop(),
  ];
  final List<Map<String, String>> cardDataList = [
    {
      'backgroundColor': "0xFFC1242D",
      'text1': '1',
      'image1': 'images/pngs/profile.jpg',
      'text2': 'John DOE',
      'image2': 'images/pngs/level.png',
      'text3': '7542',
      'backgroundColorValue': '0xFFFCC213',
      'imageColor': '#FCC213'
    },
    {
      'backgroundColor': "0xFFFCC213",
      'text1': '2',
      'image1': 'images/pngs/profile.jpg',
      'text2': 'Jane SMITH',
      'image2': 'images/pngs/level.png',
      'text3': '8210',
      'backgroundColorValue': '0xFFC1242D',
      'imageColor': '#C1242D'
    },
    {
      'backgroundColor': "0xFFFCC213",
      'text1': '3',
      'image1': 'images/pngs/profile.jpg',
      'text2': 'Jane SMITH',
      'image2': 'images/pngs/level.png',
      'text3': '8210',
      'backgroundColorValue': '0xFFC1242D',
      'imageColor': '#C1242D'
    },
    {
      'backgroundColor': "0xFFFCC213",
      'text1': '4',
      'image1': 'images/pngs/profile.jpg',
      'text2': 'Jane SMITH',
      'image2': 'images/pngs/level.png',
      'text3': '8210',
      'backgroundColorValue': '0xFFC1242D',
      'imageColor': '#C1242D'
    },
    {
      'backgroundColor': "0xFFFCC213",
      'text1': '5',
      'image1': 'images/pngs/profile.jpg',
      'text2': 'Jane SMITH',
      'image2': 'images/pngs/level.png',
      'text3': '8210',
      'backgroundColorValue': '0xFFC1242D',
      'imageColor': '#C1242D'
    },
    {
      'backgroundColor': "0xFFFCC213",
      'text1': '6',
      'image1': 'images/pngs/profile.jpg',
      'text2': 'Jane SMITH',
      'image2': 'images/pngs/level.png',
      'text3': '8210',
      'backgroundColorValue': '0xFFC1242D',
      'imageColor': '#C1242D'
    },
    {
      'backgroundColor': "0xFFFCC213",
      'text1': '7',
      'image1': 'images/pngs/profile.jpg',
      'text2': 'Jane SMITH',
      'image2': 'images/pngs/level.png',
      'text3': '8210',
      'backgroundColorValue': '0xFFC1242D',
      'imageColor': '#C1242D'
    },
    // Add more data as needed
  ];
  Color hexToColor(String code) {
    return Color(int.parse(code.replaceAll('#', '0xFF')));
  }

  Widget buildColoredCard(
    String backgroundColor,
    String text1,
    String image1,
    String text2,
    String image2,
    String text3,
    String backgroundColorValue,
    String imageColor,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: Color(int.parse(backgroundColor)),
        borderRadius: BorderRadius.circular(10.0),
      ),
      padding: const EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                text1,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14.0,
                  fontWeight: FontWeight.normal,
                  decoration: TextDecoration.none,
                ),
              ),
              const SizedBox(width: 10),
              SizedBox(
                height: 40, // Set a fixed height for the image container
                width: 40, // Set a fixed width for the image container
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: Image.asset(
                    image1,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Text(
                text2,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14.0,
                  fontWeight: FontWeight.normal,
                  decoration: TextDecoration.none,
                ),
              ),
              const SizedBox(width: 10),
              SizedBox(
                height: 20, // Set a fixed height for the image container
                width: 20,
                child: ColorFiltered(
                  colorFilter: ColorFilter.mode(
                    hexToColor(
                        imageColor), // Set the desired color (in this case, red)
                    BlendMode.srcIn,
                  ),
                  // Set a fixed width for the image container
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20.0),
                    child: Image.asset(
                      image2,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Container(
                decoration: BoxDecoration(
                  color: Color(int.parse(backgroundColorValue)),
                  borderRadius: BorderRadius.circular(6.0),
                ),
                padding: const EdgeInsets.all(6),
                child: Text(
                  text3,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.none,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: width,
          padding: const EdgeInsets.only(left: 30, right: 30),
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomRight,
              end: Alignment.topLeft,
              colors: [MyColors.redDarker, MyColors.red],
            ),
            borderRadius: BorderRadius.only(
                // topLeft: Radius.circular(50),
                // topRight: Radius.circular(50),
                ),
          ),
          alignment: Alignment.center,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: const EdgeInsets.only(top: 16),
                child: Row(
                  children: [
                    SizedBox(
                      height: 60,
                      child: ClipOval(
                        child: Image.asset(
                          'images/pngs/profile.jpg',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                    SizedBox(
                      width: 150,
                      height: 20,
                      child: Stack(
                        children: [
                          SimpleAnimationProgressBar(
                            height: 20,
                            width: 180,
                            backgroundColor:
                                const Color.fromARGB(255, 220, 220, 220),
                            foregrondColor: MyColors.yellow,
                            ratio: 0.5,
                            direction: Axis.horizontal,
                            curve: Curves.fastLinearToSlowEaseIn,
                            duration: const Duration(seconds: 3),
                            borderRadius: BorderRadius.circular(10),
                            gradientColor: const LinearGradient(colors: [
                              Color.fromARGB(255, 220, 220, 220),
                              MyColors.yellow
                            ]),
                          ),
                          const Positioned(
                            left:
                                50, // Set the left property to the width of the progress bar
                            top: 0,
                            bottom: 0,
                            child: Center(
                              child: Text(
                                '78xp', // Replace with the actual percentage value
                                style: TextStyle(
                                  color: Colors.white, // Choose the text color
                                  fontSize: 10.0, // Choose the font size
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            right:
                                0, // Set the right property to position the black circle at the end
                            top: 0,
                            bottom: 0,
                            child: Center(
                              child: Container(
                                width: 20,
                                height: 20,
                                decoration: const BoxDecoration(
                                  color: Colors.black,
                                  shape: BoxShape.circle,
                                ),
                                child: const Center(
                                  child: Text(
                                    '12',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 10.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 20),
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Coins',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 13.0,
                            fontWeight: FontWeight.normal,
                            decoration: TextDecoration.none,
                          ),
                        ),
                        Text(
                          '9932',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.none,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 5),
              Container(
                margin: const EdgeInsets.only(top: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        // Naviguer vers la page précédente ici
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const InitScreen(),
                          ),
                        );
                      },
                      child: Image.asset(
                        'images/pngs/Presedent.png', // Remplacez par le chemin de votre image
                        fit: BoxFit.cover,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        // Naviguer vers une autre page ici
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const StepOneCoinChallenge(),
                          ),
                        );
                      },
                      child: Image.asset(
                        'images/pngs/Next.png', // Remplacez par le chemin de votre image
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 5),
              const Text(
                'Ma position',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.none,
                ),
              ),
              buildColoredCard(
                  "0xFF000000",
                  '50',
                  'images/pngs/profile.jpg',
                  'Robert FREDDY',
                  'images/pngs/level.png',
                  '9932',
                  '0xFFFCC213',
                  '#FFFFFF'),
              const SizedBox(height: 20),
              const Text(
                'Classement global',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.none,
                ),
              ),
              for (var data in cardDataList)
                Column(
                  children: [
                    buildColoredCard(
                      data['backgroundColor']!,
                      data['text1']!,
                      data['image1']!,
                      data['text2']!,
                      data['image2']!,
                      data['text3']!,
                      data['backgroundColorValue']!,
                      data['imageColor']!,
                    ),
                    const SizedBox(height: 10),
                    // Align(
                    //   alignment: Alignment.bottomCenter,
                    //   child: MyBottomBar(
                    //     active: items[currentSelectedIndex],
                    //     onTap: (item) {
                    //       updateCurrentIndex(item.index);
                    //     },
                    //   ),
                    // ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
