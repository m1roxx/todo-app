import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:practice_todo_app/data/database.dart';
import 'package:practice_todo_app/tabs/favorites_tab.dart';
import 'package:practice_todo_app/tabs/tasks_tab.dart';
import 'package:practice_todo_app/util/dialog_box.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _myBox = Hive.box("mybox");
  ToDoDataBase db = ToDoDataBase();

  @override
  void initState() {
    if (_myBox.get("TODOLIST") == null) {
      db.createInitialData();
    } else {
      db.loadData();
    }

    super.initState();
  }

  final TextEditingController _controller = TextEditingController();

  List getFavoriteTasks() {
    return db.toDoList.where((task) => task[2] == true).toList();
  } 

  void addNewTask() {
    
    setState(() {
      if (_controller.text != "") {
        db.toDoList.add([_controller.text, false, false]);
      }
      _controller.clear();
    });
    Navigator.of(context).pop();

    db.updateDataBase();
  }

  void removeTask(int index) {
    setState(() {
      db.toDoList.removeAt(index);
    });

    db.updateDataBase();
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

    db.updateDataBase();
  }

  void editTask(int index) {
    final TextEditingController _editController = TextEditingController(text: db.toDoList[index][0]);
    showDialog(
      context: context, 
      builder: (context) {
      return DialogBox(
        controller: _editController, 
        onCancel: () => Navigator.of(context).pop(), 
        onSave: () {
          setState(() {
            db.toDoList[index][0] = _editController.text;
          });
          Navigator.of(context).pop();
          db.updateDataBase();
        },
        );
      }
    );

    db.updateDataBase();
  }

  void checkBoxChanged(bool? value, int index) {
    setState(() {
      db.toDoList[index][1] = !db.toDoList[index][1];
    });

    db.updateDataBase();
  }

  void markFavorite(int index) {
    setState(() {
      db.toDoList[index][2] = !db.toDoList[index][2];
    });

    db.updateDataBase();
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
                    toDoList: db.toDoList, 
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