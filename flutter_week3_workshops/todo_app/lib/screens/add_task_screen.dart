import 'package:flutter/material.dart';
import '../models/task.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});
  @override State<AddTaskScreen> createState() => _AddTaskScreenState();
}
class _AddTaskScreenState extends State<AddTaskScreen> {
  final controller = TextEditingController();
  int priority = 1;
  void save() {
    final title = controller.text.trim();
    if (title.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('กรุณากรอกชื่องาน')));
      return;
    }
    Navigator.pop(context, TaskItem(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      title: title, priority: priority,
    ));
  }
  @override void dispose() { controller.dispose(); super.dispose(); }
  @override Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('เพิ่มงาน')),
    body: Center(child: ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 500),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: controller,
              decoration: const InputDecoration(
                border: OutlineInputBorder(), labelText: 'ชื่องาน'),
              onSubmitted: (_) => save(),
            ),
            const SizedBox(height: 18),
            DropdownButtonFormField<int>(
              value: priority,
              decoration: const InputDecoration(
                border: OutlineInputBorder(), labelText: 'ความสำคัญ'),
              items: const [
                DropdownMenuItem(value: 0, child: Text('สูง')),
                DropdownMenuItem(value: 1, child: Text('กลาง')),
                DropdownMenuItem(value: 2, child: Text('ต่ำ')),
              ],
              onChanged: (value) => setState(() => priority = value ?? 1),
            ),
            const SizedBox(height: 18),
            FilledButton(onPressed: save, child: const Text('บันทึก')),
          ],
        ),
      ),
    )),
  );
}
