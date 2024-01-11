import 'package:flutter/material.dart';
import 'package:my_taraji/core/theme/my_color.dart';
import 'package:my_taraji/views/challenge/components/question_one_challenge_screen.dart';

// void main() {
//   runApp(const MaterialApp(
//     home: ResponseQuestionChallenge(
//       stepid: "659564607428f60708a9be76",
//       challengeid: "",
//       textQuestion: "Question 1",
//       message: "Bien Joué !",
//       image: AssetImage('images/pngs/Check.png'), // Remplacez par votre image
//       description: "Vous avez gagné",
//     ),
//   ));
// }

class ResponseQuestionChallenge extends StatelessWidget {
  final bool laststep;
  final String challengeid;
  final String stepid;
  final int questionnumber;
  final String textQuestion;
  final String message;
  final ImageProvider<Object> image;
  final String description;

  // ignore: use_super_parameters
  const ResponseQuestionChallenge({
    Key? key,
    required this.laststep,
    required this.challengeid,
    required this.stepid,
    required this.questionnumber,
    required this.textQuestion,
    required this.message,
    required this.image,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
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
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 50),
                      // Premier conteneur avec le texte de la question
                      Container(
                        margin: const EdgeInsets.all(16.0),
                        child: Text(
                          textQuestion,
                          style: const TextStyle(
                            fontSize: 17.0,
                            fontWeight: FontWeight.normal,
                            color: MyColors.white,
                          ),
                        ),
                      ),
                      // Deuxième conteneur avec les trois lignes
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
                              const SizedBox(height: 10),
                              // Deuxième ligne : image
                              Container(
                                margin:
                                    const EdgeInsets.symmetric(vertical: 10.0),
                                height: 120.0,
                                width: 140.0,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: image,
                                    fit: BoxFit.cover,
                                  ),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                              ),
                              const SizedBox(height: 20),
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
                      const SizedBox(height: 100),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => QuestionOneCoinChallenge(
                                    laststep,
                                    stepid,
                                    questionnumber,
                                    challengeid)),
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
                          'Question suivante',
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
            ),
          ],
        ),
      ),
    );
  }
}
