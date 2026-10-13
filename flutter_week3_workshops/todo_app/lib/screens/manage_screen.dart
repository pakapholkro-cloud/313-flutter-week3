import 'package:flutter/material.dart';
import '../data/task_store.dart';
import '../models/task.dart';

class ManageScreen extends StatefulWidget {
  const ManageScreen({super.key});
  @override State<ManageScreen> createState() => _ManageScreenState();
}
class _ManageScreenState extends State<ManageScreen> {
  List<TaskItem> tasks = [];
  @override void initState() { super.initState(); load(); }
  Future<void> load() async {
    final value = await TaskStore.load();
    if (mounted) setState(() => tasks = TaskStore.sorted(value));
  }
  Future<void> toggle(TaskItem task, bool value) async {
    setState(() => task.completed = value);
    await TaskStore.save(tasks);
  }
  Future<void> delete(TaskItem task) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('ยืนยันการลบ'),
        content: Text('ต้องการลบงาน "' + task.title + '" หรือไม่?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false),
            child: const Text('ยกเลิก')),
          FilledButton(onPressed: () => Navigator.pop(context, true),
            child: const Text('ลบ')),
        ],
      ),
    );
    if (confirmed != true || !mounted) return;
    setState(() => tasks.removeWhere((entry) => entry.id == task.id));
    await TaskStore.save(tasks);
  }
  @override Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('จัดการงาน')),
    body: tasks.isEmpty ? const Center(child: Text('ไม่มีงานให้จัดการ'))
      : ListView.builder(
          itemCount: tasks.length,
          padding: const EdgeInsets.all(12),
          itemBuilder: (context, i) {
            final task = tasks[i];
            return Card(child: ListTile(
              title: Text(task.title, style: TextStyle(
                decoration: task.completed ? TextDecoration.lineThrough : null)),
              subtitle: Text('ความสำคัญ: ' + task.priorityText),
              leading: Switch(
                value: task.completed,
                onChanged: (value) => toggle(task, value)),
              trailing: IconButton(
                tooltip: 'ลบงาน', icon: const Icon(Icons.delete_outline),
                onPressed: () => delete(task)),
            ));
          },
        ),
  );
}
