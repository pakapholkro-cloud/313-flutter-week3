class TaskItem {
  final String id, title;
  final int priority; // 0 สูง / 1 กลาง / 2 ต่ำ
  bool completed;
  TaskItem({required this.id, required this.title,
    required this.priority, this.completed = false});
  String get priorityText => ['สูง', 'กลาง', 'ต่ำ'][priority];
  Map<String, dynamic> toJson() => {
    'id': id, 'title': title, 'priority': priority, 'completed': completed,
  };
  factory TaskItem.fromJson(Map<String, dynamic> value) => TaskItem(
    id: value['id'].toString(),
    title: value['title'].toString(),
    priority: (value['priority'] as num).toInt(),
    completed: value['completed'] == true,
  );
}
