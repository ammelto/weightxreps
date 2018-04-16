import 'package:flutter/material.dart';

class Rankings extends StatefulWidget {
  Rankings({Key key, this.color}) : super(key: key);
  final Color color;
  @override
  _Rankings createState() => new _Rankings();
}

class _Rankings extends State<Rankings> with TickerProviderStateMixin {
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