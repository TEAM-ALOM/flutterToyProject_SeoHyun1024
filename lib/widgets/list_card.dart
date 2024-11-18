//홈화면 카드들
import 'package:flutter/material.dart';
import 'package:todolist/services/todo_items.dart';

class ListCard extends StatelessWidget {
  final List<Todo> todos;
  final String subTitle;
  final int number;

  const ListCard({
    required this.todos,
    required this.subTitle,
    required this.number,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.all(5),
        child: Column(
          children: [
            ExpansionTile(
              title: Text(subTitle),
              children: [
                ListView.builder(
                    shrinkWrap: true,
                    itemCount: todos.length,
                    itemBuilder: (BuildContext context, int index) {
                      var todo = todos[index];
                      if (number == 0 &&
                          todo.dateTime.day == DateTime.now().day) {
                        return _buildTodo(todo);
                      } else if (number == 1 &&
                          DateTime.now().difference(todo.dateTime).inDays >=
                              -7) {
                        return _buildTodo(todo);
                      } else if (number == 2 &&
                          todo.dateTime.month == DateTime.now().month) {
                        return _buildTodo(todo);
                      } else if (number == 3) {
                        return _buildTodo(todo);
                      } else {
                        return Container();
                      }
                    }),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Widget _buildTodo(Todo todo) {
  return Card(
    color: Colors.white,
    child: Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                todo.name,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  decoration:
                      todo.isCompleted ? TextDecoration.lineThrough : null,
                ),
              ),
              Text(
                '${todo.dateTime.month}월 ${todo.dateTime.day}일  '
                '${todo.startTime.hour}:${todo.startTime.minute} ~ ${todo.finishTime.hour}:${todo.finishTime.minute}',
                style: TextStyle(fontSize: 15, color: Colors.grey[800]),
              ),
            ],
          ),
          const Spacer(
            flex: 3,
          ),
          Row(
            children: [
              IconButton(
                iconSize: 20,
                icon: Icon(todo.isCompleted
                    ? Icons.check_box
                    : Icons.check_box_outline_blank),
                onPressed: () {
                  todo.isCompleted = !todo.isCompleted;
                  todo.save();
                },
              ),
            ],
          ),
          IconButton(
            iconSize: 20,
            icon: const Icon(Icons.delete),
            onPressed: () {
              todo.delete();
            },
          )
        ],
      ),
    ),
  );
}
