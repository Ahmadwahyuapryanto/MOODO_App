class Task {
  final String title;
  final DateTime? deadline;
  bool isCompleted;

  Task({
    required this.title,
    this.deadline,
    this.isCompleted = false,
  });
}