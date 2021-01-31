import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';

//import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

class DatabaseHelper{

  String registrationDataTable = "Login";
  String QueryDataTable = "ContactQuery";
  String BackupDataTable = "ContactBackup";


  static final DatabaseHelper _instance = new DatabaseHelper.internal();
  factory DatabaseHelper() => _instance;

  static Database _db;

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();
    return _db;
  }

  DatabaseHelper.internal();

  initDb() async {
    //Get the directory path for both Android and iOS to store database.
    //Directory documentDirectory = await getApplicationDocumentsDirectory();
    //Open/create the database at a given path
    final String databasePath = await getDatabasesPath();
    String path = p.join(databasePath, "dix_database_devdb.db");
    //String path = p.join(documentDirectory.path, "adjemin_devdb.db");
    var ourDb = await openDatabase(path, version: 2, onCreate: _createDb);
    return ourDb;
  }

  void _createDb(Database db, int newVersion) async{
    await db.execute("CREATE TABLE Login(id INTEGER PRIMARY KEY AUTOINCREMENT, data TEXT)");
    await db.execute("CREATE TABLE $QueryDataTable(id INTEGER PRIMARY KEY AUTOINCREMENT, data TEXT)");
    await db.execute("CREATE TABLE $BackupDataTable(id INTEGER PRIMARY KEY AUTOINCREMENT, data TEXT)");
    print("Table is created");
  }
   Future<List<Map<String, dynamic>>> getDataMapList() async{
      Database dbClient = await this.db;
      var result = dbClient.query(registrationDataTable, limit: 1);
      return result;
   }

  Future<List<Map<String, dynamic>>> getQueryMapList() async{
    Database dbClient = await this.db;
    var result = dbClient.query(QueryDataTable);
    return result;
  }

  Future<List<Map<String, dynamic>>> getBackupMapList() async{
    Database dbClient = await this.db;
    var result = dbClient.query(BackupDataTable);
    return result;
  }

  Future<int> insertQueryData(Map<String, dynamic> profile) async {
    print(" =>>>> INSERT $profile");
    Database dbClient = await this.db;
    return dbClient.insert(QueryDataTable, profile);
  }

  Future<int> insertBackup(Map<String, dynamic> profile) async {
    print(" =>>>> INSERT $profile");
    Database dbClient = await this.db;
    return dbClient.insert(BackupDataTable, profile);
  }

  Future<List<Map<String, dynamic>>> findQueryData(String query) async{
    Database dbClient = await this.db;
    return dbClient.rawQuery("SELECT * FROM $QueryDataTable WHERE query LIKE ?", ["%$query%"]);
  }

  Future<int> deleteAllQueryData() async{
    Database dbClient = await this.db;
    return dbClient.rawDelete("DELETE FROM $QueryDataTable");
  }

  Future<int> deleteAllBackup() async{
    Database dbClient = await this.db;
    return dbClient.rawDelete("DELETE FROM $BackupDataTable");
  }



  Future<int> insertRegistrationData(Map<String, dynamic> profile) async {
    print(" =>>>> INSERT $profile");
    Database dbClient = await this.db;
    return dbClient.insert(registrationDataTable, profile);
  }


  Future<int> deleteRegistrationData(int id) async{
    Database dbClient = await this.db;
    return dbClient.rawDelete("DELETE FROM $registrationDataTable WHERE id = $id");
  }


  Future<int> deleteAllRegistrationData() async{
    Database dbClient = await this.db;
    return dbClient.rawDelete("DELETE FROM $registrationDataTable");
  }



}