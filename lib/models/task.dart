class Task {
  String title;
  bool isCompleted;
  String category;
  String description;

  Task({
    required this.title,
    this.isCompleted = false,
    this.category = 'General',
    this.description = '',
  });
}