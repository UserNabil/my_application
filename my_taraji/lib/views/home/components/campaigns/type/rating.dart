import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class RatingInput extends StatelessWidget {
  final int maxRating;

  const RatingInput({super.key, required this.maxRating});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text('Rating'),
        RatingBar.builder(
          initialRating: 0,
          minRating: 1,
          direction: Axis.horizontal,
          allowHalfRating: true,
          itemCount: maxRating,
          itemSize: 30.0,
          itemBuilder: (context, _) => const Icon(
            Icons.star,
            color: Colors.amber,
          ),
          onRatingUpdate: (rating) {
            // Faire quelque chose avec la valeur de notation mise à jour
            // print(rating);
          },
        ),
      ],
    );
  }
}
