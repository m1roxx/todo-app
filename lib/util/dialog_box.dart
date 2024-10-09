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
        decoration: const InputDecoration(
          hintText: "Enter task", 
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.black)
          )
        ), 
        cursorColor: Colors.black,
        cursorErrorColor: Colors.black,
      ),
      actions: [
        TextButton(
          onPressed: onSave, 
          child: const Text(
            "Save",
            style: TextStyle(
              color: Colors.blueAccent,
              
            ),  
          ),
        ),

        TextButton(
          onPressed: onCancel, 
          child: const Text(
            "Cancel",
            style: TextStyle(
              color: Colors.blueAccent,
            ),
          )
        ),
      ],
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    );
  }
}