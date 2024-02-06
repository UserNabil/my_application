import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:my_taraji/core/models/row_item.dart';
import 'package:my_taraji/views/selfcare/models/pages_enum.dart';

final List<RowItem> rowsSelfCare = [
  RowItem(
    title: 'Mon profil',
    location: 'profile',
    icon: TablerIcons.user_circle,
    pageName: PageViewEnum.myProfile,
  ),
  RowItem(
    title: 'Mes transactions',
    location: 'payments',
    icon: TablerIcons.credit_card,
    pageName: PageViewEnum.myTransactions,
  ),
  RowItem(
    title: 'Mon status',
    location: 'statut',
    icon: TablerIcons.military_award,
    pageName: PageViewEnum.myStatus,
  ),
  RowItem(
    title: 'Notifications',
    location: 'alerts',
    icon: TablerIcons.bell,
    pageName: PageViewEnum.notifications,
  ),
  RowItem(
    title: 'Parraiange',
    location: 'sponsorship',
    icon: TablerIcons.discount_check,
    pageName: PageViewEnum.sponsorship,
  ),
  RowItem(
    title: 'Mes commandes',
    location: 'orders',
    icon: TablerIcons.box_seam,
    pageName: PageViewEnum.myOrders,
  ),
  RowItem(
    title: 'Désactiver mon compte',
    location: 'account',
    icon: TablerIcons.user_x,
    // pageName: PageViewEnum.myAccount,
  ),
  RowItem(
    title: 'CGU',
    location: 'cgu',
    icon: TablerIcons.file_text,
    pageName: PageViewEnum.cgu,
  ),
];
final List<RowItem> rowsAccount = [
  RowItem(
    title: 'Mon compte',
    location: 'account',
    icon: TablerIcons.user_circle,
  ),
  RowItem(
    title: 'Adresse',
    location: 'address',
    icon: TablerIcons.pin,
  ),
  RowItem(
    title: 'Paramètres',
    location: 'settings',
    icon: TablerIcons.settings,
  ),
  RowItem(
    title: "Centre d'aide",
    location: 'helps',
    icon: TablerIcons.help,
  ),
  RowItem(
    title: 'Contact',
    location: 'contact',
    icon: TablerIcons.phone,
  ),
];
