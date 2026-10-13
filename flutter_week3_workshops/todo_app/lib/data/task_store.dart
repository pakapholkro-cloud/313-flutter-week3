import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/task.dart';

class TaskStore {
  static const key = 'week3_tasks';
  static Future<List<TaskItem>> load() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(key);
    if (raw == null) return [];
    try {
      return (jsonDecode(raw) as List)
          .map((entry) => TaskItem.fromJson(Map<String, dynamic>.from(entry as Map)))
          .toList();
    } catch (_) {
      return [];
    }
  }
  static Future<void> save(List<TaskItem> tasks) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key,
      jsonEncode(tasks.map((task) => task.toJson()).toList()));
  }
  static List<TaskItem> sorted(List<TaskItem> tasks) =>
      [...tasks]..sort((a, b) {
        final byPriority = a.priority.compareTo(b.priority);
        return byPriority != 0 ? byPriority : a.id.compareTo(b.id);
      });
}
