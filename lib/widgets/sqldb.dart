import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SqlDb {

  static Database? _db ; 
  
  Future<Database?> get db async {
      if (_db == null){
        _db  = await intialDb() ;
        return _db ;  
      }else {
        return _db ; 
      }
  }


Future<Database> intialDb() async {
  String databasepath = await getDatabasesPath() ; 
  String path = join(databasepath , 'wael.db') ;   
  Database mydb = await openDatabase(path , onCreate: _onCreate , version: 3  , onUpgrade:_onUpgrade ) ;  
  return mydb ; 
}

void _onUpgrade(Database db , int oldversion , int newversion ) {


 print("onUpgrade =====================================") ; 
  
}

Future<void> _onCreate(Database db , int version) async {
  await db.execute('''
  CREATE TABLE "Tasksdb" (
    "id" INTEGER  NOT NULL PRIMARY KEY  AUTOINCREMENT, 
    "tasks" TEXT NOT NULL
  )
 ''') ;
 print(" onCreate =====================================") ; 

}

Future<List<Map<dynamic, dynamic>>> readData(String sql) async {
  Database? mydb = await db ; 
  List<Map> response = await  mydb!.rawQuery(sql);
  return response ; 
}
Future<int> insertData(String sql) async {
  Database? mydb = await db ; 
  int  response = await  mydb!.rawInsert(sql);
  return response ; 
}
Future<int> updateData(String sql) async {
  Database? mydb = await db ; 
  int  response = await  mydb!.rawUpdate(sql);
  return response ; 
}
Future<int> deleteData(String sql) async {
  Database? mydb = await db ; 
  int  response = await  mydb!.rawDelete(sql);
  return response ; 
}
 

 

}