// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'AppDatabase.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$AppDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AppDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  ExpendDao? _expendDaoInstance;

  UserDao? _userDaoInstance;

  PerformanceDao? _performanceDaoInstance;

  UserBillDao? _userBillDaoInstance;

  Future<sqflite.Database> open(String path, List<Migration> migrations,
      [Callback? callback]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 2,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `user` (`uid` INTEGER PRIMARY KEY AUTOINCREMENT, `no` INTEGER NOT NULL, `name` TEXT)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `performance` (`pid` INTEGER PRIMARY KEY AUTOINCREMENT, `userId` INTEGER NOT NULL, `dateStamp` INTEGER NOT NULL, `income` INTEGER NOT NULL, `salary` INTEGER NOT NULL, FOREIGN KEY (`userId`) REFERENCES `user` (`uid`) ON UPDATE NO ACTION ON DELETE CASCADE)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `expend` (`eId` INTEGER PRIMARY KEY AUTOINCREMENT, `type` INTEGER NOT NULL, `money` INTEGER NOT NULL, `dateStamp` INTEGER NOT NULL)');
        await database.execute(
            'CREATE INDEX `index_performance_userId` ON `performance` (`userId`)');
        await database.execute(
            'CREATE VIEW IF NOT EXISTS `userbill` AS SELECT user.uid, user.no, user.name, performance.pid, performance.dateStamp, performance.income, performance.salary FROM user INNER JOIN performance ON user.uid = performance.userId');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  ExpendDao get expendDao {
    return _expendDaoInstance ??= _$ExpendDao(database, changeListener);
  }

  @override
  UserDao get userDao {
    return _userDaoInstance ??= _$UserDao(database, changeListener);
  }

  @override
  PerformanceDao get performanceDao {
    return _performanceDaoInstance ??=
        _$PerformanceDao(database, changeListener);
  }

  @override
  UserBillDao get userBillDao {
    return _userBillDaoInstance ??= _$UserBillDao(database, changeListener);
  }
}

