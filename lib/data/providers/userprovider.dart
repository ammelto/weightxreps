import 'dart:async';

import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:kinoweights/data/entities/user.dart';
import 'baseprovider.dart';

class UserProvider extends BaseProvider<User>{

  final String tableUser = "user";
  final String columnId = "_id";
  final String columnName = "name";
  final String columnToken = "token";

  @override
  Future open() async {
    String path = await getPath();
    db = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
          await db.execute('''
            create table $tableUser ( 
              $columnId integer primary key autoincrement, 
              $columnName text not null,
              $columnToken integer not null)
            ''');
        });
  }

  @override
  Future<User> insert(User todo) async {
    if(db == null){
      //await open(path);
    }
    todo.id = await db.insert(tableUser, todo.toMap());
    return todo;
  }

  @override
  Future<User> query(int id) async {
    List<Map> maps = await db.query(tableUser,
        columns: [columnId, columnToken, columnName],
        where: "$columnId = ?",
        whereArgs: [id]);
    if (maps.length > 0) {
      return new User.fromMap(maps.first);
    }
    return null;
  }

  @override
  Future<int> delete(int id) async {
    return await db.delete(tableUser, where: "$columnId = ?", whereArgs: [id]);
  }

  @override
  Future<int> update(User todo) async {
    return await db.update(tableUser, todo.toMap(),
        where: "$columnId = ?", whereArgs: [todo.id]);
  }

}

