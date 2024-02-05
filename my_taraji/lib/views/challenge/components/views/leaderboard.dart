import 'package:gif_view/gif_view.dart';
import 'package:my_taraji/views/challenge/components/provider/challenge_provider.dart';
import 'package:my_taraji/views/challenge/components/views/components/my_position.dart';

import '../../import.dart';

class LeaderBoardChallenge extends StatelessWidget {
  const LeaderBoardChallenge(
      {super.key, required this.user, required this.challengeId});
  final User? user;
  final String challengeId;

  static ChallengeService challengeService = ChallengeService();
  static LeaderBordResult? loadedLeaderBord;

  Future<LeaderBordResult> loadLeaderBordInfo() async {
    await challengeService
        .getLeaderBordInfoByChallengeId(challengeId)
        .then((value) => loadedLeaderBord = value.data);

    return loadedLeaderBord!;
  }

  String formatCoins(int coins) {
    if (coins >= 1000000000) {
      double billions = coins / 1000000000.0;
      return "${billions.toStringAsFixed(1)}b";
    } else if (coins >= 1000000) {
      double millions = coins / 1000000.0;
      return "${millions.toStringAsFixed(1)}m";
    } else if (coins >= 1000) {
      double thousands = coins / 1000.0;
      return "${thousands.toStringAsFixed(1)}k";
    } else {
      return coins.toString();
    }
  }

  static String userImg =
      'https://e-s-tunis.com/images/news/2023/03/03/1677831592_img.jpg';

  Widget buildTop() {
    int percentage = user?.level?.currentPercentage ?? 0;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              border: Border.all(color: MyColors.white, width: 3),
              color: MyColors.grey,
              borderRadius: BorderRadius.circular(50),
              image: DecorationImage(
                image: NetworkImage(userImg),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Stack(
            alignment: Alignment.center,
            children: [
              SimpleAnimationProgressBar(
                border: Border.all(color: MyColors.white, width: 1),
                height: 30,
                width: 130,
                backgroundColor: const Color(0xFFFFFFFF),
                foregrondColor: MyColors.yellow,
                ratio: percentage / 100,
                direction: Axis.horizontal,
                curve: Curves.fastLinearToSlowEaseIn,
                duration: const Duration(seconds: 3),
                borderRadius: BorderRadius.circular(50),
                gradientColor: const LinearGradient(
                    colors: [MyColors.yellow, MyColors.yellow]),
              ),
              Text(
                "$percentage %",
                style: TextStyle(
                  color: percentage > 63
                      ? MyColors.white
                      : const Color(0xffC1242D),
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          SizedBox(
            width: 50,
            // height: 50,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Coins",
                  style: TextStyle(
                    color: MyColors.white,
                  ),
                ),
                Text(
                  formatCoins(user?.myRewards?.coins ?? 0),
                  style: const TextStyle(
                    color: MyColors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildRouter(BuildContext context) {
    String page = context.watch<ChallengeProvider>().page;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        InkWell(
          borderRadius: BorderRadius.circular(50),
          child: SvgPicture.asset("images/svgs/challenge/previous_page.svg"),
          onTap: () {
            switch (page) {
              case 'step_one':
                context.read<ChallengeProvider>().changePage('leaderboard');
                break;
              case 'step_two':
                context.read<ChallengeProvider>().changePage('step_one');
                break;
              case 'leaderboard':
                Navigator.pop(context);
                break;
              default:
                context.read<ChallengeProvider>().changePage('leaderboard');
            }
          },
        ),
        page == 'leaderboard'
            ? InkWell(
                borderRadius: BorderRadius.circular(50),
                onTap: () {
                  switch (page) {
                    case 'step_one':
                      context.read<ChallengeProvider>().changePage('step_two');
                      break;
                    case 'step_two':
                      context.read<ChallengeProvider>().changePage('step_one');
                      break;
                    case 'leaderboard':
                      context.read<ChallengeProvider>().changePage('step_one');
                      break;
                    default:
                      context
                          .read<ChallengeProvider>()
                          .changePage('leaderboard');
                  }
                },
                child: SvgPicture.asset("images/svgs/challenge/next_page.svg"),
              )
            : const SizedBox(),
      ],
    );
  }

  Widget buildBody(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Container(
        //   margin: const EdgeInsets.only(top: 20, left: 10),
        //   child: const Text(
        //     "Ma position",
        //     style: TextStyle(
        //       color: MyColors.white,
        //       fontSize: 20,
        //       fontWeight: FontWeight.w600,
        //     ),
        //   ),
        // ),
        // MyPosition(
        //   position: 30,
        //   mine: true,
        //   pseudo: user?.pseudo ?? "",
        //   points: user?.myRewards?.coins ?? 0,
        //   image: userImg,
        // ),
        const SizedBox(height: 20),
        Container(
          margin: const EdgeInsets.only(top: 20, left: 10),
          child: const Text(
            "Classement global",
            style: TextStyle(
              color: MyColors.white,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 350,
          child: buildList(),
        )
      ],
    );
  }

  Widget buildList() {
    return FutureBuilder<LeaderBordResult>(
        future: loadLeaderBordInfo(),
        builder: (context, AsyncSnapshot<LeaderBordResult> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: GifView.asset(
                width: 100,
                alignment: Alignment.center,
                'images/gifs/challenge_loader.gif',
                frameRate: 30,
              ),
            );
          }
          if (snapshot.hasError) {
            return const Center(
                child: Text(
              "Aucun autre joueur trouvé.",
              style: TextStyle(color: MyColors.white),
            ));
          }

          return ListView.builder(
            padding: const EdgeInsets.all(0),
            itemCount: loadedLeaderBord?.ranks?.length,
            itemBuilder: (context, index) {
              Rank? rank = loadedLeaderBord?.ranks?[index];
              return MyPosition(
                  position: rank?.rank ?? index,
                  mine: false,
                  pseudo:
                      ("${(rank?.firstName ?? "")}  ${(rank?.lastName ?? "")}"),
                  points: 91934,
                  image: "https://picsum.photos/200/200");
              // image: rank?.imageUrl);
            },
          );
        });
  }

  Widget buildDecoratedBackground(String svg, Widget child) {
    return Stack(alignment: Alignment.center, children: [
      SvgPicture.asset(svg),
      child,
    ]);
  }

  Widget managePage(BuildContext context) {
    switch (context.read<ChallengeProvider>().page) {
      case 'leaderboard':
        return buildBody(context);
      case 'step_one':
        return ChallengeHome(challengeId: challengeId);

      default:
        return buildBody(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [MyColors.red, MyColors.redDarker]),
      ),
      child: buildDecoratedBackground(
        'images/svgs/challenge/bg_challenge.svg',
        Scaffold(
          backgroundColor: MyColors.transparent,
          body: Column(children: [
            buildTop(),
            buildRouter(context),
            managePage(context),
          ]),
        ),
      ),
    );
  }
}
