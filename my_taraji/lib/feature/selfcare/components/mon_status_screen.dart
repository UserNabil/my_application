import 'package:flutter/material.dart';
import '../../../core/theme/my_color.dart';

void main() {
  runApp(const MaterialApp(
    home: MonStatusScreen(),
  ));
}

class MonStatusScreen extends StatefulWidget {
  const MonStatusScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _MonStatusScreenState createState() => _MonStatusScreenState();
}

class _MonStatusScreenState extends State<MonStatusScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          color: Colors.white,
          padding: const EdgeInsets.only(top: 9.0, left: 15.0, bottom: 15.0),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Mon Status',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                  color: MyColors.black,
                ),
              )
            ],
          ),
        ),
        // Container 1
        Container(
          margin: const EdgeInsets.all(8.0),
          padding: const EdgeInsets.only(
              right: 16.0, left: 16.0, top: 0.0, bottom: 16.0),
          color: Colors.white,
          child: Row(
            children: [
              // Image
              ClipOval(
                child: Image.asset(
                  'images/user.png',
                  fit: BoxFit.cover,
                  width: 60.0, // Adjust the width as needed
                  height: 60.0, // Adjust the height as needed
                ),
              ),
              const SizedBox(width: 13.0),
              // Text
              const Column(
                children: [
                  Text('Alise Ramond',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  SizedBox(height: 15.0),
                  Text('+216 20 789 245'),
                ],
              ),
              const SizedBox(width: 13.0),
              // Text
              const Column(
                children: [
                  Text('605 Coins', style: TextStyle(color: Colors.green)),
                  SizedBox(height: 15.0),
                  Text('Silver', style: TextStyle(color: MyColors.red)),
                ],
              ),
            ],
          ),
        ),
        // Container 2
        Container(
          margin: const EdgeInsets.all(8.0),
          padding: const EdgeInsets.only(
              left: 16.0, right: 16.0, top: 0.0, bottom: 16.0),
          color: Colors.white,
          child: Row(
            children: [
              // Image
              Image.asset('images/trophesilver.png', fit: BoxFit.cover),
              // Progress Bar
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Column 1
                  const Padding(
                    padding: EdgeInsets.only(
                        right: 0.0), // Ajuster la marge à droite
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('605', style: TextStyle(fontSize: 9.0)),
                        SizedBox(height: 10.0),
                        Text('65%', style: TextStyle(fontSize: 9.0)),
                      ],
                    ),
                  ),

                  // Progress Bar
                  Container(
                    padding: const EdgeInsets.only(right: 2.0),
                    width: 180.0,
                    height: 10.0,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(
                          5.0), // Ajustez le rayon pour définir le degré d'arrondi
                      child: Container(
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              MyColors.yellow,
                              Color.fromARGB(255, 245, 243, 227),
                            ],
                            stops: [0.4, 0.6],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          ),
                        ),
                      ),
                    ),
                  ),

                  // Column 3
                  const Padding(
                    padding:
                        EdgeInsets.only(left: 0.0), // Ajuster la marge à gauche
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('1000', style: TextStyle(fontSize: 9.0)),
                        SizedBox(height: 10.0),
                        Text('100%', style: TextStyle(fontSize: 9.0)),
                      ],
                    ),
                  ),
                ],
              ),

              // Image
              Image.asset('images/trophegold.png', fit: BoxFit.cover),

              // Text
              const Column(
                children: [
                  Text(
                    'Gold',
                    style: TextStyle(
                        color: MyColors.yellow, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ],
          ),
        ),
        // Container 3
        Container(
          margin: const EdgeInsets.all(8.0),
          padding: const EdgeInsets.only(
              right: 16.0, left: 16.0, top: 0.0, bottom: 16.0),
          color: MyColors.white,
          child: Card(
            color: MyColors.grey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 10.0, bottom: 8.0),
                  child: const Text(
                    'Avantages Actuels',
                    style: TextStyle(
                        color: MyColors.red,
                        fontWeight: FontWeight.bold,
                        fontSize: 15),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 15.0),
                  child: RichText(
                    text: const TextSpan(
                      children: [
                        WidgetSpan(
                          alignment: PlaceholderAlignment.middle,
                          child: Icon(
                            Icons.circle,
                            color: MyColors.white,
                            size: 8.0,
                          ),
                        ),
                        TextSpan(
                          text: ' Récompenses améliorées\n',
                          style: TextStyle(fontSize: 14),
                        ),
                        WidgetSpan(
                          alignment: PlaceholderAlignment.middle,
                          child: Icon(
                            Icons.circle,
                            color: MyColors.white,
                            size: 8.0,
                          ),
                        ),
                        TextSpan(
                            text: ' Accès à des fonctionnalités exclusives\n',
                            style: TextStyle(fontSize: 14)),
                        WidgetSpan(
                          alignment: PlaceholderAlignment.middle,
                          child: Icon(
                            Icons.circle,
                            color: MyColors.white,
                            size: 8.0,
                          ),
                        ),
                        TextSpan(
                          text: ' Priorité dans le support client\n',
                          style: TextStyle(fontSize: 14),
                        ),
                        WidgetSpan(
                          alignment: PlaceholderAlignment.middle,
                          child: Icon(
                            Icons.circle,
                            color: MyColors.white,
                            size: 8.0,
                          ),
                        ),
                        TextSpan(
                          text: ' Participation à des événements exclusifs',
                          style: TextStyle(fontSize: 14),
                        ),
                      ],
                      style: TextStyle(color: MyColors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        // Container 4
        Container(
          margin: const EdgeInsets.all(8.0),
          padding: const EdgeInsets.only(
              right: 16.0, left: 16.0, top: 0.0, bottom: 16.0),
          color: MyColors.white,
          child: Card(
            color: MyColors.yellow,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 10.0, bottom: 8.0),
                  child: const Text(
                    'Avantages A Venir',
                    style: TextStyle(
                        color: MyColors.red,
                        fontWeight: FontWeight.bold,
                        fontSize: 15),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 15.0),
                  child: RichText(
                    text: const TextSpan(
                      children: [
                        WidgetSpan(
                          alignment: PlaceholderAlignment.middle,
                          child: Icon(
                            Icons.circle,
                            color: MyColors.white,
                            size: 8.0,
                          ),
                        ),
                        TextSpan(
                          text: ' Réductions ou Offres Exclusives\n',
                          style: TextStyle(fontSize: 14),
                        ),
                        WidgetSpan(
                          alignment: PlaceholderAlignment.middle,
                          child: Icon(
                            Icons.circle,
                            color: MyColors.white,
                            size: 8.0,
                          ),
                        ),
                        TextSpan(
                            text: ' Personnalisation Avancée\n',
                            style: TextStyle(fontSize: 14)),
                        WidgetSpan(
                          alignment: PlaceholderAlignment.middle,
                          child: Icon(
                            Icons.circle,
                            color: MyColors.white,
                            size: 8.0,
                          ),
                        ),
                        TextSpan(
                          text: ' Accès à des Événements VIP\n',
                          style: TextStyle(fontSize: 14),
                        ),
                        WidgetSpan(
                          alignment: PlaceholderAlignment.middle,
                          child: Icon(
                            Icons.circle,
                            color: MyColors.white,
                            size: 8.0,
                          ),
                        ),
                        TextSpan(
                          text: ' Avantages Sociaux',
                          style: TextStyle(fontSize: 14),
                        ),
                      ],
                      style: TextStyle(color: MyColors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
