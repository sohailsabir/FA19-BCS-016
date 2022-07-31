

import 'package:path/path.dart';
import 'package:ppa/db/passwordmodel.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

// class Databaseprovider{
//   Databaseprovider._();
//   static final Databaseprovider db=Databaseprovider._();
//   static Database? _database;
//
//   Future<Database>get database async{
//     if(_database!=null){
//       return _database!;
//     }
//     _database=await initDB();
//     return _database!;
//   }
//
//
//   initDB()async{
//     return await openDatabase(join(await getDatabasesPath(),'pass_db.db'),
//       onCreate: (db,version)async{
//       await db.execute('''
//       CREATE TABLE password(id INTEGER PRIMARY KEY AUTOINCREMENT,title TEXT,pass TEXT)''');
//       },version: 1
//     );
//   }
//
//   // addNewPasword(ModelPass password)async{
//   //   final db=await database;
//   //   db.insert("password", password.toMap(),conflictAlgorithm: ConflictAlgorithm.replace);
//   //
//   // }
//
//   insertData(table,data)async{
//     var connection=await database;
//     return await connection.insert(table, data);
//   }
//   readData(table)async{
//     var connection=await database;
//     return await connection.query(table);
//   }
//   readDataById(table,itemId)async{
//     var connection=await database;
//     return await connection.query(table,where: 'id=?',whereArgs: [itemId]);
//   }
//   updateData(table,data)async{
//     var connection=await database;
//     return await connection.update(table, data,where: 'id=?',whereArgs: [data['id']]);
//   }
//   deleteDataById(table,itemId)async{
//     var connection=await database;
//     return await connection.rawDelete("DELETE FROM $table WHERE id=$itemId");
//   }
//
//
//   // Future<dynamic>getPassword()async{
//   //   final db=await database;
//   //   var ref=await db.query("password");
//   //   if(ref.length==0){
//   //     return null;
//   //   }
//   //   else{
//   //     var resultMap=ref.toList();
//   //     return resultMap.isNotEmpty?resultMap:null;
//   //   }
//   // }
//   // detelePassword(int id)async{
//   //   final db=await database;
//   //   await db.rawDelete("DELETE FROM password WHERE id=?",[id]);
//   //
//   // }
//
//
// }
class DatabaseConnection{
  Future<Database>setDatabase() async {
    var directory = await getApplicationDocumentsDirectory();
    var path = join(directory.path, 'db_crud');
    var database =
    await openDatabase(path, version: 1, onCreate: _createDatabase);
    return database;
  }
  Future<void>_createDatabase(Database database, int version) async {
    String sql=
        "CREATE TABLE password(id INTEGER PRIMARY KEY,title TEXT,pass Text);";
    await database.execute(sql);
  }
}
