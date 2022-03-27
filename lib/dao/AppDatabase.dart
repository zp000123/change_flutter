import 'dart:async';

import 'package:change/dao/ExpendDao.dart';
import 'package:change/dao/ExpendTypeConverter.dart';
import 'package:change/entity/Expend.dart';
import 'package:change/entity/Performance.dart';
import 'package:change/entity/User.dart';
import 'package:change/entity/UserBill.dart';
import 'package:floor/floor.dart';

import 'PerformanceDao.dart';
import 'UserBillDao.dart';
import 'UserDao.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
part 'AppDatabase.g.dart';
/// Room 数据库配置类
@Database(
  entities: [User, Performance, Expend], // 数据表
  views: [UserBill], // 视图
  version: 2, // 数据库版本号
)
@TypeConverters([ExpendTypeConverter])
abstract class AppDatabase extends FloorDatabase {
  ExpendDao get expendDao;

  UserDao get userDao;

  PerformanceDao get performanceDao;

  UserBillDao get userBillDao;


   static final String  dbName = "bill.db";
}

