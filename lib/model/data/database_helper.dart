import 'package:maknoon/model/core/enums.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static const databaseName = "maknoon.db";
  static const _databaseVersion = 1;

  static const tableEpisode = 'table_episode';
  static const tableStudentOfEpisode = 'table_student_of_episode';
  static const tablePlanLines = 'table_planLines';
  static const tableListenLine = 'table_listenLine';
  static const tableEducationalPlan = 'table_educational_plan';
  static const tableBehaviourTypes = 'table_behaviour_types';
  static const tableBehaviours = 'table_behaviours';
  static const tableStudentState = 'table_student_state';
  static const tableStudentGeneralBehavior = 'table_student_general_behavior';
  static const tableNewBehaviours = 'table_new_behaviours';

  static const columnId = 'id';

  // make this a singleton class
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  // only have a single app-wide reference to the database
  static Database? _database;
  Future<Database?> get database async {
    if (_database != null) return _database;
    // lazily instantiate the db the first time it is accessed
    _database = await _initDatabase();
    return _database;
  }

  // this opens the database (and creates it if it doesn't exist)
  _initDatabase() async {
    //Directory documentsDirectory = await getDatabasesPath();
    String path = join(await getDatabasesPath(), databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  // SQL code to create the database table
  Future _onCreate(Database db, int version) async {
    await db.execute(
        'CREATE TABLE $tableEpisode (${EpisodeColumns.id.value} INTEGER PRIMARY KEY, ${EpisodeColumns.name.value} TEXT, ${EpisodeColumns.displayName.value} TEXT, ${EpisodeColumns.epsdType.value} TEXT '
        ', ${EpisodeColumns.epsdWork.value} TEXT)');
    await db.execute(
        'CREATE TABLE $tableStudentOfEpisode ('
        '${StudentOfEpisodeColumns.id.value} INTEGER PRIMARY KEY,'
        '${StudentOfEpisodeColumns.age.value} INTEGER,'
        '${StudentOfEpisodeColumns.branchId.value} INTEGER,'
        '${StudentOfEpisodeColumns.isAbsent.value} INTEGER,'
        '${StudentOfEpisodeColumns.isAbsentExcuse.value} INTEGER,'
        '${StudentOfEpisodeColumns.isDely.value} INTEGER,'
        '${StudentOfEpisodeColumns.isNotRead.value} INTEGER,'
        '${StudentOfEpisodeColumns.periodId.value} INTEGER,'
        '${StudentOfEpisodeColumns.planId.value} INTEGER,'
        '${StudentOfEpisodeColumns.rate.value} INTEGER,'
        '${StudentOfEpisodeColumns.sessionId.value} INTEGER,'
        '${StudentOfEpisodeColumns.studentId.value} INTEGER,'
        '${StudentOfEpisodeColumns.typeExamId.value} INTEGER,'
        '${StudentOfEpisodeColumns.name.value} TEXT,'
        '${StudentOfEpisodeColumns.state.value} TEXT,'
        '${StudentOfEpisodeColumns.track.value} TEXT,'
        '${StudentOfEpisodeColumns.generalBehaviorType.value} TEXT,'
        '${StudentOfEpisodeColumns.testRegister.value} INTEGER,'
        '${StudentOfEpisodeColumns.episodeId.value} INTEGER,'
        '${StudentOfEpisodeColumns.stateDate.value} TEXT,'
        'FOREIGN KEY (${StudentOfEpisodeColumns.episodeId.value}) REFERENCES $tableEpisode (${StudentOfEpisodeColumns.id.value}) ON DELETE NO ACTION ON UPDATE NO ACTION'
        ')');
    await db.execute(
        'CREATE TABLE $tablePlanLines ('
        '${PlanLinesColumns.listen.value} TEXT,'
        '${PlanLinesColumns.reviewbig.value} TEXT,'
        '${PlanLinesColumns.reviewsmall.value} TEXT,'
        '${PlanLinesColumns.tlawa.value} TEXT,'
        '${PlanLinesColumns.studentId.value} INTEGER,'
        '${PlanLinesColumns.episodeId.value} INTEGER' 
        ')');
       await db.execute(
        'CREATE TABLE $tableStudentState ('
        '${StudentStateColumns.studentId.value} INTEGER,'
        '${StudentStateColumns.state.value} TEXT,'
        '${StudentStateColumns.date.value} TEXT,'
        '${StudentStateColumns.planId.value} INTEGER'
        ')');    
    await db.execute(
        'CREATE TABLE $tableListenLine ('
        '${ListenLineColumns.linkId.value} INTEGER,'
        '${ListenLineColumns.typeFollow.value} TEXT,'
        '${ListenLineColumns.actualDate.value} TEXT,'
        '${ListenLineColumns.fromSuraId.value} INTEGER,'
        '${ListenLineColumns.fromAya.value} INTEGER,'
        '${ListenLineColumns.toSuraId.value} INTEGER,' 
        '${ListenLineColumns.toAya.value} INTEGER,' 
        '${ListenLineColumns.totalMstkQty.value} INTEGER,' 
        '${ListenLineColumns.totalMstkQlty.value} INTEGER,' 
        '${ListenLineColumns.totalMstkRead.value} INTEGER' 
        ')');
    await db.execute(
        'CREATE TABLE $tableEducationalPlan ('
        '${EducationalPlanColumns.planListen.value} TEXT,'
        '${EducationalPlanColumns.planReviewbig.value} TEXT,'
        '${EducationalPlanColumns.planReviewSmall.value} TEXT,'
        '${EducationalPlanColumns.planTlawa.value} TEXT,'
        '${EducationalPlanColumns.studentId.value} INTEGER,'
        '${EducationalPlanColumns.episodeId.value} INTEGER' 
        ')');
    await db.execute(
        'CREATE TABLE $tableBehaviourTypes ('
        '${BehaviourTypesColumns.id.value} INTEGER,'
        '${BehaviourTypesColumns.name.value} TEXT'
        ')');
    await db.execute(
        'CREATE TABLE $tableBehaviours ('
        '${BehavioursColumns.linkId.value} INTEGER,'
        '${BehavioursColumns.name.value} TEXT'
        ')');
    await db.execute(
        'CREATE TABLE $tableNewBehaviours ('
        '${NewBehaviourColumns.planId.value} INTEGER,'
        '${NewBehaviourColumns.behaviorId.value} INTEGER,'
        '${NewBehaviourColumns.sendToParent.value} INTEGER,'
        '${NewBehaviourColumns.sendToTeacher.value} INTEGER'
        ')');
        await db.execute(
        'CREATE TABLE $tableStudentGeneralBehavior ('
        '${StudentGeneralBehaviorColumns.studentId.value} INTEGER,'
        '${StudentGeneralBehaviorColumns.generalBehavior.value} TEXT'
        ')');
   }

 
  Future<int?> insert(tableName, Map<String, dynamic> row) async {
    Database? db = await instance.database;
    return await db?.insert(tableName, row);
  }

  // All of the rows are returned as a list of maps, where each map is
  // a key-value list of columns.
  Future<Map<String, dynamic>?> queryRowByID(tableName, id) async {
    Database? db = await instance.database;
    var list =
        await db?.query(tableName, where: '$columnId = ?', whereArgs: [id]);
    return list?[0];
  }

  // All of the rows are returned as a list of maps, where each map is
  // a key-value list of columns.
  Future<List<Map<String, dynamic>>?> queryAllRows(
    tableName,
  ) async {
    Database? db = await instance.database;
    return await db?.query(tableName);
  }

  Future<List<Map<String, dynamic>>?> queryAllRowsWhere(
      tableName, nameColumn, value) async {
    Database? db = await instance.database;
    return await db
        ?.query(tableName, where: '$nameColumn = ?', whereArgs: [value]);
  }

  Future<List<Map<String, dynamic>>?> queryAllRowsWhereTowColumns(
      tableName,  column1, column2, value1, value2) async {
    Database? db = await instance.database;
    return await db
        ?.query(tableName, where: '$column1 = ? AND $column2 = ?', whereArgs: [value1, value2]);
  }

  // All of the methods (insert, query, update, delete) can also be done using
  // raw SQL commands. This method uses a raw query to give the row count.
  Future<int?> queryRowCount(tableName) async {
    Database? db = await instance.database;
    return Sqflite.firstIntValue(
        await db?.rawQuery('SELECT COUNT(*) FROM $tableName') ?? []);
  }

  Future<int?> queryRowCountWhere(tableName, nameColumn, value) async {
    Database? db = await instance.database;
    return Sqflite.firstIntValue(await db?.rawQuery(
            'SELECT COUNT(*) FROM $tableName WHERE $nameColumn = $value') ??
        []);
  }
  Future<int?> queryRowCountWhereNot(tableName, nameColumn, value) async {
    Database? db = await instance.database;
    return Sqflite.firstIntValue(await db?.rawQuery(
            'SELECT COUNT(*) FROM $tableName WHERE $nameColumn != $value') ??
        []);
  }

  Future<int?> queryRowCountWhereAnd(
      tableName, column1, column2, value1, value2) async {
    Database? db = await instance.database;
    return Sqflite.firstIntValue(await db?.rawQuery(
            "SELECT COUNT(*) FROM $tableName WHERE $column1 = $value1 AND $column2 = '$value2' ") ??
        []);
  }
  Future<int?> queryRowCountWhereAndInteger(
      tableName, column1, column2, value1, value2) async {
    Database? db = await instance.database;
    return Sqflite.firstIntValue(await db?.rawQuery(
            "SELECT COUNT(*) FROM $tableName WHERE $column1 = $value1 AND $column2 = '$value2' ") ??
        []);
  }

  // We are assuming here that the id column in the map is set. The other
  // column values will be used to update the row.
  Future<int?> update(tableName, Map<String, dynamic> row) async {
    Database? db = await instance.database;
    int id = row[columnId];
    return await db
        ?.update(tableName, row, where: '$columnId = ?', whereArgs: [id]);
  }

Future<int?> updateWhereAnd(
      tableName, Map<String, dynamic> row, column1, column2, value1, value2) async {
    Database? db = await instance.database;
    return await db?.update(tableName,row,
        where: '$column1 = ? AND $column2 = ?', whereArgs: [value1, value2]);
  }
  // Deletes the row specified by the id. The number of affected rows is
  // returned. This should be 1 as long as the row exists.
  Future<int?> delete(tableName, int id) async {
    Database? db = await instance.database;
    return await db?.delete(tableName, where: '$columnId = ?', whereArgs: [id]);
  }

  Future<int?> deleteAll(tableName) async {
    Database? db = await instance.database;
    return await db?.delete(tableName);
  }

  Future<int?> deleteAllWhere(tableName, nameColumn, value) async {
    Database? db = await instance.database;
    return await db
        ?.delete(tableName, where: '$nameColumn = ?', whereArgs: [value]);
  }

  Future<int?> deleteAllWhereAnd(
      tableName, column1, column2, value1, value2) async {
    Database? db = await instance.database;
    return await db?.delete(tableName,
        where: '$column1 = ? AND $column2 = ?', whereArgs: [value1, value2]);
  }
}
