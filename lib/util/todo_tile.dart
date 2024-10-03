import 'package:flutter/material.dart';

class TodoTile extends StatelessWidget {
  final String task;
  final VoidCallback onRemove;
  final VoidCallback onEdit;
  final bool taskCompleted;
  final Function(bool?)? onChanged;

  const TodoTile({
    super.key, 
    required this.task, 
    required this.onRemove, 
    required this.onEdit,
    required this.taskCompleted,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 30, right: 30, top: 30),
      child: Container(
        padding: const EdgeInsets.all(25),
        decoration: BoxDecoration(
          color: Colors.green[400],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Checkbox(
                  value: taskCompleted, 
                  onChanged: onChanged,
                  activeColor: Colors.green[900],
                  shape: const CircleBorder(),
                ),
                
                Text(
                  task,
                  style: TextStyle(
                    fontSize: 17,
                    decoration: taskCompleted 
                      ? TextDecoration.lineThrough
                      : TextDecoration.none,
                  ),  
                ),
              ],
            ),


            PopupMenuButton(
              color: Colors.green[200],
              icon: const Icon(Icons.more_vert),
              itemBuilder: (context) => [
                const PopupMenuItem(
                  value: "edit",
                  child: Text("Edit"),
                ),

                const PopupMenuItem(
                  value: "delete",
                  child: Text("Delete"),
                )
              ],

              onSelected: (value) {
                if (value == 'edit') {
                  onEdit();
                } 
                else if (value == 'delete') {
                  onRemove();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}