import 'package:flutter/material.dart';
import 'package:practice_todo_app/util/dialog_box.dart';
import 'package:practice_todo_app/util/todo_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final TextEditingController _controller = TextEditingController();

  List toDoList = [];

  void addNewTask() {
    
    setState(() {
      if (_controller.text != "") {
        toDoList.add([_controller.text, false]);
      }
      _controller.clear();
    });
    Navigator.of(context).pop();
  }

  void removeTask(int index) {
    setState(() {
      toDoList.removeAt(index);
    });
  }

  void createNewTask() {

    showDialog(
      context: context,
      builder: (context) {
      return DialogBox(
        controller: _controller, 
        onSave: addNewTask,
        onCancel:() => Navigator.of(context).pop(), 
        );
      },
    );
  }

  void editTask(int index) {
    final TextEditingController _editController = TextEditingController(text: toDoList[index][0]);
    showDialog(
      context: context, 
      builder: (context) {
      return DialogBox(
        controller: _editController, 
        onCancel: () => Navigator.of(context).pop(), 
        onSave: () {
          setState(() {
            toDoList[index][0] = _editController.text;
          });
          Navigator.of(context).pop();
        },
        );
      }
    );
  }

  void checkBoxChanged(bool? value, int index) {
    setState(() {
      toDoList[index][1] = !toDoList[index][1];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[200],
      appBar: AppBar(
        title: const Center(
          child: Text(
            "TO DO",
            style: TextStyle(
              color: Colors.black,
            ),
            ),
        ),
        backgroundColor: Colors.green[400],
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: createNewTask, 
        backgroundColor: Colors.green[500],
        elevation: 0,
        shape: const CircleBorder(),
        child: const Icon(Icons.add),
      ),

      body: ListView.builder(
        itemCount: toDoList.length,
        itemBuilder:(context, index) {
          return TodoTile(
            task: toDoList[index][0],
            taskCompleted: toDoList[index][1],
            onRemove: () => removeTask(index),
            onEdit: () => editTask(index),
            onChanged:(value) => checkBoxChanged(value, index),
            deleteFunction: (context) => removeTask(index),
            editFunction: (context) => editTask(index),
          );
        },
      )
    );
  }
}