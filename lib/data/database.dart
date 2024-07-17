import 'package:hive/hive.dart';

class TodoDatabase {
  List todoList = [];
  final _myBox = Hive.box("mybox");

  void createInitialData() {
    todoList = [
      ["You can add new tasks by the + button below.", false],
      ["Use the check mark to check off the tasks.", false],
      ["Swipe right on a task to permanently delete it.", false]
    ];
  }

  void updateDatabase() {
    _myBox.put("todoList", todoList);
  }

  void loadData() {
    todoList = _myBox.get("todoList");
  }
}
