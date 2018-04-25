import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:kinoweights/data/entities/user.dart';
import 'baseprovider.dart';

class UserProvider extends BaseProvider<User>{

  static final String tableUser = "user";
  static final String columnId = "_id";
  static final String columnName = "name";
  static final String columnToken = "token";

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
  Future<User> insert(User user) async {
    user.id = await db.insert(tableUser, user.toMap());
    return user;
  }

  @override
  Future<User> query(String key, String value) async {
    List<Map> maps = await db.query(tableUser,
        columns: [columnId, columnToken, columnName],
        where: "$key = ?",
        whereArgs: [value]);
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
  Future<int> update(User user) async {
    return await db.update(tableUser, user.toMap(),
        where: "$columnId = ?", whereArgs: [user.id]);
  }

}

