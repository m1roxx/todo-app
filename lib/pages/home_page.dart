import 'package:flutter/material.dart';
import 'package:practice_todo_app/tabs/favorites_tab.dart';
import 'package:practice_todo_app/tabs/tasks_tab.dart';
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

  List getFavoriteTasks() {
    return toDoList.where((task) => task[2] == true).toList();
  } 

  void addNewTask() {
    
    setState(() {
      if (_controller.text != "") {
        toDoList.add([_controller.text, false, false]);
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

  void markFavorite(int index) {
    setState(() {
      toDoList[index][2] = !toDoList[index][2];
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Center(
            child: Text(
              "Tasks",
              style: TextStyle(
                color: Colors.black,
              ),
              ),
          ),
          backgroundColor: Colors.white,
        ),
      
        floatingActionButton: FloatingActionButton(
          onPressed: createNewTask, 
          backgroundColor: Colors.white,
          elevation: 20,
          shape: const CircleBorder(),
          child: const Icon(Icons.add),
        ),
      
        body: Column(
          children: [
            TabBar(
              tabs: [
                Tab(
                  text: "Tasks",
                  
                ),

                Tab(
                  icon: Icon(Icons.star),
                )
              ] 
              
            ),

            Expanded(
              child: TabBarView(
                children: [
                  // Tasks tab
                  TasksTab(
                    toDoList: toDoList, 
                    markFavorite: markFavorite, 
                    removeTask: removeTask, 
                    editTask: editTask, 
                    checkBoxChanged: checkBoxChanged
                  ),
              
                  // Favorites tab
                  FavoritesTab(
                    favoriteTasks: getFavoriteTasks(), 
                    markFavorite: markFavorite, 
                    removeTask: removeTask, 
                    editTask: editTask, 
                    checkBoxChanged: checkBoxChanged
                  ),
                  
                ]
              ),
            ),

            
          ],
        )
      ),
    );
  }
}