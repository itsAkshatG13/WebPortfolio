import 'package:flutter/material.dart';

class HeaderItem {
  final String title;
  final  onTap;
  final bool isButton;
  BuildContext context;

  HeaderItem({
    this.title,
    this.onTap,
    this.isButton = false,
  });
}
