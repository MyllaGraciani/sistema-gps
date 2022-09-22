import 'package:octagon_automation/database/sqflite/create_table.script.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class Connection {
  static Database? _database;

  static const _databaseName = "octagon_bd";
  static const _databaseVersion = 1;

  // torna esta classe singleton
  Connection._privateConstructor();
  static final Connection instance = Connection._privateConstructor();

  Future<Database?> get() async {
    if (_database != null) return _database;

    _database = await _initDatabase();
    return _database;
  }

  _initDatabase() async {
    String path = join(await getDatabasesPath(), _databaseName);
    return await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute(createTableUsuarios);
    await db.execute(createTableInstalacoes);
  }

  Future<List<Map<String, dynamic>>> queryAllRows(String table) async {
    Database? db = await instance.get();

    return await db!.query(table);
  }
}
