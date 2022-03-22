import 'dart:async';

import 'package:change/entity/Performance.dart';
import 'package:change/entity/User.dart';
import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Future<Database> getDatabase(bool justOpen) async {
  var databasesPath = await getDatabasesPath();
  String path = join(databasesPath, 'change.db');

  /// 打开并创建数据表
  Database database = await openDatabase(path, version: 1,
      onCreate: (Database _db, int version) async {
    // 创建表
    await _db.execute(
        "CREATE TABLE IF NOT EXISTS `User` (`name` TEXT, `id` INTEGER PRIMARY KEY AUTOINCREMENT)");
    await _db.execute(
        "CREATE TABLE IF NOT EXISTS `Performance` (`userId` INTEGER NOT NULL, `dateStamp` INTEGER NOT NULL, `income` INTEGER NOT NULL, `salary` INTEGER NOT NULL, `pid` INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL)");
    await _db.execute(
        "CREATE TABLE IF NOT EXISTS `Expend` (`type` INTEGER NOT NULL, `money` INTEGER NOT NULL, `dateStamp` INTEGER NOT NULL, `eId` INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL)");
    });
  return database;
}

/// 插入员工数据到员工表
Future<int> insertUser(User user) async {
  // Get a reference to the database.
  final db = await getDatabase(true);

  // Insert the Dog into the correct table. You might also specify the
  // `conflictAlgorithm` to use in case the same dog is inserted twice.
  //
  // In this case, replace any previous data.
  int id = await db.insert(
    'User',
    user.toMap(),
    conflictAlgorithm: ConflictAlgorithm.replace,
  );
  return id;
}

/// 获取员工数据列表
Future<List<User>> getUsers() async {
  final db = await getDatabase(true);
  final List<Map<String, dynamic>> maps = await db.query('User');
  return List.generate(maps.length, (i) {
    return User(id: maps[i]['id'], name: maps[i]['name']);
  });
}

/// 插入数据到业绩工资表
Future<int> insertPerformance(Performance p) async {
  final db = await getDatabase(true);
  int id = await db.insert(
      "Performance",
      p.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace
  );
  return id ;
}
/// 获取所有业绩工资信息
Future<List<Performance>> getPerformances() async {
  final db = await getDatabase(true);
  final List<Map<String,dynamic>> maps = await db.query("Performance");
  return List.generate(maps.length, (i) {
    return Performance(
         maps[i]["userId"],
         maps[i]["dataStamp"],
         maps[i]["income"],
         maps[i]["salary"]
    );
  });
}
