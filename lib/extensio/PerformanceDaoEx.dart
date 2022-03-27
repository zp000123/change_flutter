import 'package:change/dao/PerformanceDao.dart';
import 'package:change/entity/Performance.dart';
import 'package:floor/floor.dart';

extension PerformanceDaoEx on PerformanceDao {
  /// 开启事务插入或替换数据。
  @transaction
  insertReplace(int uId, dateStamp, int income, int salary) {
    this.deleteByDate(
        uId, dateStamp.getMinDateStampDay(), dateStamp.getMaxDateStampDay());
    var data = Performance(uId, dateStamp, income, salary);
    this.insert(data);
  }
}
