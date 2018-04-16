import 'package:flutter/material.dart';
enum Size {tiny, small, medium, big, huge}

class Weight{
  final double weight;
  final Color color;
  final Size size;

  static List<Weight> OlympicImperial = [
    new Weight(weight: 1.25, color: Colors.black, size: Size.tiny),
    new Weight(weight: 2.5, color: Colors.pink, size: Size.small),
    new Weight(weight: 5.0, color: Colors.green, size: Size.small),
    new Weight(weight: 10.0, color: Colors.amber, size: Size.medium),
    new Weight(weight: 25.0, color: Colors.blue, size: Size.medium),
    new Weight(weight: 45.0, color: Colors.orange, size: Size.big),
    new Weight(weight: 100.0, color: Colors.red, size: Size.huge),
  ];

  static List<Weight> OlympicMetric = [
    new Weight(weight: 0.25, color: Colors.black, size: Size.tiny),
    new Weight(weight: 0.5, color: Colors.black12, size: Size.tiny),
    new Weight(weight: 1.25, color: Colors.grey, size: Size.small),
    new Weight(weight: 2.5, color: Colors.pink, size: Size.small),
    new Weight(weight: 5.0, color: Colors.green, size: Size.medium),
    new Weight(weight: 10.0, color: Colors.amber, size: Size.medium),
    new Weight(weight: 15.0, color: Colors.blue, size: Size.medium),
    new Weight(weight: 20.0, color: Colors.cyan, size: Size.big),
    new Weight(weight: 25.0, color: Colors.orange, size: Size.big),
    new Weight(weight: 50.0, color: Colors.red, size: Size.huge),
  ];

  Weight({this.weight, this.color, this.size});
}
