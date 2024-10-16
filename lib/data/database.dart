import 'package:hive_flutter/hive_flutter.dart';

class ToDoDataBase {
  List toDoList = [];

  final _myBox = Hive.box("mybox");

  void createInitialData() {
    toDoList = [
      ["Your First Task", false, false]
    ];
  }

  // load the data from db
  void loadData() {
    toDoList = _myBox.get("TODOLIST");
  }

  // update the db
  void updateDataBase() {
    _myBox.put("TODOLIST", toDoList);
  }
}