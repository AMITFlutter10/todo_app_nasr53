

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_app_nasr53/cubit/tasks_state.dart';
import 'package:path/path.dart';

import '../pages/delete_page.dart';
import '../pages/done_page.dart';
import '../pages/tasks_page.dart';
class TasksCubit extends Cubit<TasksState>{
  // CONSTRUCTOR
  TasksCubit(): super(TasksInitialState());
  // function => ui
static  TasksCubit get(context)=> BlocProvider.of(context);
// crud
//  1- loading
//  2- success
//  3- fail

  int currentIndex = 0;
  List<Widget> screens= [
  TasksPage(),
  DonePage(),
  DeletePage(),
  ];


  void changeNavBar(int index){
    currentIndex= index;
    emit(ChangeNavBarState());
  }


  late Database database ;
  createDataBase()async{
    // // Get a location using getDatabasesPath
    var databasesPath = await getDatabasesPath();
    var path = join(databasesPath ,"todo.db" );
//data/user/0/com.example.todo_app_nasr53/databases/todo.db
    database = await openDatabase(path, version: 1 ,
        onCreate: (database , int version)async{
          await database.execute(
              'CREATE TABLE tasks (id INTEGER PRIMARY KEY, title TEXT, date TEXT,time TEXT, status TEXT)').
          then((value) =>
              print("table created"));
        }, onOpen: (database){
          print("table open");
          getDataBase(database);

        }
    );
  }
  // background
  insertDataBase({
    required String title,
    required String date,
    String? status,
    required String time,
  }){
    database.transaction((txn)async {
      await txn.rawInsert(
          'INSERT INTO tasks(title, date, time,status ) VALUES($title, $date, $time ,"onHoled")');
    }).then((value) {
      print("$value inserted ");
      emit(InsertedDatabaseState());
      // getDataBase();
    },
    ).catchError((error){
      print(error);
      emit(InsertedErrorDatabaseState());
    });
  }
  updateDataBase({String? title , String? date ,String? time, int? id})async{
    emit(LoadingUpdateDatabaseState());
    await database.rawUpdate('UPDATE tasks SET title = ?, date = ? time = ? ,WHERE id = ?',
        [title, date, time, id]).then(
            (value) { print("$value updated ");
              emit(SuccessUpdateDatabaseState());
      //getDataBase();
    }).catchError((error){
      print(error);
      emit(ErrorUpdateDatabaseState());
    });
  }
  updateStatus({String? status,  int? id})async{
    await database.rawUpdate('UPDATE tasks SET status = ? ,WHERE id = ?',
        [status, id]).then((value) { print("$value updated ");
      //getDataBase();
    });
  }
  deleteDataBase({int? id}){
    database.rawDelete('DELETE FROM tasks WHERE id = ?', [id]).then((value) => print("$value deleted"));
  }

  List<Map> tasks =[];
  getDataBase(Database dataBase )async{
    emit(LoadingGetDatabaseState());
    database.rawQuery('SELECT * FROM tasks').then((value) {
      for(Map<String , dynamic> element in value ){
        tasks.add(element);
      }
      emit( SuccessGetDatabaseState());
    }

    ).catchError((error){
      print(error);
      emit( ErrorGetDatabaseState());
    });}
}