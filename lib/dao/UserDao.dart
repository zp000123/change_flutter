import 'package:change/entity/User.dart';
import 'package:floor/floor.dart';

/// 员工数据表操作类
@dao
abstract class UserDao {
  @Query("SELECT * from user order by `no`")
  Future<List<User>>   queryAllUser();

  @Query("SELECT * from user WHERE `no`=:no limit 1")
  Future<User?> queryUserByNo(int no);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<int> insert(User user);

  @delete
  Future<void> deleteUser(User user);

  @Query("DELETE from user WHERE `no` =:newNo")
  Future<void> deleteByNo(int newNo);
}
