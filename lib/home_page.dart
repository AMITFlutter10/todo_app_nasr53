import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:todo_app_nasr53/cubit/tasks_cubit.dart';
import 'package:todo_app_nasr53/cubit/tasks_state.dart';
import 'package:todo_app_nasr53/data_base.dart';
import 'package:todo_app_nasr53/pages/delete_page.dart';
import 'package:todo_app_nasr53/pages/done_page.dart';
import 'package:todo_app_nasr53/pages/tasks_page.dart';
import 'package:todo_app_nasr53/widgets/default_form_filed.dart';

class HomePage extends StatelessWidget {
   HomePage({super.key});

  var titleController = TextEditingController();
  var timeController = TextEditingController();
  var dateController = TextEditingController();
  var scaffoldKey = GlobalKey<ScaffoldState>();
  bool isBottomSheet = false;
  var formKey = GlobalKey<FormState>();
  IconData iconsFlout = Icons.add;
  

  void changeBottomSheet({required IconData icon, required bool isShow}) {
    isBottomSheet = isShow;
    icon = iconsFlout;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TasksCubit, TasksState>(
     builder: (context, state) {
    return Scaffold(
      key: scaffoldKey,
       body:TasksCubit.get(context).screens[TasksCubit.get(context).currentIndex] ,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (isBottomSheet) {
            if (formKey.currentState!.validate()) {
              TasksCubit.get(context).insertDataBase(
                  title: titleController.text,
                  date: dateController.text,
                  time: titleController.text);
              Navigator.pop(context);
            }
          } else {
            changeBottomSheet(icon: Icons.add_box, isShow: true);
            scaffoldKey.currentState!.showBottomSheet((context) {
              return Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  height: 350,
                  color: Colors.grey[200],
                  padding: const EdgeInsets.all(20),
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        DefaultFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "please enter title";
                            }
                            return null;
                          },
                          controller: titleController,
                          keyboardType: TextInputType.text,
                          hintText: "Title",
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        DefaultFormField(
                          onTap: () {
                            // setState(() {
                            //   showTimePicker(
                            //           context: context,
                            //           initialTime: TimeOfDay.now())
                            //       .then((value) => timeController.text =
                            //           value!.format(context).toString());
                            // });
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "please enter time";
                            }
                            return null;
                          },
                          controller: timeController,
                          keyboardType: TextInputType.datetime,
                          hintText: "Time",
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        DefaultFormField(
                          onTap: () {
                            // setState(() {
                            //   showDatePicker(
                            //           context: context,
                            //           initialDate: DateTime.now(),
                            //           firstDate: DateTime.now(),
                            //           lastDate: DateTime.parse("2024-12-15"))
                            //       .then((value) {
                            //     dateController.text =
                            //         DateFormat.yMMMd().format(value!);
                            //   });
                            // });
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "please enter date";
                            }
                            return null;
                          },
                          controller: dateController,
                          keyboardType: TextInputType.datetime,
                          hintText: "Date",
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }).closed.then((value) {changeBottomSheet(icon: iconsFlout,
                isShow: false);});
          }
        },
        child: Icon(iconsFlout),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: TasksCubit.get(context).currentIndex,
        onTap: (index){
          // setState(() {
          //   currentIndex= index;
          //
          // });
          TasksCubit.get(context).changeNavBar(index);
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.task_sharp)
              ,label: "Tasks"  ),
          BottomNavigationBarItem(icon: Icon(Icons.done_all_sharp)
              ,label: "Done"  ),
          BottomNavigationBarItem(icon: Icon(Icons.delete)
              ,label: "Delete"  ),

        ],

      ),
    );
  },
);
  }
}
