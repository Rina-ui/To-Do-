class Task {
  final String id;
  final String title;
  final String description;
  final bool completed;

  Task({
    required this.id,
    required this.title,
    required this.description,
    required this.completed,
  });

  factory Task.fromJson(Map<String, dynamic> json) => Task(
    id:          json['_id'] as String,
    title:       json['title'] as String,
    description: json['description'] as String,
    completed:   json['completed'] as bool,
  );

}