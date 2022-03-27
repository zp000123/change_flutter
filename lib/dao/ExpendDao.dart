import 'package:change/entity/Expend.dart';
import 'package:floor/floor.dart';

/// 开销表操作类
@dao
abstract class ExpendDao {
  /// 根据时间查询开销表中的记录
  @Query(
      "SELECT * from expend WHERE dateStamp BETWEEN :minDate AND :maxDate order by type asc")
  Future<List<Expend>> queryExpendList(int minDate, int maxDate);

  /// 插入或替换数据 */
  @Insert(onConflict: OnConflictStrategy.abort)
  Future<void> insert(Expend data);

  /// 根据主键删除数据 */
  @Query("DELETE  From expend WHERE eId=:eId")
  Future<void> deleteById(int eId);

  /// 删除指定时间内的数据 */
  @Query(
      "DELETE  From expend WHERE type=:type AND dateStamp  BETWEEN :minDate AND :maxDate")
  Future<void> delete(int type, int minDate, int maxDate);
}
