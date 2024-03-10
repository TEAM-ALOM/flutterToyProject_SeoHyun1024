import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todolist/screens/add_list_screen.dart';
import 'package:todolist/models/todo_items.dart';
import 'package:todolist/widgets/list_card.dart';

class HomeScreen extends StatelessWidget {
  final backColor = const Color(0xFFF7E8A5);

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backColor,
      appBar: AppBar(
        title: const Text(
          'TodoList',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: backColor,
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const AddList(),
                ),
              );
            },
          ),
        ],
        surfaceTintColor: Colors.white,
        shadowColor: Colors.black,
        elevation: 1,
      ),
      body: const Column(
        children: [
          ListCard(name: '오늘의 할 일'),
          ListCard(name: '일주일 간 해야 할 일'),
          ListCard(name: '이번 달의 할 일'),
          ListCard(name: '지금 할 일'),
        ],
      ),
    );
  }
}

class ToDoDatabase {
  List<ToDoItem> toDoList = [];
  final _myBox = Hive.box('mybox');

  void createInitialData() {
    toDoList = [];
  }

  void loadDate() {
    var loadedDate = _myBox.get("TODOLIST") as List<dynamic>? ?? [];
    toDoList = loadedDate
        .map((item) {
          if (item is Map) {
            return ToDoItem.fromMap(item.cast<String, dynamic>());
          }
          return null;
        })
        .where((item) => item != null)
        .cast<ToDoItem>()
        .toList();
  }

  void updateDataBase() {
    _myBox.put("TODOLIST", toDoList.map((e) => e.toMap()).toList());
  }
}
