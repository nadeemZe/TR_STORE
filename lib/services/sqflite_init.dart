import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';


class SQLiteInit {
  SQLiteInit._();

  static SQLiteInit? _instance;

  static SQLiteInit get instance {
    _instance ??= SQLiteInit._();
    return _instance!;
  }

   final String databaseName = 'Nadeem.db';

  Database? _db;

  Future<Database> get db => _initDatabase();


  Future<Database> _initDatabase() async {

    String databasePath = await getDatabasesPath();
    String path = join(databasePath, databaseName);

    return _db??= await openDatabase(
                          path,
                          version:1,
                          onCreate: _onCreate,
                        );

  }


  Future _onCreate(Database db, int version) async{
    await db.execute('''
    
      CREATE TABLE cart(
          id INTEGER PRIMARY KEY,
          productName TEXT,
          price INTEGER,
          productAmount INTEGER
      )
      
    ''');

  }


}
