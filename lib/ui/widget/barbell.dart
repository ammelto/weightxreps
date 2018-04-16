import 'package:flutter/material.dart';

class Barbell extends StatefulWidget {
  Barbell({Key key}) : super(key: key);
  @override
  _BarbellState createState() => new _BarbellState();
}

class Sky extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = new Paint();
    paint.color = Colors.amber;
    canvas.drawCircle(new Offset(100.0, 200.0), 40.0, paint);
    Paint paintRect = new Paint();
    paintRect.color = Colors.lightBlue;
    Rect rect =
    new Rect.fromPoints(new Offset(150.0, 300.0), new Offset(300.0, 400.0));
    canvas.drawRect(rect, paintRect);
  }

  bool shouldRepaint(Sky oldDelegate) => false;
  bool shouldRebuildSemantics(Sky oldDelegate) => false;
}

class _BarbellState extends State<Barbell> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new CustomPaint(
        painter: new Sky(),
      ),
    );
  }
}