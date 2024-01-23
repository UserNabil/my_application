import '../../../import.dart';

class FakeData {
  String imgSrc =
      "https://www.befoot.net/wp-content/uploads/2024/01/Icon_659_0714435776-1024x652.jpg.webp";
  String imgSrc2 =
      "https://e-s-tunis.com/images/news/2023/10/07/1696714847_img.jpg";
  String imgSrc3 =
      "https://madeinfoot.ouest-france.fr/photos/ligue-1/2023/zoom/l1-20231213090626-8276.jpg";

  List<String> texts = [
    "Gambie – Cameroun : Les compositions probables",
    "La composition probable du Cameroun",
    "Le Cameroun ne peut se permettre la moindre erreur. Même un match nul ne serait pas suffisant pour les hommes de Rigobert Song, qui doivent affronter la Gambie. Heureusement, les quatre meilleurs troisièmes des six groupes se qualifieront pour les huitièmes de finale de la CAN. Remporter trois points lors de la dernière journée permettrait aux Lions Indomptables d’accumuler quatre points au total, ce qui devrait assurer leur place en huitièmes de finale.",
    "Aboubakar toujours incertain",
    "Rigobert Song ne signale aucune nouvelle blessure, ce qui signifie qu’il pourra aligner les mêmes joueurs qui ont débuté la compétition. Cependant, la question persiste quant à la participation de Vincent Aboubakar, qui s’est blessé à la cuisse gauche avant le premier match de l’équipe.",
    "Les compositions probables",
    "L’une des rares lueurs positives en ce début de CAN pour la Gambie est l’absence de blessures dans l’équipe. Tom Saintfiet pourra aligner l’ensemble de ses joueurs.",
  ];
  List<String> texts2 = [
    "L'attaquant de la Juventus Cristiano Ronaldo souhaite rejoindre Manchester City, selon ESPN.",
    "Le Portugal a été lié à un déménagement à l'Etihad Stadium.",
    "L'attaquant de la Juventus Cristiano Ronaldo souhaite rejoindre Manchester City, selon ESPN.",
  ];

  Social social = Social(
    like: '143,000',
    comment: '14,000',
    views: '2,150,000',
    imgAuthor: 'https://i.pravatar.cc/100',
  );

  Future<APIResponseModel<List<News>>> newNews() async {
    await Future.delayed(const Duration(seconds: 1));
    return APIResponseModel(
      data: [
        News(
          id: 25,
          imagePath: imgSrc,
          title: texts[0],
          date: '12/03/2023',
          admin: 'Brian Imanuel',
          content: [
            // NewsDetailsModel(detailHTML: "h1", detailValue: texts[0]),
            // NewsDetailsModel(detailHTML: "src", detailValue: imgSrc2),
            // NewsDetailsModel(detailHTML: "h2", detailValue: texts[1]),
            // NewsDetailsModel(detailHTML: "p", detailValue: texts[2]),
            // NewsDetailsModel(detailHTML: "em", detailValue: texts[1]),
            // NewsDetailsModel(detailHTML: "src", detailValue: imgSrc3),
            // NewsDetailsModel(detailHTML: "p", detailValue: texts[2]),
          ],
          social: null,
          // social: Social(
          //   like: '6,234',
          //   comment: '1,234',
          //   views: '1,234,000',
          //   imgAuthor: 'https://i.pravatar.cc/100',
          // ),
        ),
        // News(
        //   id: '2',
        //   imagePath: 'images/pngs/news/news2.jpg',
        //   title: "LIVE Transfer Talk: Ronaldo pushing for Man City move",
        //   date: '13/03/2023',
        //   admin: 'Rosa Melano',
        //   texts: texts2,
        //   social: Social(
        //     like: '143,000',
        //     comment: '14,000',
        //     views: '2,150,000',
        //     imgAuthor: 'https://i.pravatar.cc/100',
        //   ),
        // ),
        // News(
        //   id: '3',
        //   imagePath: 'images/pngs/news/news3.jpg',
        //   title: "LIVE Transfer Talk: Ronaldo pushing for Man City move",
        //   date: '14/03/2023',
        //   admin: 'Joshua Christian',
        //   texts: texts,
        //   social: Social(
        //     like: '2,500',
        //     comment: '1,423',
        //     views: '10,000',
        //     imgAuthor: 'https://i.pravatar.cc/100',
        //   ),
        // ),
      ],
      isSuccess: false,
    );
  }
}
