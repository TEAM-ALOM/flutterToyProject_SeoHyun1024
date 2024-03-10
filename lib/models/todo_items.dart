class ToDoItem {
  String name;
  DateTime dateTime;
  DateTime startTime, finishTime;
  bool isCompleted;

  ToDoItem({
    required this.name,
    required this.dateTime,
    required this.startTime,
    required this.finishTime,
    this.isCompleted = false,
  });

  ToDoItem.fromMap(Map<String, dynamic> map)
      : name = map['name'],
        dateTime = map['dateTime'],
        startTime = map['startTime'],
        finishTime = map['finishTime'],
        isCompleted = map['isCompleted'];

  Map<String, dynamic> toMap() => {
        'name': name,
        'dateTime': dateTime,
        'startTime': startTime,
        'finishTime': finishTime,
        'iscompleted': isCompleted,
      };
}
