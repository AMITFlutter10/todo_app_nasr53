import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

// // crud
// late Database database ;
// createDataBase()async{
//   // // Get a location using getDatabasesPath
//   var databasesPath = await getDatabasesPath();
//   var path = join(databasesPath ,"todo.db" );
// //data/user/0/com.example.todo_app_nasr53/databases/todo.db
//    database = await openDatabase(path, version: 1 ,
//    onCreate: (database , int version)async{
//      await database.execute(
//          'CREATE TABLE tasks (id INTEGER PRIMARY KEY, title TEXT, date TEXT,time TEXT, status TEXT)').
//      then((value) => print("table created"));
//    }, onOpen: (database){
//         print("table open");
//          getDataBase(database);
//       }
//   );
// }
// insertDataBase({
//  required String title,
//  required String date,
//   String? status,
//  required String time,
// }){
//    database.transaction((txn)async {
//      await txn.rawInsert(
//          'INSERT INTO tasks(title, date, time,status ) VALUES($title, $date, $time ,"onHoled")');
//    }).then((value) {
//      print("${value} inserted ");
//     // getDataBase();
//      },
//    );
// }
// updateDataBase({String? title , String? date ,String? time, int? id})async{
//   await database.rawUpdate('UPDATE tasks SET title = ?, date = ? time = ? ,WHERE id = ?',
//       [title, date, time, id]).then((value) { print("$value updated ");
//       //getDataBase();
//       });
// }
// updateStatus({String? status,  int? id})async{
//   await database.rawUpdate('UPDATE tasks SET status = ? ,WHERE id = ?',
//       [status, id]).then((value) { print("$value updated ");
//     //getDataBase();
//   });
// }
// deleteDataBase({int? id}){
//   database.rawDelete('DELETE FROM tasks WHERE id = ?', [id]).then((value) => print("$value deleted"));
// }
//
// List<Map> tasks =[];
// getDataBase(Database dataBase )async{
//  database.rawQuery('SELECT * FROM tasks').then((value) {
//  for(Map<String , dynamic> element in value ){
//        tasks.add(element);
//  }});}
