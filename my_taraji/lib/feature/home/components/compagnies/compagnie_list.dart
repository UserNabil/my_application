import 'package:flutter/material.dart';
import 'package:my_taraji/feature/home/components/compagnies/compagnie_card.dart';

class AllCompagnesPage extends StatelessWidget {
  final List<Map<String, String>> compagnes;

  const AllCompagnesPage({Key? key, required this.compagnes}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Toutes les Compagnes'),
      ),
      body: ListView.builder(
        // padding: EdgeInsets.all(40),
        itemCount: compagnes.length,
        itemBuilder: (context, index) {
          final compagnie = compagnes[index];
          return Padding(
            padding: const EdgeInsets.all(20),
            child: CompaignCard(
              context: context,
              compagneName: compagnie['compagneName']!,
              title: compagnie['title']!,
              subtitle: compagnie['subtitle']!,
              imagePath: compagnie['imagePath']!,
              coins: compagnie['coins']!,
              titleFontSize: 15.0,
              subtitleFontSize: 12.0,
              isLister: true,
            ),
          );
        },
      ),
    );
  }
}
