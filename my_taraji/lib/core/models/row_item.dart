import 'package:flutter/material.dart';
import 'package:my_taraji/views/selfcare/models/pages_enum.dart';

class RowItem {
  final IconData icon;
  final String title;
  final String location;
  final PageViewEnum? pageName;

  RowItem({
    required this.icon,
    required this.title,
    required this.location,
    this.pageName,
  });
}
