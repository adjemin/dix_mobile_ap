/**import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';

//import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

class DatabaseHelper{

  String registrationDataTable = "Login";
  String QueryDataTable = "ProductQuery";
  String ProductTable = "Product";

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
    String path = p.join(databasePath, "adjemin_local_db.db");
    //String path = p.join(documentDirectory.path, "adjemin_devdb.db");
    var ourDb = await openDatabase(path, version: 1, onCreate: _createDb);
    return ourDb;
  }

  void _createDb(Database db, int newVersion) async{
    await db.execute("CREATE TABLE Login(id INTEGER PRIMARY KEY AUTOINCREMENT, data TEXT)");
    await db.execute("CREATE TABLE $QueryDataTable(id INTEGER PRIMARY KEY AUTOINCREMENT, query TEXT)");
    await db.execute("CREATE TABLE $ProductTable(id INTEGER PRIMARY KEY AUTOINCREMENT, data TEXT)");
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

  Future<List<Map<String, dynamic>>> getProductMapList() async{
    Database dbClient = await this.db;
    var result = dbClient.query(ProductTable);
    return result;
  }

   Future<int> insertRegistrationData(Map<String, dynamic> profile) async {
    //print(" =>>>> INSERT $profile");
    Database dbClient = await this.db;
    return dbClient.insert(registrationDataTable, profile);
  }

  Future<int> insertQueryData(Map<String, dynamic> profile) async {
    //print(" =>>>> INSERT $profile");
    Database dbClient = await this.db;
    return dbClient.insert(QueryDataTable, profile);
  }

  Future<int> insertProduct(Map<String, dynamic> profile) async {
    //print(" =>>>> INSERT $profile");
    Database dbClient = await this.db;
    return dbClient.insert(ProductTable, profile);
  }

  Future<List<Map<String, dynamic>>> findQueryData(String query) async{
    Database dbClient = await this.db;
    return dbClient.rawQuery("SELECT * FROM $QueryDataTable WHERE query LIKE ?", ["%$query%"]);
  }


  Future<int> deleteRegistrationData(int id) async{
    Database dbClient = await this.db;
    return dbClient.rawDelete("DELETE FROM $registrationDataTable WHERE id = $id");
  }

  Future<int> deleteQueryData(int id) async{
    Database dbClient = await this.db;
    return dbClient.rawDelete("DELETE FROM $QueryDataTable WHERE id = $id");
  }

  Future<int> deleteQueryByText(String query) async{
    Database dbClient = await this.db;
    return dbClient.rawDelete("DELETE FROM $QueryDataTable WHERE query = ?",[query]);
  }

  Future<int> deleteAllRegistrationData() async{
    Database dbClient = await this.db;
    return dbClient.rawDelete("DELETE FROM $registrationDataTable");
  }

  Future<int> deleteAllQueryData() async{
    Database dbClient = await this.db;
    return dbClient.rawDelete("DELETE FROM $QueryDataTable");
  }

  Future<int> deleteAllProduct() async{
    Database dbClient = await this.db;
    return dbClient.rawDelete("DELETE FROM $ProductTable");
  }



}*/