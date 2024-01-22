import '../../../import.dart';

class FakeData {
  List<String> texts = [
    "L'attaquant de la Juventus Cristiano Ronaldo souhaite rejoindre Manchester City, selon ESPN.",
    "Le Portugal a été lié à un déménagement à l'Etihad Stadium après avoir demandé à quitter la Juventus, et il a maintenant demandé à son agent Jorge Mendes de faire avancer l'affaire.",
    "Ronaldo a été laissé sur le banc lors de la victoire 2-2 de la Juventus contre l'Udinese dimanche, et il a quitté le stade avant la fin du match.",
    " Le joueur de 36 ans a marqué 101 buts en 134 matches pour la Juventus depuis son arrivée de Madrid en 2018.",
    " - ESPN +: Diffusez des matchs et des rediffusions en direct (États-Unis uniquement) - Donnez votre avis: Quel club convient le mieux à Ronaldo? - Stream ESPN FC Daily sur ESPN + (États-Unis uniquement) 22h00 BST: Le milieu de terrain de l'Atletico Madrid Saul Niguez est en route pour Chelsea, selon Fabrizio Romano.",
    " Saul a été lié à un déménagement à Manchester United, mais il devrait maintenant rejoindre Chelsea. Le joueur de 26 ans a été laissé sur le banc lors de la victoire 1-0 de l'Atletico contre Elche dimanche.",
    " - ESPN +: Diffusez des matchs et des rediffusions en direct (États-Unis uniquement) - Donnez votre avis: Quel club convient le mieux à Ronaldo? - Stream ESPN FC Daily sur ESPN + (États-Unis uniquement) 22h00 BST: Le milieu de terrain de l'Atletico Madrid Saul Niguez est en route pour Chelsea, selon Fabrizio Romano.",
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

  Future<List<News>> newNews() async {
    await Future.delayed(const Duration(seconds: 1));
    return [
      News(
        id: '1',
        imagePath: 'images/pngs/news/news1.jpg',
        title: "LIVE Transfer Talk: Ronaldo pushing for Man City move",
        date: '12/03/2023',
        admin: 'Brian Imanuel',
        texts: texts,
        social: Social(
          like: '6,234',
          comment: '1,234',
          views: '1,234,000',
          imgAuthor: 'https://i.pravatar.cc/100',
        ),
      ),
      News(
        id: '2',
        imagePath: 'images/pngs/news/news2.jpg',
        title: "LIVE Transfer Talk: Ronaldo pushing for Man City move",
        date: '13/03/2023',
        admin: 'Rosa Melano',
        texts: texts2,
        social: Social(
          like: '143,000',
          comment: '14,000',
          views: '2,150,000',
          imgAuthor: 'https://i.pravatar.cc/100',
        ),
      ),
      News(
        id: '3',
        imagePath: 'images/pngs/news/news3.jpg',
        title: "LIVE Transfer Talk: Ronaldo pushing for Man City move",
        date: '14/03/2023',
        admin: 'Joshua Christian',
        texts: texts,
        social: Social(
          like: '2,500',
          comment: '1,423',
          views: '10,000',
          imgAuthor: 'https://i.pravatar.cc/100',
        ),
      ),
    ];
  }
}
