import 'package:flutter/material.dart';

class Logs extends StatefulWidget {
  Logs({Key key, this.color}) : super(key: key);
  final Color color;
  @override
  _Logs createState() => new _Logs();
}

class _Logs extends State<Logs> with TickerProviderStateMixin {

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