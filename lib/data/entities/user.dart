import 'dart:async';

import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'providedentity.dart';

class User extends ProvidedEntity{
  int id;
  String name;
  String token;

  Map toMap() {
    Map map = {columnName: name, columnToken: token};
    if (id != null) {
      map[columnId] = id;
    }
    return map;
  }

  User();

  User.fromMap(Map map) {
    id = map[columnId];
    name = map[columnName];
    token = map[columnToken];
  }
}