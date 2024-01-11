import '../../../import.dart';

class RateInput extends StatelessWidget {
  const RateInput(
      {super.key,
      required this.campaign,
      required this.rateController,
      this.question});
  final Campaign campaign;
  final TextEditingController rateController;
  final QuestionCampaign? question;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(campaign.title),
        RatingBar.builder(
          initialRating: rateController.text.isNotEmpty
              ? double.parse(rateController.text)
              : 0.0,
          minRating: 1,
          direction: Axis.horizontal,
          allowHalfRating: true,
          itemCount: int.parse(question!.metas[0].value),
          itemSize: 30.0,
          itemBuilder: (context, _) => const Icon(
            TablerIcons.star,
            color: Colors.amber,
          ),
          onRatingUpdate: (rating) {
            rateController.text = rating.toString();
          },
        ),
      ],
    );
  }
}
