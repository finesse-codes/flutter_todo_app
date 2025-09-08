import 'package:flutter/material.dart';
import 'package:koko_todo/data/database.dart';
import 'package:koko_todo/util/dialog_box.dart';
import 'package:koko_todo/util/todo_tile.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  // This widget is the root of your application.
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // reference the hive box
  final _myBox = Hive.box('mybox');
  ToDoDataBase db = ToDoDataBase();

  @override
  void initState() {
    super.initState();
    // if this is the 1st time ever opening the app, then create default data
    if (_myBox.get("TODOLIST") == null) {
      db.createInitialData();
    } else {
      // there already exists data
      db.loadData();
    }
  }

  // text controller
  final _controller = TextEditingController();
  // checkbox changed
  void checkBoxChanged(bool? value, int index) {
    setState(() {
      db.toDoList[index][1] = value ?? false;
    });
    db.updateDataBase(); // 🔑 persist change
  }

  void saveNewTask() {
    setState(() {
      db.toDoList.add([_controller.text, false]);
      _controller.clear();
    });
    db.updateDataBase(); // persist new task
    // get rid of damn dialog box
    Navigator.of(context).pop();
  }

  void createNewTask() {
    showDialog(
      context: context,
      builder: (context) => DialogBox(
        controller: _controller,
        onSave: saveNewTask,
        onCancel: () => Navigator.of(context).pop(),
      ),
    );
  }

  void deleteTask(int index) {
    setState(() {
      db.toDoList.removeAt(index);
    });
    db.updateDataBase(); // persist deletion
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[200],
      appBar: AppBar(
        backgroundColor: Colors.yellow,
        title: Center(child: Text('TO DO')),
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createNewTask,
        child: Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: db.toDoList.length,
        itemBuilder: (context, index) {
          final name = db.toDoList[index][0] as String;
          final done = db.toDoList[index][1] as bool;

          return ToDoTile(
            key: ValueKey(name), // important for slidable
            taskName: name,
            taskCompleted: done,
            onChanged: (value) => checkBoxChanged(value, index),
            deleteFunction: (ctx) => deleteTask(index),
          );
        },
      ),
    );
  }
}
