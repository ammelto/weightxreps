import 'package:flutter/material.dart';

class Settings extends StatefulWidget {
  Settings({Key key, this.color}) : super(key: key);
  final Color color;
  @override
  _Settings createState() => new _Settings();
}

class _Settings extends State<Settings> with TickerProviderStateMixin {

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