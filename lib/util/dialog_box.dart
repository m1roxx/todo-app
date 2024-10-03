import 'package:flutter/material.dart';

class DialogBox extends StatelessWidget {

  final TextEditingController controller;
  final VoidCallback onSave;
  final VoidCallback onCancel;

  const DialogBox({
    super.key,
    required this.controller, 
    required this.onCancel,
    required this.onSave
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: TextField(
        controller: controller,
        decoration: const InputDecoration(hintText: "Enter task"), 
      ),
      actions: [
        TextButton(
          onPressed: onSave, 
          child: const Text(
            "Save",
            style: TextStyle(
              color: Colors.black
            ),  
          ),
        ),

        TextButton(
          onPressed: onCancel, 
          child: const Text(
            "Cancel",
            style: TextStyle(
              color: Colors.black
            ),
          )
        ),
      ],
      backgroundColor: Colors.green[200],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    );
  }
}