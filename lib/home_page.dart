import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_app_nasr53/data_base.dart';
import 'package:todo_app_nasr53/widgets/default_form_filed.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    createDataBase();
    super.initState();
  }
  var titleController =TextEditingController();
  var timeController =TextEditingController();
  var dateController =TextEditingController();
  var scaffoldKey = GlobalKey<ScaffoldState>();
  bool isBottomSheet = false;
  var formKey = GlobalKey<FormState>();
  IconData iconsFlout = Icons.add;
  void changeBottomSheet({required IconData icon ,required bool isShow }){
    isBottomSheet = isShow;
    icon = iconsFlout;
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      key: scaffoldKey,
      floatingActionButton: FloatingActionButton(onPressed: (){
        if(isBottomSheet){
          setState(() {
          if(formKey.currentState!.validate()){
            insertDataBase(title: titleController.text,
                           date: dateController.text,
                           time: titleController.text
            );
            Navigator.pop(context);
          }
          });
        }else {
          changeBottomSheet(icon: Icons.add_box, isShow: true);
          scaffoldKey.currentState!.showBottomSheet((context) {
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                height: 350,
                color: Colors.grey[200],
                padding: EdgeInsets.all(20),
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
                      const SizedBox(height: 10,),
                      DefaultFormField(
                        onTap: (){
                          setState(() {
                          showTimePicker(context: context,
                              initialTime: TimeOfDay.now()).then((value) =>
                          timeController.text = value!.format(context).toString()
                          );
                          });
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "please enter time";
                          }
                          return null;
                        },
                        controller: timeController,
                        keyboardType: TextInputType.datetime,
                        hintText: "Time",),
                      const SizedBox(height: 10,),
                      DefaultFormField(
                        onTap: (){
                          setState(() {
                           showDatePicker(context: context,
                               initialDate: DateTime.now(),
                               firstDate: DateTime.now(),
                               lastDate: DateTime.parse("2024-12-15")).then((value) {
                                 dateController.text =DateFormat.yMMMd().format(value!);

                           });});},
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "please enter date";
                          }
                          return null;
                        },
                        controller: dateController,
                        keyboardType: TextInputType.datetime,
                        hintText: "Date",),

                    ],
                  ),
                ),
              ),
            );
          });
        }},
        child: Icon(iconsFlout),),
    );
  }
}
