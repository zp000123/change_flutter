import 'package:change/entity/UserBill.dart';
import 'package:floor/floor.dart';

/// 用户业绩工资映射记录表操作类
@dao
abstract class UserBillDao {
  @Query("SELECT * from userbill")
  Future<List<UserBill>> queryAllUserBill();

  @Query(
      "SELECT * from userbill WHERE dateStamp BETWEEN :minDate AND :maxDate order by `no` asc")
  Future<List<UserBill>> queryBillByDate(int minDate, int maxDate);

  @Query(
      "SELECT * from userbill WHERE `no` = :no AND dateStamp BETWEEN :minDate AND :maxDate order by dateStamp  asc")
  Future<List<UserBill>> queryBillByNoAndDate(int no, int minDate, int maxDate);
}
