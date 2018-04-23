import 'dart:async';

import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

final String tableUser = "todo";
final String columnId = "_id";
final String columnName = "name";
final String columnToken = "token";

abstract class ProvidedEntity {

  Map toMap();

  ProvidedEntity();

  ProvidedEntity.fromMap(Map map);

}