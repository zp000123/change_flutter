import 'package:change/entity/User.dart';
import 'package:floor/floor.dart';

/// 业绩/ 工资
@Entity(
    tableName: "performance",
    indices: [
  Index(value: ["userId"], unique: false)
], foreignKeys: [
  ForeignKey(
      childColumns: ["userId"],
      parentColumns: ["uid"],
      entity: User,
      onDelete: ForeignKeyAction.cascade)
])
class Performance {
  @PrimaryKey(autoGenerate: true)
  int? pid;

  @ColumnInfo(name: "userId")
  int userId;
  int dateStamp;
  int income;
  int salary;

  // 位置构造器
  Performance(this.userId, this.dateStamp, this.income, this.salary);

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'dateStamp': dateStamp,
      'income': income,
      'salary': salary,
      'pid': pid,
    };
  }
}
