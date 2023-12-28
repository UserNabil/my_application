import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:my_taraji/core/models/compaign_model.dart';
import 'package:my_taraji/core/theme/my_color.dart';
import 'compagnie_card.dart';
import 'compagnie_list.dart';

class ListCompagnes extends StatefulWidget {
  const ListCompagnes({super.key, required this.compagnes});
  final List<Campaign> compagnes;

  @override
  ListCompagnesState createState() => ListCompagnesState();
}

class ListCompagnesState extends State<ListCompagnes> {
  List<Campaign> _campaigns = [];
  @override
  void initState() {
    super.initState();
    _loadCampaigns();
  }

  void _loadCampaigns() async {
    _saveCampaigns();
    List<Campaign> loadedCampaigns = await getCampaigns();
    setState(() {
      _campaigns = loadedCampaigns;
    });
  }

  void _saveCampaigns() {
    if (widget.compagnes.isEmpty) return;
    saveCampaigns(widget.compagnes);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          color: MyColors.transparent,
          padding: const EdgeInsets.all(15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Campagnes',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 20.0,
                  color: MyColors.yellow,
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AllCompagnesPage(
                        compagnes: _campaigns,
                      ),
                    ),
                  );
                },
                child: const Text(
                  'VOIR TOUS',
                  style: TextStyle(
                    backgroundColor: MyColors.transparent,
                    fontSize: 12.0,
                    fontWeight: FontWeight.w500,
                    color: MyColors.grey,
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.zero,
          child: CarouselSlider(
            options: CarouselOptions(
              height: 195,
              enlargeCenterPage: true,
              autoPlay: true,
              autoPlayInterval: const Duration(milliseconds: 3000),
              enlargeFactor: 0.2,
            ),
            items: [
              for (final newsData in _campaigns)
                CompaignCard(
                  context: context,
                  compagneName: newsData.theme,
                  title: newsData.title,
                  subtitle: newsData.subtitle,
                  imagePath: newsData.imageUri,
                  coins: newsData.score,
                  titleFontSize: 15.0,
                  subtitleFontSize: 12.0,
                  isLister: false,
                ),
            ],
          ),
        ),
      ],
    );
  }
}
