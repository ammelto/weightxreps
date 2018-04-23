import 'package:flutter/material.dart';

class WxrTitle extends StatelessWidget {
  final DecorationImage image;
  WxrTitle({this.image});
  @override
  Widget build(BuildContext context) {
    return (new Container(
      height: 50.0,
      alignment: Alignment.topCenter,
      decoration: new BoxDecoration(
        image: image,
      ),
    ));
  }
}