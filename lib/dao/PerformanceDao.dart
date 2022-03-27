import 'package:change/entity/Performance.dart';
import 'package:floor/floor.dart';

/// 业绩、工资相关的数据表操作类
@dao
abstract class PerformanceDao {
  /// 查询所有的业绩工资数据 */
  @Query("SELECT * from performance")
  Future<List<Performance>> queryAll();

  /// 插入数据 */
  @Insert(onConflict: OnConflictStrategy.abort)
  Future<void> insert(Performance data);

  /// 删除数据 */
  @delete
  Future<void> deleteEntity(Performance data);

  /// 根据主键删除业绩工资记录 */
  @Query("DELETE  From performance WHERE pid=:pid")
  Future<void> deleteById(int pid);

  /// 根据日期删除员工的业绩工资记录 */
  @Query(
      "DELETE  From performance WHERE userId=:uId AND dateStamp  BETWEEN :minDate AND :maxDate")
  Future<void> deleteByDate(int uId, int minDate, int maxDate);

  /// 根据日期计算总收入 */
  @Query(
      "SELECT  SUM(performance.income)  From performance WHERE  dateStamp   BETWEEN :minDate AND :maxDate")
  Future<int?> sumIncomeByDate(int minDate, int maxDate);

  /// 根据日期计算总薪水 */
  @Query(
      "SELECT  SUM(performance.salary)  From performance WHERE  dateStamp   BETWEEN :minDate AND :maxDate")
  Future<int?> sumSalaryByDate(int minDate, int maxDate);
}
