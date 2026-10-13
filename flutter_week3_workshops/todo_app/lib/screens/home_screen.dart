import 'package:flutter/material.dart';
import '../data/task_store.dart';
import '../models/task.dart';
import 'add_task_screen.dart';
import 'manage_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override State<HomeScreen> createState() => _HomeScreenState();
}
class _HomeScreenState extends State<HomeScreen> {
  List<TaskItem> tasks = [];
  bool loading = true;
  @override void initState() { super.initState(); refresh(); }

  Future<void> refresh() async {
    final value = await TaskStore.load();
    if (!mounted) return;
    setState(() { tasks = TaskStore.sorted(value); loading = false; });
  }
  Future<void> add() async {
    final task = await Navigator.push<TaskItem>(context,
      MaterialPageRoute(builder: (_) => const AddTaskScreen()));
    if (!mounted) return;
    if (task != null) {
      tasks.add(task);
      await TaskStore.save(tasks);
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('เพิ่มงานแล้ว')));
    }
    await refresh();
  }
  Future<void> manage() async {
    await Navigator.push<void>(context,
      MaterialPageRoute(builder: (_) => const ManageScreen()));
    await refresh();
  }
  @override Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('To-do List')),
    body: loading ? const Center(child: CircularProgressIndicator())
      : tasks.isEmpty ? const Center(child: Text('ยังไม่มีงาน กดเพิ่มงานเพื่อเริ่มต้น'))
      : SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              columns: const [
                DataColumn(label: Text('ลำดับ')),
                DataColumn(label: Text('ชื่องาน')),
                DataColumn(label: Text('ความสำคัญ')),
                DataColumn(label: Text('สถานะ')),
              ],
              rows: [
                for (int i = 0; i < tasks.length; i++)
                  DataRow(cells: [
                    DataCell(Text((i + 1).toString())),
                    DataCell(Text(tasks[i].title,
                      style: TextStyle(decoration: tasks[i].completed
                        ? TextDecoration.lineThrough : null))),
                    DataCell(Chip(
                      label: Text(tasks[i].priorityText),
                      backgroundColor: [
                        Colors.red.shade100, Colors.amber.shade100,
                        Colors.green.shade100,
                      ][tasks[i].priority],
                    )),
                    DataCell(Text(tasks[i].completed ? 'เสร็จแล้ว' : 'ยังไม่เสร็จ')),
                  ]),
              ],
            ),
          ),
        ),
    bottomNavigationBar: SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Row(children: [
          Expanded(child: FilledButton.icon(
            onPressed: add, icon: const Icon(Icons.add),
            label: const Text('เพิ่มงาน'))),
          const SizedBox(width: 12),
          Expanded(child: OutlinedButton.icon(
            onPressed: manage, icon: const Icon(Icons.edit_note),
            label: const Text('จัดการ'))),
        ]),
      ),
    ),
  );
}
