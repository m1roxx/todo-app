import 'package:flutter/material.dart';
import 'package:practice_todo_app/util/todo_tile.dart';

class TasksTab extends StatelessWidget {
  final List toDoList;
  final Function(int) markFavorite;
  final Function(int) removeTask;
  final Function(int) editTask;
  final Function(bool?, int) checkBoxChanged;

  const TasksTab({
    super.key, 
    required this.toDoList,
    required this.markFavorite,
    required this.removeTask,
    required this.editTask,
    required this.checkBoxChanged,
  });

  @override
  Widget build(BuildContext context) {
    if (toDoList.isEmpty) {
      return Padding(
        padding: const EdgeInsets.all(65.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "All tasks completed",
                  style: TextStyle(
                    fontSize: 27,
                  ),  
                ),
              ),
        
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Nice work",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    
                  ),  
                ),
              ),
            ],
          )
        ),
      );
    }
    else {
      return ListView.builder(
        itemCount: toDoList.length,
        itemBuilder: (context, index) {
          return TodoTile(
            task: toDoList[index][0],
            taskCompleted: toDoList[index][1],
            isFavorite: toDoList[index][2],
            onFavorite: () => markFavorite(index),
            onRemove: () => removeTask(index),
            onEdit: () => editTask(index),
            onChanged: (value) => checkBoxChanged(value, index),
            deleteFunction: (context) => removeTask(index),
            editFunction: (context) => editTask(index),
          );
        },
      );
    }
  }
}