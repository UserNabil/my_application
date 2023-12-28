import 'package:flutter/material.dart';
import 'package:my_taraji/views/home/components/campagnies/compagnie_card.dart';
import 'package:my_taraji/core/models/compaign_model.dart';

class AllCompagnesPage extends StatelessWidget {
  final List<Campaign> compagnes;

  const AllCompagnesPage({Key? key, required this.compagnes}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Toutes les Campagnes'),
      ),
      body: ListView.builder(
        itemCount: compagnes.length,
        itemBuilder: (context, index) {
          final compagnie = compagnes[index];
          return Padding(
            padding: const EdgeInsets.all(20),
            child: SizedBox(
                height: 195,
                child: CompaignCard(
                  context: context,
                  compagneName: compagnie.theme,
                  title: compagnie.title,
                  subtitle: compagnie.subtitle,
                  imagePath: compagnie.imageUri,
                  coins: compagnie.score,
                  titleFontSize: 15.0,
                  subtitleFontSize: 12.0,
                  isLister: true,
                )),
          );
        },
      ),
    );
  }
}
