import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_xlider/flutter_xlider.dart';
import 'package:my_taraji/core/theme/my_color.dart';

void main() {
  runApp(const MaterialApp(
    home: MyDon(),
  ));
}

class MyDon extends StatefulWidget {
  const MyDon({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _MyDonState createState() => _MyDonState();
}

class _MyDonState extends State<MyDon> {
  double _sliderValue = 0;
  List<double> montants = [10.0, 20.0, 50.0, 100.0, 200.0];
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Container(
      width: width,
      padding: const EdgeInsets.only(left: 30, right: 30),
      decoration: const BoxDecoration(
        color: MyColors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(50),
          topRight: Radius.circular(50),
        ),
      ),
      alignment: Alignment.center,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 20),
          SvgPicture.asset(
            'images/icons/drag.svg',
            height: 5,
            width: 5,
          ),
          const SizedBox(height: 20),
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
                    'images/taraji.png',
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
                    Text('Don pour Taraji'),
                  ],
                )
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.all(8.0),
            padding: const EdgeInsets.only(
              left: 16.0,
              right: 16.0,
              top: 0.0,
              bottom: 16.0,
            ),
            color: Colors.white,
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Ligne 1
                Text('Définir montant',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 20.0),
                // Ligne 2 avec un nouveau Row contenant le texte "Montant" et le champ de saisie (TextField)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                        width:
                            8.0), // Ajout d'un espace entre le texte et le champ de saisie
                    Expanded(
                      child: TextField(
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: 'Montant',
                          hintText: 'Entrez le montant',
                        ),
                      ),
                    ),
                    Text(
                        'DT'), // Remplacez \$ par le symbole de devise souhaité
                  ],
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Utilisation d'un Wrap pour disposer les boutons
                Wrap(
                  spacing: 8.0, // Espace horizontal entre les boutons
                  runSpacing:
                      8.0, // Espace vertical entre les lignes de boutons
                  children: montants.map((montant) {
                    return ElevatedButton(
                      onPressed: () {
                        // Faites quelque chose lorsque le bouton est pressé
                        // Vous pouvez récupérer le montant correspondant
                        double selectedMontant = montant;
                        // Faites quelque chose avec le montant sélectionné
                      },
                      style: ElevatedButton.styleFrom(
                        primary: MyColors.yellow, // Couleur de fond en jaune
                        onPrimary: Colors.white, // Couleur du texte en blanc
                      ),
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text('${montant} DT'),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),

          const SizedBox(height: 60.0),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 16.0),
            child: FlutterSlider(
              values: [_sliderValue],
              max: 100,
              min: 0,
              handler: FlutterSliderHandler(
                decoration: const BoxDecoration(
                  color: MyColors.yellow,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.double_arrow,
                  color: MyColors.white,
                ),
              ),
              onDragging: (handlerIndex, lowerValue, upperValue) {
                setState(() {
                  _sliderValue = lowerValue;
                });
              },
              trackBar: const FlutterSliderTrackBar(
                activeTrackBarHeight: 10,
                activeTrackBar: BoxDecoration(
                  color: Colors.grey,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
