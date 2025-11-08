import 'package:hive_flutter/hive_flutter.dart';

class ToDoDataBase{
  List toDoList = [];

  //reference our box
  final _myBox = Hive.box("myBox");

  // run this method if this is the 1st time ever opening this app
  void createInitialData(){
    toDoList = [
      ["Make bed", false],
      ["Exercise", false],
    ];
  }

  // load the data from db
  void loadData(){
    toDoList = _myBox.get("TODOLIST");
  }

  // update db
  void updateDataBase(){
    _myBox.put("TODOLIST", toDoList);
  }

}