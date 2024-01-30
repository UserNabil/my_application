import 'package:flutter/Material.dart';
import 'package:my_taraji/views/selfcare/components/list_commande.dart';
import 'package:my_taraji/views/selfcare/components/mon_status.dart';
import 'package:my_taraji/views/selfcare/components/selfcare/animation_selfcare.dart';

import 'package:my_taraji/views/selfcare/models/pages_enum.dart';
import 'package:my_taraji/views/selfcare/view/page_views/profile_page_view.dart';
import 'package:my_taraji/views/selfcare/view/page_views/self_care_page_view.dart';
import 'package:my_taraji/views/selfcare/view/page_views/transactions_page_view.dart';

Widget selfCareBody(PageViewEnum pageName) {
  switch (pageName) {
    case PageViewEnum.selfcare:
      return AnimationSelfCareMenu(
        animationDirection: -1,
        child: SelfCarPageView(),
      );
    case PageViewEnum.myProfile:
      return AnimationSelfCareMenu(
        animationDirection: 1,
        child: ProfilePageView(),
      );
    case PageViewEnum.myTransactions:
      return const AnimationSelfCareMenu(
        animationDirection: 1,
        child: TransactionsPageView(),
      );
    case PageViewEnum.myStatus:
      return const AnimationSelfCareMenu(
        animationDirection: 1,
        child: MonStatus(),
      );
    case PageViewEnum.notifications:
      return const AnimationSelfCareMenu(
        animationDirection: 1,
        child: SizedBox(
          height: 300,
          child: Center(child: Text('notifications')),
        ),
      );
    case PageViewEnum.sponsorship:
      return const AnimationSelfCareMenu(
        animationDirection: 1,
        child: SizedBox(
          height: 300,
          child: Center(child: Text('sponsorship')),
        ),
      );
    case PageViewEnum.myOrders:
      return const AnimationSelfCareMenu(
        animationDirection: 1,
        child: ListCommande(),
      );
    case PageViewEnum.myAccount:
      return const AnimationSelfCareMenu(
        animationDirection: 1,
        child: SizedBox(
          height: 300,
          child: Center(child: Text('myAccount')),
        ),
      );
  }
}

String appBarTitle(PageViewEnum pageName) {
  switch (pageName) {
    case PageViewEnum.selfcare:
      return 'Selfcare';
    case PageViewEnum.myProfile:
      return 'Mon profil';
    case PageViewEnum.myTransactions:
      return 'Mes transactions';
    case PageViewEnum.myStatus:
      return 'Mon status';
    case PageViewEnum.notifications:
      return 'Notifications';
    case PageViewEnum.sponsorship:
      return 'Parraiange';
    case PageViewEnum.myOrders:
      return 'Mes commandes';
    case PageViewEnum.myAccount:
      return 'Désactiver mon compte';
  }
}
