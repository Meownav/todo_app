import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class TodoTile extends StatelessWidget {
  final String taskName;
  final bool taskCompleted;
  final Function(bool?)? onchanged;
  final Function(BuildContext)? deleteFunction;

  const TodoTile({
    super.key,
    required this.taskName,
    required this.taskCompleted,
    this.onchanged,
    this.deleteFunction,
  });

  @override
  Widget build(BuildContext context) {
    return Slidable(
      endActionPane: ActionPane(
        motion: const StretchMotion(),
        children: [
          SlidableAction(
            padding: const EdgeInsets.all(16),
            borderRadius: BorderRadius.circular(8),
            onPressed: deleteFunction,
            icon: Icons.delete,
            backgroundColor: Colors.red,
          )
        ],
      ),
      child: Row(children: [
        Checkbox(value: taskCompleted, onChanged: onchanged),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: taskCompleted
                  ? const Color.fromRGBO(32, 32, 43, 1)
                  : const Color.fromRGBO(43, 45, 59, 1),
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.all(24),
            margin: const EdgeInsets.only(left: 8, right: 8),
            child: Text(
              taskName,
              style: TextStyle(
                color: Colors.white60,
                decoration: taskCompleted
                    ? TextDecoration.lineThrough
                    : TextDecoration.none,
                decorationColor: Colors.black,
                fontSize: 20,
                decorationThickness: 1.5,
              ),
            ),
          ),
        )
      ]),
    );
  }
}
