
class Workout {
  final String name;
  final double weight;
  final double quantity;

  Workout({this.name, this.weight, this.quantity});

  factory Workout.fromJson(Map<String, dynamic> json) {
    return new Workout(
      name: json['name'],
      weight: double.parse(json['weight']),
      quantity: double.parse(json['quantity'])
    );
  }
}