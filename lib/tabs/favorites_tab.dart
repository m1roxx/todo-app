import 'package:flutter/material.dart';
import 'package:practice_todo_app/util/todo_tile.dart';

class FavoritesTab extends StatelessWidget {
  final List favoriteTasks;
  final Function(int) markFavorite;
  final Function(int) removeTask;
  final Function(int) editTask;
  final Function(bool?, int) checkBoxChanged;

  const FavoritesTab({
    super.key, 
    required this.favoriteTasks,
    required this.markFavorite,
    required this.removeTask,
    required this.editTask,
    required this.checkBoxChanged,
  });

  @override
  Widget build(BuildContext context) {
    if (favoriteTasks.isEmpty) {
      return Padding(
        padding: const EdgeInsets.all(65.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "No starred tasks",
                  style: TextStyle(
                    fontSize: 27,
                  ),  
                ),
              ),
        
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Mark important tasks with a star so you can easily find them here",
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
        itemCount: favoriteTasks.length,
        itemBuilder: (context, index) {
          return TodoTile(
            task: favoriteTasks[index][0],
            taskCompleted: favoriteTasks[index][1],
            isFavorite: favoriteTasks[index][2],
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