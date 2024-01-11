import '../../import.dart';

class AllCompagnesPage extends StatelessWidget {
  final List<Campaign> compagnes;

  const AllCompagnesPage({super.key, required this.compagnes});

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
                  campaign: compagnie,
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
