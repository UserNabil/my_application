import 'package:my_taraji/views/challenge/components/stars_result.dart';
import 'package:my_taraji/views/fanpay/imports.dart';
import 'package:my_taraji/views/init/page/init_screen.dart';

class ResponseLastStepChallenge extends StatelessWidget {
  final String message;
  final String image;
  final String description;

  const ResponseLastStepChallenge({
    super.key,
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
        User user = snapshot.data as User;
        return buildContent(context, user);
      },
    );
  }

  Widget buildContent(BuildContext context, User user) {
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
                          const SizedBox(
                            child: ClipOval(
                              child: Image(
                                image: NetworkImage(
                                    'https://e-s-tunis.com/images/news/2023/03/03/1677831592_img.jpg'),
                                fit: BoxFit.cover,
                                width: 60.0,
                                height: 60.0,
                              ),
                            ),
                          ),
                          const SizedBox(width: 20),
                          // Expanded(
                          //   child: SizedBox(
                          //     height: 20,
                          //     child: Stack(
                          //       children: [
                          //         SimpleAnimationProgressBar(
                          //           height: 20,
                          //           width: MediaQuery.of(context).size.width *
                          //               0.8, // Utilisation de 80% de la largeur de l'écran
                          //           backgroundColor: const Color.fromARGB(
                          //               255, 220, 220, 220),
                          //           foregrondColor: MyColors.yellow,
                          //           ratio: 0.3,
                          //           direction: Axis.horizontal,
                          //           curve: Curves.fastLinearToSlowEaseIn,
                          //           duration: const Duration(seconds: 3),
                          //           borderRadius: BorderRadius.circular(10),
                          //           gradientColor: const LinearGradient(
                          //               colors: [
                          //                 Color.fromARGB(255, 220, 220, 220),
                          //                 MyColors.yellow
                          //               ]),
                          //         ),
                          //         Positioned(
                          //           left: MediaQuery.of(context).size.width *
                          //                   0.4 -
                          //               (0.4 *
                          //                   MediaQuery.of(context).size.width *
                          //                   0.5), // Ajustement pour centrer le texte par rapport à la barre de progression
                          //           top: 0,
                          //           bottom: 0,
                          //           child: Center(
                          //             child: Text(
                          //               "${xp}xp",
                          //               style: const TextStyle(
                          //                 color: Colors.white,
                          //                 fontSize: 10.0,
                          //                 fontWeight: FontWeight.bold,
                          //               ),
                          //             ),
                          //           ),
                          //         ),
                          //         Positioned(
                          //           right: 0,
                          //           top: 0,
                          //           bottom: 0,
                          //           child: Center(
                          //             child: Container(
                          //               width: 20,
                          //               height: 20,
                          //               decoration: const BoxDecoration(
                          //                 color: Colors.black,
                          //                 shape: BoxShape.circle,
                          //               ),
                          //               child: const Center(
                          //                 child: Text(
                          //                   '12',
                          //                   style: TextStyle(
                          //                     color: Colors.white,
                          //                     fontSize: 10.0,
                          //                     fontWeight: FontWeight.bold,
                          //                   ),
                          //                 ),
                          //               ),
                          //             ),
                          //           ),
                          //         ),
                          //       ],
                          //     ),
                          //   ),
                          // ),
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
                                user.myRewards?.coins.toString() ?? '0',
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

                              child: const StarsResult(),
                              // child: Image.asset(
                              //   image,
                              // ),
                            ),
                            // Container(
                            //   margin:
                            //       const EdgeInsets.symmetric(vertical: 10.0),
                            //   height: 50.0,
                            //   width: 80.0,
                            //   decoration: BoxDecoration(
                            //     image: DecorationImage(
                            //       image: image,
                            //       fit: BoxFit.cover,
                            //     ),
                            //     borderRadius: BorderRadius.circular(8.0),
                            //   ),
                            // ),
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
                            builder: (context) => const InitScreen(),
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
                        'Quitter',
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
