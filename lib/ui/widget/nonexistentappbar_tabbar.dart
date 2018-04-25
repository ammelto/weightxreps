import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class NonexistentAppBar extends AppBar {
  NonexistentAppBar({Key key, this.padding=0.0,this.color, this.bottom}): super(
    key: key,
    elevation: 0.0,
    brightness: Brightness.dark,
    backgroundColor: color,
    bottom: bottom
  );

  final Color color;
  final double padding;
  final PreferredSizeWidget bottom;

  @override
  Size get preferredSize => this.bottom.preferredSize;

}