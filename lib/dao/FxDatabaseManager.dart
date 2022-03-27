import 'package:change/dao/AppDatabase.dart';
import 'package:change/entity/Performance.dart';
import 'package:change/entity/User.dart';
import 'package:change/entity/UserBill.dart';
import 'package:change/extensio/TimeExtension.dart';
class FxDatabaseManager {
  /// 获取数据库
  static database() async {
    final database =
        await $FloorAppDatabase.databaseBuilder(AppDatabase.dbName).build();
    return database;
  }
  /// 获取所有员工信息
  static Future<List<User>> getUsers() async {
    final AppDatabase database = await FxDatabaseManager.database();
    List<User> users = await database.userDao.queryAllUser();
    return users;
  }
  /// 插入员工数据
  static Future<int> insertUser(User user) async {
    final  AppDatabase  database = await FxDatabaseManager.database();
    return database.userDao.insert(user);
  }

  /// 保存业绩工资记录
  static Future<void> savePerformance(Performance performance) async {
    final  AppDatabase  database = await FxDatabaseManager.database();
    return database.performanceDao.insert(performance);
  }

  static Future<List<UserBill>> queryBillByDate(DateTime dateTime) async {
    final AppDatabase database = await FxDatabaseManager.database();
    int time = dateTime.microsecondsSinceEpoch;
    var minDate = time.getMinDateStampDay();
    var maxDate = time.getMaxDateStampDay();
   return database.userBillDao.queryBillByDate(minDate, maxDate);
  }
}
