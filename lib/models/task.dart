class Task {
  String title;
  bool isCompleted;
  String? description;
  String? category;

  Task({
    required this.title,
    this.isCompleted = false,
    this.description,
    this.category,
  });
}
