import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todolist/screens/add_list_screen.dart';
import 'package:todolist/widgets/list_card.dart';
import 'package:todolist/services/todo_items.dart';

class HomeScreen extends StatelessWidget {
  final backColor = const Color(0xFFF7E8A5);

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backColor,
      appBar: AppBar(
        title: const Text(
          '✓ TodoList',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        toolbarHeight: 55,
        backgroundColor: backColor,
        actions: [
          IconButton(
            icon: const Icon(
              Icons.add,
              size: 45,
            ),
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
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: ValueListenableBuilder(
            valueListenable: Hive.box('settings').listenable(),
            builder: _buildWithBox,
          ),
        ),
      ),
    );
  }

  Widget _buildWithBox(BuildContext context, Box settings, Widget? child) {
    var reversed = settings.get('reversed', defaultValue: true) as bool;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Expanded(
          child: ValueListenableBuilder<Box<Todo>>(
            valueListenable: Hive.box<Todo>('todos').listenable(),
            builder: (context, box, _) {
              var todos = box.values.toList().cast<Todo>();
              if (reversed) {
                todos = todos.reversed.toList();
              }
              //return ListCard(todos);
              if (todos.isEmpty) {
                return const Center(
                  child: Text(
                    '할 일이 없습니다😭...\n그럴리가 없을텐데!!!',
                    style: TextStyle(
                      fontSize: 30,
                    ),
                  ),
                );
              } else {
                return SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: [
                      ListCard(
                        todos: todos,
                        subTitle: '오늘의 할 일',
                        number: 0,
                      ),
                      ListCard(
                        todos: todos,
                        subTitle: '일주일 간 해야 할 일',
                        number: 1,
                      ),
                      ListCard(
                        todos: todos,
                        subTitle: '이번 달의 할 일',
                        number: 2,
                      ),
                      ListCard(
                        todos: todos,
                        subTitle: '지금 할 일',
                        number: 3,
                      ),
                    ],
                  ),
                );
              }
            },
          ),
        ),
      ],
    );
  }
}
