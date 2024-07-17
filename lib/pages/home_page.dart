import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:todo_app/components/dialog_box.dart';
import 'package:todo_app/components/todo_tile.dart';
import 'package:todo_app/data/database.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _mybox = Hive.box("mybox");
  TodoDatabase db = TodoDatabase();

  @override
  void initState() {
    if (_mybox.get("todoList") == null) {
      db.createInitialData();
    } else {
      db.loadData();
    }
    super.initState();
  }

  void toggleCheckBox(bool? value, int index) {
    setState(() {
      db.todoList[index][1] = !db.todoList[index][1];
    });
    db.updateDatabase();
  }

  void saveNewTask() {
    setState(() {
      db.todoList.add([_controller.text, false]);
      Navigator.of(context).pop();
      _controller.text = "";
    });
    db.updateDatabase();
  }

  void deleteNote(int index) {
    setState(() {
      db.todoList.removeAt(index);
    });
    db.updateDatabase();
  }

  final _controller = TextEditingController();

  void createNewTask() {
    showDialog(
        context: context,
        builder: (context) {
          return DialogBox(
            controller: _controller,
            onSave: saveNewTask,
            onCancel: () => Navigator.of(context).pop(),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: const Color.fromRGBO(22, 23, 28, 1),
          title: const Text(
            "N O T E S",
            style: TextStyle(
              color: Colors.white70,
              fontSize: 28,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        backgroundColor: const Color.fromRGBO(22, 23, 28, 1),
        floatingActionButton: FloatingActionButton(
          onPressed: createNewTask,
          child: const Icon(
            Icons.add,
          ),
        ),
        body: ListView.builder(
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(4),
              child: TodoTile(
                taskName: db.todoList[index][0],
                taskCompleted: db.todoList[index][1],
                onchanged: (value) => toggleCheckBox(value, index),
                deleteFunction: (context) => deleteNote(index),
              ),
            );
          },
          itemCount: db.todoList.length,
        ),
      ),
    );
  }
}
