import 'package:gif_view/gif_view.dart';
import 'package:my_taraji/views/challenge/components/provider/challenge_provider.dart';

import '../import.dart';

class ChallengeHome extends StatelessWidget {
  const ChallengeHome({super.key, required this.challengeId});
  final String challengeId;

  Widget buildContent(BuildContext context, ChallengeStep? step) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.topCenter,
          children: [
            const SizedBox(width: double.infinity, height: 600),
            Container(
              height: 300,
              width: double.infinity,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("images/pngs/challenge/player2.png"),
                  fit: BoxFit.fitHeight,
                ),
              ),
            ),
            Positioned(
              top: 250,
              child: SvgPicture.asset(
                  "images/svgs/challenge/challenge_white_bg.svg"),
            ),
            Positioned(
                bottom: 40,
                child: InkWell(
                  onTap: () {
                    _showPopup(context);
                  },
                  child: SvgPicture.asset("images/svgs/challenge/info.svg",
                      width: 200),
                )),
            Positioned(
              width: 300,
              bottom: 220,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      context.watch<ChallengeProvider>().currentstep?.title ??
                          "Loading...",
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      textAlign: TextAlign.center,
                      "Vous pouvez gagner jusqu'à ${context.watch<ChallengeProvider>().currentstep?.stepTotal} points",
                      style: const TextStyle(
                        color: MyColors.red,
                        fontSize: 20,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 25,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => QuestionOneCoinChallenge(
                        context.watch<ChallengeProvider>().laststep,
                        step?.id ?? "",
                        step?.questionNumber ?? 0,
                        challengeId,
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  fixedSize: const Size(200, 50),
                  backgroundColor: MyColors.yellow,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  side: const BorderSide(color: Colors.white, width: 1.0),
                ),
                child: const Text(
                  'Démarrer',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                  ),
                ),
              ),
            )
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ChallengeStep?>(
      future: context.read<ChallengeProvider>().loadChallenge(challengeId),
      builder: (context, AsyncSnapshot<ChallengeStep?> snapshot) {
        if (snapshot.hasError) {
          return const Center(
            child: Text("Error"),
          );
        }
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
        ChallengeStep? step = snapshot.data;

        return buildContent(context, step);
      },
    );
  }

  void _showPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          actionsAlignment: MainAxisAlignment.center,
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                fixedSize: const Size(200, 50),
                backgroundColor: MyColors.red,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
                side: const BorderSide(color: Colors.white, width: 3.0),
              ),
              child: const Text(
                'Compris',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                ),
              ),
            )
          ],
          contentPadding: const EdgeInsets.all(20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(22.0),
            side: const BorderSide(color: Colors.white, width: 3.0),
          ),
          backgroundColor: MyColors.yellow,
          content: SizedBox(
            width: 150,
            height: 220,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RichText(
                  text: const TextSpan(
                    style: TextStyle(
                      fontSize: 18.0,
                      color: MyColors.red,
                      fontWeight: FontWeight.w600,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: 'EL Taraji Quiz',
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      TextSpan(
                        text:
                            " est un jeu dynamique sur l'actualité footballistique mondiale et le club tunisien El Taraji. \n\nTestez vos connaissances, défiez d'autres fans etremportez des prix!",
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
