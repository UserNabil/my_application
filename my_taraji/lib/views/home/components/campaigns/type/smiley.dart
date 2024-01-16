import '../../../import.dart';

class SmileyInput extends StatelessWidget {
  const SmileyInput(
      {super.key,
      required this.campaign,
      required this.smileyController,
      this.question});

  final Campaign campaign;
  final TextEditingController smileyController;
  final QuestionCampaign? question;

  @override
  Widget build(BuildContext context) {
    return EmotionSelector(smileyController: smileyController);
  }
}

class EmotionSelector extends StatefulWidget {
  const EmotionSelector({super.key, this.smileyController});

  final TextEditingController? smileyController;

  @override
  EmotionSelectorState createState() => EmotionSelectorState();
}

class EmotionSelectorState extends State<EmotionSelector> {
  String selectedEmotion = '';

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        buildEmotionButton('😡', 'En colère'),
        const SizedBox(width: 10),
        buildEmotionButton('😐', 'Pas très content'),
        const SizedBox(width: 10),
        buildEmotionButton('😊', 'Content'),
      ],
    );
  }

  Widget buildEmotionButton(String emoji, String emotion) {
    return InkWell(
      onTap: () {
        setState(() {
          selectedEmotion = emotion;
          widget.smileyController!.text = selectedEmotion;
        });
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: selectedEmotion == emotion ? Colors.blue : Colors.grey[200],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          emoji,
          style: const TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
