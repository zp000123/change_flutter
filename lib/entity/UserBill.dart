import 'package:floor/floor.dart';

/// 员工业绩收入表
@DatabaseView(
    "SELECT user.uid, user.no, user.name, " +
        "performance.pid, performance.dateStamp, performance.income, performance.salary " +
        "FROM user " +
        "INNER JOIN performance ON user.uid = performance.userId",
    viewName: "userbill")
class UserBill {
  int uid = 0;

  int no = 0;

  String? name;

  int pid = 0;
  int dateStamp = 0; // 毫秒
  int income = 0; // 收入
  int salary = 0;

  UserBill(this.uid, this.no, this.name, this.pid, this.dateStamp, this.income,
      this.salary);

  @override
  String toString() {
    return 'UserBill{uid: $uid, no: $no, name: $name, pid: $pid, dateStamp: $dateStamp, income: $income, salary: $salary}';
  }

  static of(int dateTime) {
    return UserBill(0, 0, "", 0, dateTime, 0, 0);
  }

  copy(UserBill dbBill){
    this.uid = dbBill.uid;
    this.no = dbBill.no;
    this.name = dbBill.name;
    this.pid = dbBill.pid;
    this.dateStamp = dbBill.dateStamp;
    this.income = dbBill.income;
    this.salary = dbBill.salary;
  }
}
