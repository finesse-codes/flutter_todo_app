import 'package:flutter/material.dart';
import 'package:koko_todo/util/dialog_box.dart';
import 'package:koko_todo/util/todo_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  // This widget is the root of your application.
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // text controller
  final _controller = TextEditingController();

  // onCancel method
  // list of todo tasks
  final List<List<Object>> toDoList = [
    ["Make tutorial", false],
    ["Do exercise", false],
  ];
  // checkbox changed
  void checkBoxChanged(bool? value, int index) {
    setState(() {
      final current = toDoList[index][1] as bool;
      toDoList[index][1] = !current;
    });
  }

  void saveNewTask() {
    setState(() {
      toDoList.add([_controller.text, false]);
      _controller.clear();
    });
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
      toDoList.removeAt(index);
    });
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
        itemCount: toDoList.length,
        itemBuilder: (context, index) {
          final name = toDoList[index][0] as String;
          final done = toDoList[index][1] as bool;

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
