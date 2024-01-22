import 'package:my_taraji/views/init/components/my_card.dart';
import 'package:my_taraji/views/init/components/my_profile.dart';
import '../../init/components/my_taraji_logo.dart';
import '../import.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static const routeName = '/home';

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    int myIndex = 1;
    List<Widget> widgetsToDisplay = [
      selectContent(context),
      const ListNews(),
      const ListPartenaire(),
    ];
    return Scaffold(
      extendBodyBehindAppBar: true,
      // appBar: AppBar(
      //   elevation: 0,
      //   leadingWidth: 180,
      //   leading: const MyTarajiLogo(
      //     logoImagePath: 'images/pngs/taraji.png',
      //     firstText: 'My',
      //     secondText: 'Taraji',
      //     logoSize: 40,
      //     textSize: 17,
      //     textPosition: TextPositionLogo.right,
      //   ),
      //   backgroundColor: MyColors.transparent,
      //   actions: const [
      //     Padding(
      //       padding: EdgeInsets.only(right: 22.0),
      //       child: MyProfile(
      //         greetingText: 'Bonjour',
      //         textPosition: TextPositionLogo.left,
      //       ),
      //     ),
      //   ],
      // ),
      body: CustomScrollView(
        slivers: <Widget>[
          const SliverAppBar(
            pinned: true,
            snap: false,
            floating: false,
            expandedHeight: 405.0,
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
          // const SliverToBoxAdapter(
          //   child: TopScreen(),
          // ),
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
      // Column(
      //   crossAxisAlignment: CrossAxisAlignment.stretch,
      //   children: [
      //     const TopScreen(),
      //     Expanded(
      //       child: ListView.builder(
      //         itemCount: widgetsToDisplay.length,
      //         itemBuilder: (context, index) {
      //           return widgetsToDisplay[index];
      //         },
      //       ),
      //     ),
      //   ],
      // ),
    );
  }

  Widget selectContent(BuildContext context) {
    LocalService localService = LocalService();
    return FutureBuilder(
      future: localService.loadCampaigns(),
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

        if (snapshot.hasError) {
          return SizedBox(
            height: 100,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: MyColors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                    onPressed: () {
                      setState(() {});
                    },
                    child: const Icon(
                      TablerIcons.refresh,
                      color: MyColors.red,
                    ),
                  ),
                ],
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
