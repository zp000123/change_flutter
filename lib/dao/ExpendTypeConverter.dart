import 'package:change/entity/Expend.dart';
import 'package:floor/floor.dart';

class ExpendTypeConverter extends TypeConverter<ExpendType, int> {
  @override
  ExpendType decode(int databaseValue) {
    return ExpendType.ofType(databaseValue);
  }

  @override
  int encode(ExpendType value) {
    return value.type;
  }
}
