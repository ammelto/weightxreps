import 'dart:async';

import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

abstract class BaseProvider<T> {

  Database db;

  Future<String> getPath() async{
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    return join(documentsDirectory.path, "kinoweights.db");
  }

  Future open();

  Future<T> insert(T entity);

  Future<T> query(String key, String value);

  Future<int> delete(int id);

  Future<int> update(T entity);

  Future close() async => db.close();

}

