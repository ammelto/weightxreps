import 'package:flutter/material.dart';

class Settings extends StatefulWidget {
  Settings({Key key, this.color}) : super(key: key);
  final Color color;
  @override
  _Settings createState() => new _Settings();
}

class _Settings extends State<Settings> with TickerProviderStateMixin {
  AnimationController controller;
  CurvedAnimation curve;

  @override
  void initState() {
    controller = new AnimationController(duration: const Duration(milliseconds: 2000), vsync: this);
    curve = new CurvedAnimation(parent: controller, curve: Curves.easeIn);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Center(
          child: new Container(
              child: new FadeTransition(
                  opacity: curve,
                  child: new FlutterLogo(
                    size: 100.0,
                  )))),
      floatingActionButton: new FloatingActionButton(
        tooltip: 'Fade',
        child: new Icon(Icons.brush),
        backgroundColor: widget.color,
        onPressed: () {
          controller.forward();
        },
      ),
    );
  }
}