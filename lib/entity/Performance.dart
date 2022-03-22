/// 业绩/ 工资
class Performance {
  int userId;
  int dataStamp;
  int income;
  int salary;
  int pid = 0;

  // 位置构造器
  Performance(this.userId, this.dataStamp, this.income, this.salary);


  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'dataStamp': dataStamp,
      'income': income,
      'salary': salary,
      'pid': pid,
    };
  }
}
