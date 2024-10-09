import 'package:flutter/material.dart';
import 'package:practice_todo_app/pages/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
      theme: ThemeData(
        tabBarTheme: TabBarTheme(
          indicatorColor: Colors.blueAccent, 
          labelColor: Colors.blueAccent, 
          dividerColor: Colors.grey[350],
        ),
      )
    );
  }
}