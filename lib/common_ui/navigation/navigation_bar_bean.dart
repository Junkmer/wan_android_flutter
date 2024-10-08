import 'package:flutter/cupertino.dart';

class NavigationBarBean {
  NavigationBarBean(
      {required this.page,
      required this.label,
      required this.icon,
      required this.activeIcon});

  final Widget page;
  final String label;
  final Widget icon;
  final Widget activeIcon;
}
