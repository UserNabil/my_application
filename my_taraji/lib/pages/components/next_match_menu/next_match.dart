import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:my_taraji/pages/core/my_color.dart';

class TeamCarousel extends StatelessWidget {
  TeamCarousel({super.key, required this.carouselController});
  final CarouselController carouselController;
  final List<MatchData> matchsData = [
    MatchData(
      TeamData('El Taraji', 'images/taraji.png'),
      TeamData('Raja', 'images/raja.jpeg'),
      '12/12/2021',
      '12:00',
    ),
    MatchData(
      TeamData('Setif', 'images/setif.png'),
      TeamData('El Wydad', 'images/wydad.png'),
      '12/12/2021',
      '12:00',
    ),
    MatchData(
      TeamData('El Hilal', 'images/hilal.jpeg'),
      TeamData('Setif', 'images/setif.png'),
      '12/12/2021',
      '12:00',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
          carouselController: carouselController,
          options: CarouselOptions(
            height: 200,
            enlargeCenterPage: true,
            autoPlay: true,
            aspectRatio: 16 / 9,
            autoPlayCurve: Curves.fastOutSlowIn,
            enableInfiniteScroll: true,
            autoPlayAnimationDuration: const Duration(milliseconds: 800),
            viewportFraction: 0.8,
            enlargeFactor: 1,
            enlargeStrategy: CenterPageEnlargeStrategy.zoom,
          ),
          items: matchsData.map((match) {
            return Builder(
              builder: (BuildContext context) {
                return Content(match: match);
              },
            );
          }).toList(),
        ),
      ],
    );
  }
}

class Content extends StatelessWidget {
  const Content({super.key, required this.match});
  final MatchData match;
  final String title = 'CAF Chamions League',
      subTitle = 'NEXT MATCH',
      redirectionPage = 'home';
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.symmetric(vertical: 5.0),
      decoration: const BoxDecoration(
        color: MyColors.transparent,
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SubTitle(subTitle: subTitle),
              Title(title: title),
              SubContent(match: match),
              BuyButton(redirectionPage: redirectionPage)
            ],
          ),
          const Positioned(
            top: 0,
            left: 0,
            child: Image(image: AssetImage('images/football.png'), width: 30),
          ),
        ],
      ),
    );
  }
}

class BuyButton extends StatelessWidget {
  const BuyButton({super.key, required this.redirectionPage});
  final String redirectionPage;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.pushNamed(context, redirectionPage);
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: MyColors.redDarker,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50.0),
        ),
      ),
      child: const Text(
        'Acheter votre Ticket',
        style: TextStyle(
          color: MyColors.white,
          fontSize: 11,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}

class Title extends StatelessWidget {
  const Title({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        color: MyColors.black,
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}

class SubTitle extends StatelessWidget {
  const SubTitle({super.key, required this.subTitle});
  final String subTitle;

  @override
  Widget build(BuildContext context) {
    return Text(
      subTitle,
      style: const TextStyle(
        color: MyColors.yellow,
        fontSize: 11,
        fontWeight: FontWeight.w400,
      ),
    );
  }
}

class SubContent extends StatelessWidget {
  const SubContent({super.key, required this.match});
  final MatchData match;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        MyTeam(team: match.teamOne),
        Padding(
          padding: const EdgeInsets.only(bottom: 30, right: 9, left: 9),
          child: MyVersus(match: match),
        ),
        MyTeam(team: match.teamTwo)
      ],
    );
  }
}

class MyTeam extends StatelessWidget {
  const MyTeam({super.key, required this.team});
  final TeamData team;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image(image: AssetImage(team.logo), width: 60),
        Text(
          team.name,
          style: const TextStyle(
            color: MyColors.black,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        )
      ],
    );
  }
}

class MyVersus extends StatelessWidget {
  const MyVersus({super.key, required this.match});
  final MatchData match;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Image(image: AssetImage('images/versus.png'), width: 30),
        Text(
          match.date,
          style: const TextStyle(
            color: MyColors.black,
            fontSize: 11,
            fontWeight: FontWeight.w400,
          ),
        ),
        Text(
          match.time,
          style: const TextStyle(
            color: MyColors.black,
            fontSize: 11,
            fontWeight: FontWeight.w600,
          ),
        )
      ],
    );
  }
}

class MatchData {
  final TeamData teamOne;
  final TeamData teamTwo;
  final String date;
  final String time;

  MatchData(this.teamOne, this.teamTwo, this.date, this.time);
}

class TeamData {
  final String name;
  final String logo;

  TeamData(this.name, this.logo);
}
