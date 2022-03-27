import 'package:floor/floor.dart';

@Entity(tableName: "user")
class User {
  @PrimaryKey(autoGenerate: true)
  int? uid;

  int no = 0;

  String? name; // 保留字段
  @ignore
  bool u_selected = false;

  User(this.no, {this.uid, this.name, this.u_selected = false});
}