class _$ExpendDao extends ExpendDao {
  _$ExpendDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _expendInsertionAdapter = InsertionAdapter(
            database,
            'expend',
            (Expend item) => <String, Object?>{
                  'eId': item.eId,
                  'type': _expendTypeConverter.encode(item.type),
                  'money': item.money,
                  'dateStamp': item.dateStamp
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Expend> _expendInsertionAdapter;

  @override
  Future<List<Expend>> queryExpendList(int minDate, int maxDate) async {
    return _queryAdapter.queryList(
        'SELECT * from expend WHERE dateStamp BETWEEN ?1 AND ?2 order by type asc',
        mapper: (Map<String, Object?> row) => Expend(_expendTypeConverter.decode(row['type'] as int), row['money'] as int, row['dateStamp'] as int),
        arguments: [minDate, maxDate]);
  }

  @override
  Future<void> deleteById(int eId) async {
    await _queryAdapter
        .queryNoReturn('DELETE  From expend WHERE eId=?1', arguments: [eId]);
  }

  @override
  Future<void> delete(int type, int minDate, int maxDate) async {
    await _queryAdapter.queryNoReturn(
        'DELETE  From expend WHERE type=?1 AND dateStamp  BETWEEN ?2 AND ?3',
        arguments: [type, minDate, maxDate]);
  }

  @override
  Future<void> insert(Expend data) async {
    await _expendInsertionAdapter.insert(data, OnConflictStrategy.abort);
  }
}

class _$UserDao extends UserDao {
  _$UserDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _userInsertionAdapter = InsertionAdapter(
            database,
            'user',
            (User item) => <String, Object?>{
                  'uid': item.uid,
                  'no': item.no,
                  'name': item.name
                }),
        _userDeletionAdapter = DeletionAdapter(
            database,
            'user',
            ['uid'],
            (User item) => <String, Object?>{
                  'uid': item.uid,
                  'no': item.no,
                  'name': item.name
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<User> _userInsertionAdapter;

  final DeletionAdapter<User> _userDeletionAdapter;

  @override
  Future<List<User>> queryAllUser() async {
    return _queryAdapter.queryList('SELECT * from user order by `no`',
        mapper: (Map<String, Object?> row) => User(row['no'] as int,
            uid: row['uid'] as int?, name: row['name'] as String?));
  }

  @override
  Future<User?> queryUserByNo(int no) async {
    return _queryAdapter.query('SELECT * from user WHERE `no`=?1 limit 1',
        mapper: (Map<String, Object?> row) => User(row['no'] as int,
            uid: row['uid'] as int?, name: row['name'] as String?),
        arguments: [no]);
  }

  @override
  Future<void> deleteByNo(int newNo) async {
    await _queryAdapter
        .queryNoReturn('DELETE from user WHERE `no` =?1', arguments: [newNo]);
  }

  @override
  Future<int> insert(User user) {
    return _userInsertionAdapter.insertAndReturnId(
        user, OnConflictStrategy.replace);
  }

  @override
  Future<void> deleteUser(User user) async {
    await _userDeletionAdapter.delete(user);
  }
}

class _$PerformanceDao extends PerformanceDao {
  _$PerformanceDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _performanceInsertionAdapter = InsertionAdapter(
            database,
            'performance',
            (Performance item) => <String, Object?>{
                  'pid': item.pid,
                  'userId': item.userId,
                  'dateStamp': item.dateStamp,
                  'income': item.income,
                  'salary': item.salary
                }),
        _performanceDeletionAdapter = DeletionAdapter(
            database,
            'performance',
            ['pid'],
            (Performance item) => <String, Object?>{
                  'pid': item.pid,
                  'userId': item.userId,
                  'dateStamp': item.dateStamp,
                  'income': item.income,
                  'salary': item.salary
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Performance> _performanceInsertionAdapter;

  final DeletionAdapter<Performance> _performanceDeletionAdapter;

  @override
  Future<List<Performance>> queryAll() async {
    return _queryAdapter.queryList('SELECT * from performance',
        mapper: (Map<String, Object?> row) => Performance(
            row['userId'] as int,
            row['dateStamp'] as int,
            row['income'] as int,
            row['salary'] as int));
  }

  @override
  Future<void> deleteById(int pid) async {
    await _queryAdapter.queryNoReturn('DELETE  From performance WHERE pid=?1',
        arguments: [pid]);
  }

  @override
  Future<void> deleteByDate(int uId, int minDate, int maxDate) async {
    await _queryAdapter.queryNoReturn(
        'DELETE  From performance WHERE userId=?1 AND dateStamp  BETWEEN ?2 AND ?3',
        arguments: [uId, minDate, maxDate]);
  }

  @override
  Future<int?> sumIncomeByDate(int minDate, int maxDate) async {
    await _queryAdapter.queryNoReturn(
        'SELECT  SUM(performance.income)  From performance WHERE  dateStamp   BETWEEN ?1 AND ?2',
        arguments: [minDate, maxDate]);
  }

  @override
  Future<int?> sumSalaryByDate(int minDate, int maxDate) async {
    await _queryAdapter.queryNoReturn(
        'SELECT  SUM(performance.salary)  From performance WHERE  dateStamp   BETWEEN ?1 AND ?2',
        arguments: [minDate, maxDate]);
  }

  @override
  Future<void> insert(Performance data) async {
    await _performanceInsertionAdapter.insert(data, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteEntity(Performance data) async {
    await _performanceDeletionAdapter.delete(data);
  }
}

class _$UserBillDao extends UserBillDao {
  _$UserBillDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  @override
  Future<List<UserBill>> queryAllUserBill() async {
    return _queryAdapter.queryList('SELECT * from userbill',
        mapper: (Map<String, Object?> row) => UserBill(
            row['uid'] as int,
            row['no'] as int,
            row['name'] as String?,
            row['pid'] as int,
            row['dateStamp'] as int,
            row['income'] as int,
            row['salary'] as int));
  }

  @override
  Future<List<UserBill>> queryBillByDate(int minDate, int maxDate) async {
    return _queryAdapter.queryList(
        'SELECT * from userbill WHERE dateStamp BETWEEN ?1 AND ?2 order by `no` asc',
        mapper: (Map<String, Object?> row) => UserBill(row['uid'] as int, row['no'] as int, row['name'] as String?, row['pid'] as int, row['dateStamp'] as int, row['income'] as int, row['salary'] as int),
        arguments: [minDate, maxDate]);
  }

  @override
  Future<List<UserBill>> queryBillByNoAndDate(
      int no, int minDate, int maxDate) async {
    return _queryAdapter.queryList(
        'SELECT * from userbill WHERE `no` = ?1 AND dateStamp BETWEEN ?2 AND ?3 order by dateStamp  asc',
        mapper: (Map<String, Object?> row) => UserBill(row['uid'] as int, row['no'] as int, row['name'] as String?, row['pid'] as int, row['dateStamp'] as int, row['income'] as int, row['salary'] as int),
        arguments: [no, minDate, maxDate]);
  }
}

// ignore_for_file: unused_element
final _expendTypeConverter = ExpendTypeConverter();
