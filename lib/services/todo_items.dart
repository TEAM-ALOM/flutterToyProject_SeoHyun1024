import 'package:hive_flutter/hive_flutter.dart';
part 'todo_adapter.dart';

@HiveType(typeId: 0)
class Todo extends HiveObject {
  @HiveField(0)
  String name = "";

  @HiveField(1)
  DateTime dateTime = DateTime.now();

  @HiveField(2)
  DateTime startTime = DateTime.now();

  @HiveField(3)
  DateTime finishTime = DateTime.now();

  @HiveField(4)
  bool isCompleted = false;

  @HiveField(5)
  String memo = "";
}
