import 'package:flutter/material.dart';
//import 'package:hive_flutter/hive_flutter.dart';
import 'package:todolist/screens/home_screen.dart';

void main() async {
  runApp(const TodoList());
}

class TodoList extends StatelessWidget {
  const TodoList({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomeScreen(),
    );
  }
}
