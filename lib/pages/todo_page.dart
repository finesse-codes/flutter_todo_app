import 'package:flutter/material.dart';

class ToDoPage extends StatefulWidget {
  const ToDoPage({super.key});

  // This widget is the root of your application.
  @override
  State<ToDoPage> createState() => _ToDoPageState();
}

class _ToDoPageState extends State<ToDoPage> {
  // text editing controller to get access to what the user typed
  TextEditingController myController = TextEditingController();
  String greetingMessage = "";
  String userName = myController.text;
  // greet user method
  void greetUser() {
    setState(() {
      greetingMessage = "Hello, " + userName;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // greet user message
            Text(greetingMessage),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: myController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "type your name",
                ),
              ),
            ),
            ElevatedButton(onPressed: greetUser, child: Text("Tap")),
          ],
        ),
      ),
    );
  }
}
