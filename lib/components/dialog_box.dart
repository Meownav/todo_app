import 'package:flutter/material.dart';
import 'package:todo_app/components/custom_button.dart';

class DialogBox extends StatelessWidget {
  final controller;
  final VoidCallback onSave;
  final VoidCallback onCancel;

  const DialogBox({
    super.key,
    required this.controller,
    required this.onSave,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Container(
        height: 120,
        child: Column(
          children: [
            TextField(
              controller: controller,
              style: const TextStyle(
                color: Colors.black,
              ),
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Add a new task !",
                hintStyle: TextStyle(
                  color: Colors.black38,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 8),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CustomButton(text: "Save", onPressed: onSave),
                Container(
                  width: 8,
                ),
                CustomButton(text: "Cancel", onPressed: onCancel),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
