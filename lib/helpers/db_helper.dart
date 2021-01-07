import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;

class DBHelper {
  static Future<sql.Database> database() async {
    final dbPath = await sql.getDatabasesPath();
    return sql.openDatabase(
      path.join(dbPath, 'installations.db'),
      onCreate: (db, version) {
        db.execute('CREATE TABLE config(id TEXT PRIMARY KEY, showengage TEXT)');
        db.execute('''
          CREATE TABLE projects(
            id INTEGER PRIMARY KEY, 
            title TEXT, 
            installation_id INTEGER,
            status TEXT,
            plandate INTEGER,
            startdate INTEGER, 
            enddate INTEGER)
          '''
          );

        db.execute('''
        CREATE TABLE project_steps(
          project_id INTEGER NOT NULL,
          step INTEGER NOT NULL,
          title TEXT,
          status TEXT,
          planDate INTEGER,
          startDate INTEGER,
          endDate INTEGER,
          PRIMARY KEY (project_id, step))
        '''
        );

        return db.execute('''CREATE TABLE user_installations(
              id INTEGER PRIMARY KEY, 
              title TEXT, 
              address TEXT, 
              city TEXT, 
              dp TEXT, 
              state TEXT,  
              powerinstalled TEXT, 
              comsumption TEXT, 
              facadeavailabiity TEXT, 
              orientation TEXT, 
              image TEXT, 
              loc_lat REAL, 
              loc_lng REAL,
              project_id INTEGER)
              '''
              );
      },
      version: 1,
    );
  }

  static Future<void> insert(String table, Map<String, Object> data) async {
    final db = await DBHelper.database();
    db.insert(
      table,
      data,
      conflictAlgorithm: sql.ConflictAlgorithm.replace,
    );
  }

  static Future<List<Map<String, dynamic>>> getData(String table) async {
    final db = await DBHelper.database();
    return db.query(table);
  }
}
