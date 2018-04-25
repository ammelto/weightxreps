import 'package:flutter/material.dart';

class NonexistentAppBar extends AppBar {
  NonexistentAppBar({Key key, this.padding=0.0}): super(
    key: key,
    backgroundColor: Colors.transparent,
    elevation: 0.0,
  );

  final double padding;

  @override
  Size get preferredSize => new Size.fromHeight(padding);
}