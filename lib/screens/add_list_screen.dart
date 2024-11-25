//할일 추가 화면
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todolist/screens/home_screen.dart';
import 'package:todolist/services/todo_items.dart';

class AddList extends StatefulWidget {
  const AddList({super.key});

  @override
  State<AddList> createState() => _AddListState();
}

class _AddListState extends State<AddList> {
  DateTime selectedDate = DateTime.now();

  DateTime start = DateTime.now();
  DateTime finish = DateTime.now();

  final backColor = const Color(0xFFF7E8A5);

  String textContent = "";
  String textContentMemo = "";
  final TextEditingController _controllerTodo = TextEditingController();
  final TextEditingController _controllerMemo = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backColor,
      appBar: AppBar(
        title: const Text(
          '오늘의 할일이 무엇인가요?',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: backColor,
        toolbarHeight: 55,
        leadingWidth: 70,
        leading: TextButton(
          style: TextButton.styleFrom(
            backgroundColor: backColor,
            shape: const StadiumBorder(),
          ),
          onPressed: () {
            Navigator.of(context).pop(
              MaterialPageRoute(
                builder: (BuildContext context) => const HomeScreen(),
              ),
            );
          },
          child: const Text(
            '취소',
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              if (textContent == "") {
                dialogTodo(context);
              } else {
                if (!(finish.isAfter(start))) {
                  dialogTime(context);
                } else {
                  var todo = Todo()
                    ..name = textContent
                    ..dateTime = selectedDate
                    ..startTime = start
                    ..finishTime = finish
                    ..memo = textContentMemo;

                  Hive.box<Todo>('todos').add(todo);
                  Navigator.of(context).pop(
                    MaterialPageRoute(
                      builder: (BuildContext context) => const HomeScreen(),
                    ),
                  );
                }
              }
            },
            style: TextButton.styleFrom(
              backgroundColor: backColor,
            ),
            child: const Text(
              '완료',
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
              ),
            ),
          ),
        ],
        surfaceTintColor: Colors.white,
        shadowColor: Colors.black,
        elevation: 1,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            children: [
              const SmallBox(),
              Column(
                children: [
                  const Row(
                    children: [
                      TitleWidget(
                        name: '할 일',
                      ),
                    ],
                  ),
                  TextField(
                    controller: _controllerTodo,
                    onChanged: (value) {
                      textContent = value;
                    },
                  ),
                ],
              ),
              const SmallBox(),
              Row(
                children: [
                  const TitleWidget(
                    name: '날 짜',
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50),
                    child: Text(
                      '$selectedDate'.split(' ')[0],
                      style: const TextStyle(fontSize: 19),
                    ),
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                        backgroundColor: Colors.purple[100]),
                    onPressed: () => _selectDate(context),
                    onHover: (value) {
                      setState(() {
                        value = !value;
                      });
                    },
                    child: Text(
                      '날짜 선택',
                      style: TextStyle(
                        color: Colors.purple[600],
                      ),
                    ),
                  ),
                ],
              ),
              const MiddleBox(),
              Column(
                children: [
                  const Row(
                    children: [
                      TitleWidget(
                        name: '시 간',
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 50, vertical: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            const Text('시작시간'),
                            GestureDetector(
                              child: Container(
                                width: 120,
                                height: 57,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white,
                                ),
                                child: Center(
                                  child: Text(
                                    '${start.hour}:${start.minute}',
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 19,
                                    ),
                                  ),
                                ),
                              ),
                              onTap: () {
                                showCupertinoDialog(
                                  barrierDismissible: true,
                                  context: context,
                                  builder: (BuildContext contect) {
                                    return Align(
                                      alignment: Alignment.bottomCenter,
                                      child: Container(
                                        color: Colors.white,
                                        height: 300.0,
                                        child: CupertinoDatePicker(
                                          mode: CupertinoDatePickerMode.time,
                                          onDateTimeChanged: (DateTime time) {
                                            setState(() {
                                              start = DateTime(0, 1, 1,
                                                  time.hour, time.minute);
                                            });
                                          },
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            const Text('종료시간'),
                            GestureDetector(
                              child: Container(
                                width: 120,
                                height: 57,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white,
                                ),
                                child: Center(
                                  child: Text(
                                    '${finish.hour}:${finish.minute}',
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 19,
                                    ),
                                  ),
                                ),
                              ),
                              onTap: () {
                                showCupertinoDialog(
                                  barrierDismissible: true,
                                  context: context,
                                  builder: (BuildContext contect) {
                                    return Align(
                                      alignment: Alignment.bottomCenter,
                                      child: Container(
                                        color: Colors.white,
                                        height: 300.0,
                                        child: CupertinoDatePicker(
                                          mode: CupertinoDatePickerMode.time,
                                          onDateTimeChanged: (DateTime time) {
                                            setState(() {
                                              finish = DateTime(0, 1, 1,
                                                  time.hour, time.minute);
                                            });
                                          },
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  const Row(
                    children: [
                      TitleWidget(name: '메 모'),
                    ],
                  ),
                  const SmallBox(),
                  TextField(
                    textAlignVertical: TextAlignVertical.top,
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(vertical: 130),
                    ),
                    controller: _controllerMemo,
                    onChanged: (value) {
                      textContentMemo = value;
                    },
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<dynamic> dialogTodo(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('조또마떼!!!'),
        content: const Text('할 일을 작성해주십시요!!!'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("작성하기"),
          ),
        ],
      ),
    );
  }

  Future<dynamic> dialogTime(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('오이오이!!!'),
        content: const Text('시간을 확인해주십시요!!!'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("수정하기"),
          ),
        ],
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }
}

class SmallBox extends StatelessWidget {
  const SmallBox({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 35,
    );
  }
}

class MiddleBox extends StatelessWidget {
  const MiddleBox({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 45,
    );
  }
}

class TitleWidget extends StatelessWidget {
  final String name;
  const TitleWidget({
    super.key,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Color.fromARGB(255, 211, 121, 230),
          ),
        ),
      ),
      child: Text(
        name,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 23,
        ),
      ),
    );
  }
}
