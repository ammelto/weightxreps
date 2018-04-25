import 'package:flutter/material.dart';
enum Size {tiny, small, medium, big, huge}

class Weight{
  final double weight;
  final Color color;
  final Size size;

  static const List<Weight> OlympicImperial = [
    const Weight(weight: 1.25, color: Colors.black, size: Size.tiny),
    const Weight(weight: 2.5, color: Colors.pink, size: Size.small),
    const Weight(weight: 5.0, color: Colors.green, size: Size.small),
    const Weight(weight: 10.0, color: Colors.amber, size: Size.medium),
    const Weight(weight: 25.0, color: Colors.blue, size: Size.medium),
    const Weight(weight: 45.0, color: Colors.orange, size: Size.big),
    const Weight(weight: 100.0, color: Colors.red, size: Size.huge),
  ];

  static const List<Weight> OlympicMetric = [
    const Weight(weight: 0.25, color: Colors.black, size: Size.tiny),
    const Weight(weight: 0.5, color: Colors.black12, size: Size.tiny),
    const Weight(weight: 1.25, color: Colors.grey, size: Size.small),
    const Weight(weight: 2.5, color: Colors.pink, size: Size.small),
    const Weight(weight: 5.0, color: Colors.green, size: Size.medium),
    const Weight(weight: 10.0, color: Colors.amber, size: Size.medium),
    const Weight(weight: 15.0, color: Colors.blue, size: Size.medium),
    const Weight(weight: 20.0, color: Colors.cyan, size: Size.big),
    const Weight(weight: 25.0, color: Colors.orange, size: Size.big),
    const Weight(weight: 50.0, color: Colors.red, size: Size.huge),
  ];

  const Weight({this.weight, this.color, this.size});
}
