class Task {
  final String id;
  final String title;
  bool isCompleted;

  Task({required this.id, required this.title, this.isCompleted = false});

  static List<Task> tasks = [
    Task(id: '1', title: 'Complete Flutter project'),
    Task(id: '2', title: 'Review pull requests'),
    Task(id: '3', title: 'Update documentation'),
    Task(id: '4', title: 'Plan next sprint'),
  ];
}
