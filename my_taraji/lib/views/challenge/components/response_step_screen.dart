import 'package:my_taraji/views/challenge/components/stars_result.dart';
import 'package:my_taraji/views/challenge/components/step_one_coin_challenge_screen.dart';
import 'package:my_taraji/views/fanpay/imports.dart';

class ResponseStepChallenge extends StatelessWidget {
  final String challengeid;
  final String message;
  final ImageProvider<Object> image;
  final String description;
  static String profileImagePath =
      'https://e-s-tunis.com/images/news/2023/03/03/1677831592_img.jpg';

  const ResponseStepChallenge({
    super.key,
    required this.challengeid,
    required this.message,
    required this.image,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: context.read<HomeProvider>().getUserData(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Container();
        }

        if (snapshot.connectionState == ConnectionState.waiting) {}

        User userData = snapshot.data!;
        return buildContent(context, userData);
      },
    );
  }

  Widget buildContent(BuildContext context, User userData) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomRight,
            end: Alignment.topLeft,
            colors: [MyColors.redDarker, MyColors.red],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(top: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            child: ClipOval(
                              child: Image(
                                image: NetworkImage(profileImagePath),
                                fit: BoxFit.cover,
                                width: 60.0,
                                height: 60.0,
                              ),
                            ),
                          ),
                          const SizedBox(width: 20),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Coins',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 13.0,
                                  fontWeight: FontWeight.normal,
                                  decoration: TextDecoration.none,
                                ),
                              ),
                              Text(
                                userData.myRewards?.coins.toString() ?? '0',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.none,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      margin: const EdgeInsets.all(16.0),
                      padding: const EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // Première ligne : message
                            Text(
                              message,
                              style: const TextStyle(
                                fontSize: 22.0,
                                fontWeight: FontWeight.bold,
                                color: MyColors.white,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 40),
                            // Deuxième ligne : image
                            Container(
                              margin:
                                  const EdgeInsets.symmetric(vertical: 10.0),
                              height: 100.0,
                              width: 200.0,
                              // decoration: BoxDecoration(
                              //   image: DecorationImage(
                              //     image: image,
                              //     fit: BoxFit.cover,
                              //   ),
                              //   borderRadius: BorderRadius.circular(8.0),
                              // ),
                              child: const StarsResult(),
                            ),
                            const SizedBox(height: 30),
                            // Troisième ligne : description
                            Text(
                              description,
                              style: const TextStyle(
                                fontSize: 17.0,
                                fontWeight: FontWeight.normal,
                                color: MyColors.white,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 110),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                StepOneCoinChallenge(challengeId: challengeid),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        fixedSize: const Size(280, 40),
                        backgroundColor: MyColors.yellow,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      child: const Text(
                        'Niveau suivant',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 14.0,
                            fontWeight: FontWeight.normal),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
