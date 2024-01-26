import 'package:my_taraji/views/home/provider/home_provider.dart';
import 'package:my_taraji/views/init/components/my_profile.dart';
import '../../init/components/my_taraji_logo.dart';
import '../import.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  static const routeName = '/home';

  @override
  Widget build(BuildContext context) {
    List<Widget> widgetsToDisplay = [
      selectContent(context),
      const ListNews(),
      // const ListPartenaire(),
      const SizedBox(height: 150),
    ];
    return Scaffold(
      backgroundColor: MyColors.white,
      extendBodyBehindAppBar: true,
      body: CustomScrollView(
        slivers: <Widget>[
          const SliverAppBar(
            pinned: true,
            snap: false,
            floating: false,
            expandedHeight: 415.0,
            leadingWidth: 180,
            leading: MyTarajiLogo(
              logoImagePath: 'images/pngs/taraji.png',
              firstText: 'My',
              secondText: 'Taraji',
              logoSize: 40,
              textSize: 17,
              textPosition: TextPositionLogo.right,
            ),
            backgroundColor: MyColors.red,
            flexibleSpace: FlexibleSpaceBar(
              background: TopScreen(),
            ),
            actions: [
              Padding(
                padding: EdgeInsets.only(right: 22.0),
                child: MyProfile(
                  greetingText: 'Bonjour',
                  textPosition: TextPositionLogo.left,
                ),
              ),
            ],
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return widgetsToDisplay[index];
              },
              childCount: widgetsToDisplay.length,
            ),
          ),
        ],
      ),
    );
  }

  Widget selectContent(BuildContext context) {
    return FutureBuilder(
      future: context.read<HomeProvider>().loadCampaigns(),
      builder: (context, AsyncSnapshot<AllDataContent> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SizedBox(
            height: 100,
            child: Center(
              child: CircularProgressIndicator(
                color: MyColors.yellow,
              ),
            ),
          );
        }

        AllDataContent allDataContent = snapshot.data!;
        if (allDataContent.campagnes.isNotEmpty &&
            allDataContent.challenges.isNotEmpty) {
          return AllContent(allContent: allDataContent);
        } else {
          return Column(
            children: [
              ListCarouselCompagnes(campagnes: allDataContent.campagnes),
              ListCarouselChallenges(challenges: allDataContent.challenges),
            ],
          );
        }
      },
    );
  }
}
