import '../../import.dart';

class AllContentPage extends StatelessWidget {
  const AllContentPage({
    super.key,
    required this.compagnes,
    required this.challenges,
  });

  final List<Campaign> compagnes;
  final List<Challenge> challenges;

  @override
  Widget build(BuildContext context) {
    final List<Widget> allActivities = [
      ...compagnes.map(
        (compagnie) => Padding(
          padding: const EdgeInsets.all(20),
          child: SizedBox(
            height: 195,
            child: CompaignCard(
              context: context,
              campaign: compagnie,
              titleFontSize: 15.0,
              subtitleFontSize: 12.0,
              isLister: true,
            ),
          ),
        ),
      ),
      ...challenges.map(
        (challenge) => Padding(
          padding: const EdgeInsets.all(20),
          child: SizedBox(
            height: 195,
            child: ChallengeCard(
              context: context,
              challengeName: challenge.title,
              title: challenge.title,
              description: challenge.description,
              imageUrl: "images/pngs/challenge1.jpg",
              coins: challenge.title,
              titleFontSize: 13.0,
              subtitleFontSize: 12.0,
              isLister: false,
            ),
          ),
        ),
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Toutes les activités'),
      ),
      body: ListView.builder(
        itemCount: allActivities.length,
        itemBuilder: (context, index) {
          return allActivities[index];
        },
      ),
    );
  }
}
