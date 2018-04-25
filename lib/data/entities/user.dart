import 'package:kinoweights/data/providers/userprovider.dart';
import 'providedentity.dart';

class User extends ProvidedEntity{
  int id;
  String name;
  String token;

  Map toMap() {
    Map map = new Map<String, dynamic>();
    if (id != null) {
      map[UserProvider.columnId] = id;
      map[UserProvider.columnToken] = token;
      map[UserProvider.columnName] = name;
    }
    return map;
  }

  User({this.id, this.name, this.token});

  User.fromMap(Map map) {
    id = map[UserProvider.columnId];
    name = map[UserProvider.columnName];
    token = map[UserProvider.columnToken];
  }
}