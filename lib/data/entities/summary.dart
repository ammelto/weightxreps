import 'package:kinoweights/data/entities/workout.dart';

class Summary {
  final String name;
  final String avatar;
  final String link;
  final String comment;
  final String country;
  final String age;
  final String posted;
  final String bodyweight;
  final List<Workout> workouts;

  Summary({this.name, this.avatar, this.link, this.comment, this.country, this.age, this.posted, this.bodyweight, this.workouts});

  factory Summary.fromJson(Map<String, dynamic> json) {
    var iterable = json['rows'];
    List<Workout> _workouts = new List();

    for(var workout in iterable){
      _workouts.add(new Workout.fromJson(workout));
    }

    return new Summary(
      name: json['name'],
      avatar: "http://weightxreps.net/" + json['avatar'],
      link: "http://weightxreps.net" + json['link'],
      comment: json['comment'],
      country: json['country'],
      age: json['age'],
      bodyweight: json['bodyweight'],
      posted: json['posted'],
      workouts: _workouts
    );
  }
}