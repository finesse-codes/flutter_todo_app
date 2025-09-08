import 'package:hive_flutter/hive_flutter.dart';

class ToDoDataBase {
  List toDoList = [];
  // reference the box
  final _myBox = Hive.box('mybox');

  // run this method on the first time opening this app
  void createInitialData() {
    toDoList = [
      ["Make tutorial", false],
      ["Do Exercise", false],
    ];
    updateDataBase(); // save initial data
  }

  void loadData() {
    toDoList = _myBox.get("TODOLIST");
  }

  // update the database
  void updateDataBase() {
    _myBox.put("TODOLIST", toDoList);
  }
}
