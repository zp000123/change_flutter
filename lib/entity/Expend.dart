import 'package:floor/floor.dart';

/// 开销的类型
/// 金额
/// 日期floor.dart';
@Entity(tableName: "expend")
class Expend {
  @PrimaryKey(autoGenerate: true)
  int? eId ;
  ExpendType type;
  int money = 0;
  int dateStamp = 0;

  Expend(this.type, this.money, this.dateStamp);
}

class ExpendType {
  int type;
  String des;

  ExpendType(this.type, this.des);
  /// 支出类型
  static ofType(int type) {
    var expendType;
    switch (type) {
      case 1:
        expendType = ExpendType(1, "生活开支");
        break;

      case 2:
        expendType = ExpendType(2, "水电燃气");
        break;
      case 3:
        expendType = ExpendType(3, "其他");
        break;
      case 4:
        expendType = ExpendType(4, "工资");
        break;
      case 5:
        expendType = ExpendType(5, "支取");
        break;
      case 6:
        expendType = ExpendType(6, "团购");
        break;
      case 7:
        expendType = ExpendType(7, "收钱吧");
        break;
      case 8:
        expendType = ExpendType(8, "口碑");
        break;
      case 9:
        expendType = ExpendType(9, "pos机");
    }
    return expendType;
  }
}

class ExpendTypeW {
  ExpendType expendType;
  bool u_selected = false;

  ExpendTypeW(this.expendType, {this.u_selected: false});

  static List<ExpendTypeW> getExpendTypeWList() {
    return List.of([
      ExpendTypeW(ExpendType(1, "生活开支"), u_selected: true),
      ExpendTypeW(ExpendType(2, "水电燃气")),
      ExpendTypeW(ExpendType(3, "其他")),
      ExpendTypeW(ExpendType(4, "工资")),
      ExpendTypeW(ExpendType(5, "支取")),
      ExpendTypeW(ExpendType(6, "团购")),
      ExpendTypeW(ExpendType(7, "收钱吧")),
      ExpendTypeW(ExpendType(8, "口碑")),
      ExpendTypeW(ExpendType(9, "pos机"))
    ]);
  }
}
