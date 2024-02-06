import 'package:flutter/material.dart';

class CGUContent extends StatelessWidget {
  const CGUContent({super.key});
  @override
  Widget build(BuildContext context) {
    const double defaultFontSize = 14.0;
    const double titleFontSize = 18.0;

    // Styles
    const TextStyle titleStyle =
        TextStyle(fontSize: titleFontSize, fontWeight: FontWeight.bold);
    const TextStyle subtitleStyle = TextStyle(
        decoration: TextDecoration.underline,
        fontSize: 16,
        fontWeight: FontWeight.bold);
    const TextStyle subsubtitleStyle =
        TextStyle(fontSize: defaultFontSize, fontWeight: FontWeight.bold);
    const TextStyle textStyle =
        TextStyle(color: Colors.black, fontSize: defaultFontSize);
    const TextStyle boldStyle =
        TextStyle(fontSize: defaultFontSize, fontWeight: FontWeight.bold);

    // List of text
    List<Widget> texts = [
      const Text(
        textAlign: TextAlign.center,
        "Conditions générales d’utilisation du service « MY TARAJI»",
        style: titleStyle,
      ),
      const SizedBox(height: 10),
      const Text(
        "Article 1. Présentation générale du service «MY TARAJI»",
        style: subtitleStyle,
      ),
      const SizedBox(height: 10),
      RichText(
        strutStyle: const StrutStyle(height: 1.5),
        text: const TextSpan(
          style: textStyle,
          children: [
            TextSpan(
              style: boldStyle,
              text: "MY TARAJI ",
            ),
            TextSpan(
              text:
                  "est une plateforme assimilée à une application mobile Android et iOS proposant à ses utilisateurs une application mobile  qui permet de gratifier ses utilisateurs directement et indirectement avec des OULIDHA grâce à sa plateforme de gamification.",
            ),
          ],
        ),
      ),
      const SizedBox(height: 10),
      RichText(
        strutStyle: const StrutStyle(height: 1.5),
        text: const TextSpan(
          style: textStyle,
          children: [
            TextSpan(text: "Pour accéder au service "),
            TextSpan(style: boldStyle, text: "MY TARAJI"),
            TextSpan(text: ", il est nécessaire de disposer : "),
          ],
        ),
      ),
      RichText(
        strutStyle: const StrutStyle(height: 1.5),
        text: const TextSpan(
          style: textStyle,
          children: [
            TextSpan(text: "\u2022 D’une puce,", style: textStyle),
            TextSpan(
                text: "\n\u2022 D’un compte sur le Service MY TARAJI. ",
                style: textStyle),
          ],
        ),
      ),
      const SizedBox(height: 10),
      const Text(
        "Article 2. Objet des conditions générales et d’utilisation du Service MY TARAJI",
        style: subtitleStyle,
      ),
      RichText(
        strutStyle: const StrutStyle(height: 1.5),
        text: const TextSpan(
          style: textStyle,
          children: [
            TextSpan(
                text:
                    "Le présent document a pour objet de déterminer les conditions générales d’utilisation du Service "),
            TextSpan(style: boldStyle, text: "MY TARAJI"),
            TextSpan(
              text:
                  ". Il définit les droits et obligations de l’EST  et des Utilisateurs dans le cadre de l’utilisation du Service ",
            ),
            TextSpan(style: boldStyle, text: "MY TARAJI."),
            TextSpan(
              text:
                  "\n\nLes CGU sont proposées en langue française exclusivement. ",
            ),
            TextSpan(
              text:
                  "\n\nLes CGU sont portées à la connaissance des Utilisateurs à tout moment au niveau des applications mobiles en cliquant sur le bouton « J’ai lu et j’accepte les conditions d’utilisation » disponible dans l’Application. ",
            ),
          ],
        ),
      ),
      const SizedBox(height: 10),
      const Text(
        "Article 3. Acceptation et modification des conditions générales d’utilisation du Service MY TARAJI",
        style: subtitleStyle,
      ),
      RichText(
        strutStyle: const StrutStyle(height: 1.5),
        text: const TextSpan(
          style: textStyle,
          children: [
            TextSpan(text: "L’utilisation du Service "),
            TextSpan(style: boldStyle, text: "MY TARAJI "),
            TextSpan(
                text:
                    "suppose l’acceptation pleine et entière par l’Utilisateur des CGU."),
          ],
        ),
      ),
      RichText(
        strutStyle: const StrutStyle(height: 1.5),
        text: const TextSpan(
          style: textStyle,
          children: [
            TextSpan(
                text:
                    "L’EST se réserve la possibilité de modifier à tout moment le Service "),
            TextSpan(style: boldStyle, text: "MY TARAJI "),
            TextSpan(text: "ainsi que le contenu des CGU. "),
            TextSpan(
                text:
                    "\n\nLes fans de l’EST accédant au Service se verront notifier de telles modifications dans un délai minimum de trente jours précédant leur entrée en vigueur, à moins qu’elles ne soient dictées par une règle impérative ou décision judiciaire auquel cas leur entrée en vigueur sera immédiate. Tout utilisateur qui refuserait les nouvelles conditions devra dès lors résilier son accès au Service dans les conditions prévues aux articles des présentes. "),
            TextSpan(
                text:
                    "\n\nL’utilisateur n’ayant pas procédé à la résiliation de son compte après l’expiration du délai précité sera irrévocablement réputé avoir accepté les modifications en question."),
          ],
        ),
      ),
      const SizedBox(height: 10),
      const Text(
        "Article 4. Inscription et Accès au Service MY TARAJI",
        style: subtitleStyle,
      ),
      const Text(
          "4.1 Inscription au Service MY TARAJI et création d’un Compte Utilisateur",
          style: subsubtitleStyle),
      RichText(
        strutStyle: const StrutStyle(height: 1.5),
        text: const TextSpan(
          style: textStyle,
          children: [
            TextSpan(text: "L’accès et l’utilisation du Service "),
            TextSpan(style: boldStyle, text: "MY TARAJI "),
            TextSpan(
              text:
                  " suppose que l’Utilisateur ait préalablement lu et accepté les présentes Conditions d’utilisation sans réserve. ",
            ),
            TextSpan(text: "\n\nLorsque l’utilisateur souscrit au service "),
            TextSpan(style: boldStyle, text: "MY TARAJI "),
            TextSpan(
              text:
                  "TARAJI crée un compte utilisateur automatiquement en utilisant son numéro de téléphone. L’Utilisateur, au cours du processus d’inscription et de création de son compte Utilisateur, recevra un SMS afin d’activer son compte utilisateur et il reconnaît autoriser l’utilisation de ces données par l’EST pour les besoins de la création et de l’administration du compte utilisateur.",
            ),
            TextSpan(
                text:
                    "\n\nEn tout état de cause et quel que soit le moyen par lequel l’utilisateur s’inscrit au Service "),
            TextSpan(style: boldStyle, text: "MY TARAJI "),
            TextSpan(
              text:
                  ", l’utilisateur garantit que les informations qu’il fournit, directement ou non, sont exactes, à jour et complètes. L’utilisateur s’engage également à mettre à jour les informations communiquées sur son compte utilisateur, dès que l’une d’entre elles est modifiée et ce, afin de maintenir l’exactitude des informations. ",
            ),
            TextSpan(
              text:
                  "\n\nDans tous les cas d’inscription, le compte utilisateur est strictement personnel et ne pourra pas être utilisé par un tiers directement ou indirectement.",
            ),
            TextSpan(
              text:
                  "\n\nL’utilisateur reconnaît que l’EST se réserve le droit de suspendre ou de lui retirer la possibilité d’accéder au service, dès lors que l’utilisateur ne respecterait pas les présentes modalités d’inscription et particulièrement s’il fournit des données fausses ou fantaisistes, inexactes, incomplètes ou non mises à jour et si le compte est utilisé par un tiers. ",
            ),
            TextSpan(
              text:
                  "\n\nEn aucun cas, la responsabilité de l’EST ne pourra être engagée en cas d’erreur, d’omission ou d’imprécision dans les informations communiquées par l’utilisateur sous sa responsabilité. ",
            ),
            TextSpan(
              text:
                  "\n\nL’identifiant et le mot de passe de l’utilisateur lui permettant d’accéder au compte utilisateur et à ses données sont strictement confidentiels et personnels. ",
            ),
            TextSpan(
              text:
                  "\n\nL’utilisateur est seul responsable de l’utilisation qui pourrait être faite de son compte utilisateur. Il s’engage à informer immédiatement l’EST de toute utilisation qu’il n’aurait pas autorisée et de toute atteinte à la confidentialité ou à la sécurité de ses données d’identification, en ligne à l’adresse suivante : ",
            ),
            TextSpan(style: boldStyle, text: "MYTARAJI@queney.com"),
          ],
        ),
      ),
      const SizedBox(height: 10),
      const Text("4.2 Accès au service MY TARAJI", style: subsubtitleStyle),
      RichText(
        strutStyle: const StrutStyle(height: 1.5),
        text: const TextSpan(
          style: textStyle,
          children: [
            TextSpan(
              text: "Pour accéder au Service",
            ),
            TextSpan(style: boldStyle, text: " MY TARAJI "),
            TextSpan(
              text:
                  "depuis son Terminal, l’Utilisateur doit télécharger et installer l’Application",
            ),
            TextSpan(style: boldStyle, text: " MY TARAJI "),
            TextSpan(
              text: "sur son Terminal",
            ),
          ],
        ),
      ),
      const SizedBox(height: 10),
      RichText(
        strutStyle: const StrutStyle(height: 1.5),
        text: const TextSpan(
          style: textStyle,
          children: [
            TextSpan(
                text:
                    "Pour télécharger et installer l’application sur son terminal, l’utilisateur est invité à se rendre sur :"),
            TextSpan(
              text:
                  "\n\u2022 App Store d’Apple si son Terminal est un iPhone ou un iPad,",
              style: textStyle,
            ),
            TextSpan(
              text:
                  "\n\u2022 Play Store ou AppGallery si son Terminal est une tablette ou un smartphone sous Android ",
              style: textStyle,
            ),
          ],
        ),
      ),
      const SizedBox(height: 10),
      RichText(
        strutStyle: const StrutStyle(height: 1.5),
        text: const TextSpan(
          style: textStyle,
          children: [
            TextSpan(
              text: "Le Service ",
            ),
            TextSpan(style: boldStyle, text: " MY TARAJI "),
            TextSpan(
              text:
                  "TARAJI est accessible sans interruption, sous réserve des aléas liés à la disponibilité du réseau Internet. L’Utilisateur est en outre informé que le Service ",
            ),
            TextSpan(style: boldStyle, text: " MY TARAJI "),
            TextSpan(
              text:
                  "pourra être temporairement indisponible pour maintenance ou réparation. L’EST se réserve néanmoins le droit, en cas de nécessité impérieuse, sans préavis ni indemnité, d'en fermer temporairement l'accès et ne sera pas responsable des dommages de toute nature pouvant survenir de ce fait.",
            ),
          ],
        ),
      ),
      const SizedBox(height: 10),
      const Text("Article 5. Propriété Intellectuelle", style: subtitleStyle),
      RichText(
        strutStyle: const StrutStyle(height: 1.5),
        text: const TextSpan(
          style: textStyle,
          children: [
            TextSpan(style: boldStyle, text: "MY TARAJI "),
            TextSpan(
              text:
                  "vous accorde une licence limitée, non exclusive, non transférable et non sous-licenciable pour (1) accéder au contenu MY TARAJI et le consulter, et (2) accéder et utiliser le logiciel et les applications mobiles fournies par le service ",
            ),
            TextSpan(style: boldStyle, text: " MY TARAJI."),
            TextSpan(
              text:
                  "\n\nCette licence est fournie uniquement pour votre utilisation personnelle non-commerciale et la jouissance du service",
            ),
            TextSpan(style: boldStyle, text: " MY TARAJI "),
            TextSpan(
              text: "tel que permis dans ces conditions.",
            ),
            TextSpan(
                text:
                    "\n\nLe contenu de MY TARAJI, le Service MY TARAJI et sa technologie sous-jacente sont protégés par des droits d'auteur, marque, brevets, droits de propriété intellectuelle et autres droits de la loi internationale."),
            TextSpan(
              text:
                  "Vous ne pouvez pas faire les choses suivantes durant votre accès ou utilisation du Service MY TARAJI (1) utiliser, afficher, copier ou réutiliser le Service MY TARAJI, le nom MY TARAJI, toute autre marque MY TARAJI, logo ou autre information ou la mise en page et la conception de toute page ou formulaire contenu sur une page, sans le consentement écrit MY TARAJI; (2) trafiquer ou modifier les zones non publiques du service MY TARAJI, les systèmes informatiques de MY TARAJI ou les systèmes de livraison techniques des fournisseurs de MY TARAJI; (3) tester la vulnérabilité de tout système MY TARAJI ou enfreindre toute mesure de sécurité ou d'authentification ; (4) contourner toute mesure technique mise en œuvre par MY TARAJI ou l'un des fournisseurs de MY TARAJI ou tout autre tiers (y compris un autre utilisateur) pour protéger le service MY TARAJI ou le contenu MY TARAJI; (5) accéder au Service MY TARAJI ou au contenu MY TARAJI grâce à l'utilisation de tout mécanisme autre que le Service MY TARAJI ou l'API MY TARAJI ; ou (6) modifier, décompiler, désassembler, désosser, altérer ou tenter de dériver le code source de tout logiciel fourni par MY TARAJI à vous ou à toute autre partie du service MY TARAJI.",
            )
          ],
        ),
      ),
      const SizedBox(height: 10),
      const Text("Article 6. Responsabilité", style: subtitleStyle),
      const Text(
          "L’EST met tout en œuvre pour offrir aux utilisateurs du Service MY TARAJI des outils disponibles. L’EST ne pourra en aucun cas être tenue responsable des vitesses d'accès au Service MY TARAJI, d'accès aux données du Service MY TARAJI, de téléchargement voire de suspension ou d'impossibilité temporaire d'accès. L’utilisateur est seul responsable de ses équipements techniques et de leur compatibilité avec le Service MY TARAJI. Il doit prévenir les éventuelles intrusions ou virus par les moyens habituels (Firewall, anti-virus, ...) qui ne sont pas de la responsabilité de Orange. La responsabilité de l’EST ne saurait être engagée dans le cas où le contenu, ainsi que d'éventuels liens hypertextes pointant sur d'autres sites, contreviendraient aux droits de tiers et plus généralement aux dispositions légales ou règlementaires en vigueur."),
      const SizedBox(height: 10),
      const Text("Article 7. Modification et cessation du Service MY TARAJI",
          style: subtitleStyle),
      const Text(
        "L’EST se réserve le droit de modifier les conditions d’utilisation du Service MY TARAJI et/ou des offres. Toute modification concernant les modalités de fourniture du Service sera portée à la connaissance des utilisateurs avec un préavis de 60 jours. La cessation éventuelle du Service MY TARAJI sera annoncée aux utilisateurs avec un préavis de trente jours (30 jours). Toute modification et/ou cessation du Service MY TARAJI ou des offres dans les conditions susvisées ne saurait engager la responsabilité de l’EST à quelque titre que ce soit.",
      ),
      const SizedBox(height: 10),
      const Text("Article 8. Politique d’utilisation des données",
          style: subtitleStyle),
      const Text(
        "Nous ne vendons pas vos données personnelles aux annonceurs et ne partageons pas d’informations permettant de vous identifier directement (telles que votre nom, votre adresse e-mail ou toutes autres coordonnées) avec les annonceurs, sauf autorisation expresse de votre part. À la place, les annonceurs nous donnent des informations, telles que le type d’audience à qui ils souhaitent montrer leurs publicités, et nous diffusons ces publicités auprès des personnes susceptibles d’être intéressées. Nous envoyons aux annonceurs des rapports sur les performances de leurs publicités pour les aider à comprendre comment les gens interagissent avec leur contenu",
      ),
      const SizedBox(height: 10),
      const Text("Article 9. Loi applicable", style: subtitleStyle),
      const Text(
        "Les présentes CGU sont soumises au droit Tunisien.",
      ),
    ];

    return Container(
      height: MediaQuery.of(context).size.height * 0.7,
      padding: const EdgeInsets.all(20),
      child: ListView.builder(
        padding: const EdgeInsets.all(0),
        itemBuilder: (context, index) {
          return texts[index];
        },
        itemCount: texts.length,
      ),
    );
  }
}
