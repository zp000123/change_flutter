import 'package:floor/floor.dart';

/// 员工业绩收入表
@DatabaseView("SELECT user.uid, user.no, user.name, " +
    "performance.pid, performance.dateStamp, performance.income, performance.salary " +
    "FROM user " +
    "INNER JOIN performance ON user.uid = performance.userId")
class UserBill {
  int uid = 0;

  int no = 0;

  String? name;

  int pid = 0;
  int dateStamp = 0; // 毫秒
  int income = 0; // 收入
  int salary = 0; // 工资
}
