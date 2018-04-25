import 'package:flutter/material.dart';

class Rankings extends StatefulWidget {
  Rankings({Key key, this.color}) : super(key: key);
  final Color color;
  @override
  _Rankings createState() => new _Rankings();
}

class _Rankings extends State<Rankings> with TickerProviderStateMixin {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Container()
    );
  }
}