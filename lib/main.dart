import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todolist/screens/home_screen.dart';
import 'package:todolist/services/todo_items.dart';

void main() async {
  await Hive.initFlutter();

  Hive.registerAdapter(TodoAdapter());
  runApp(const TodoList());
}

class TodoList extends StatelessWidget {
  const TodoList({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          maxWidth: 600,
        ),
        child: FutureBuilder(
            future: Future.wait([
              Hive.openBox('settings'),
              Hive.openBox<Todo>('todos'),
            ]),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.error != null) {
                  print(snapshot.error);
                  return const Scaffold(
                    body: Center(
                      child: Text('Something went wrong :C'),
                    ),
                  );
                } else {
                  return const HomeScreen();
                }
              } else {
                return const Scaffold(
                  body: Center(
                    child: Text('Opening Hive...'),
                  ),
                );
              }
            }),
      ),
    ));
  }
}
