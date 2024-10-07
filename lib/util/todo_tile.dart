import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class TodoTile extends StatelessWidget {
  final String task;
  final VoidCallback onRemove;
  final VoidCallback onEdit;
  final bool taskCompleted;
  final Function(bool?)? onChanged;
  final Function(BuildContext)? deleteFunction;
  final Function(BuildContext)? editFunction;

  const TodoTile({
    super.key, 
    required this.task, 
    required this.onRemove, 
    required this.onEdit,
    required this.taskCompleted,
    required this.onChanged,
    required this.deleteFunction,
    required this.editFunction,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 30, right: 30, top: 30),
      child: Slidable(
        startActionPane: ActionPane(
          motion: StretchMotion(), 
          children: [
            SlidableAction(
              onPressed: editFunction,
              icon: Icons.edit,
              backgroundColor: Colors.blue.shade300,
              borderRadius: BorderRadius.circular(12),
            )
          ]
        ),
        endActionPane: ActionPane(
          motion: StretchMotion(), 
          children: [
            SlidableAction(
              onPressed: deleteFunction,
              icon: Icons.delete,
              backgroundColor: Colors.red.shade300, 
              borderRadius: BorderRadius.circular(12), 
            )
          ]
        ),
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
      ),
    );
  }
}