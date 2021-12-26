class Task {
  const  Task({required this.title, required this.subtitle});

  final String title;
  final String subtitle;

  String getTitle() => title;
  String getSubtitle() => subtitle;
  String getFull() => title + ' ' + subtitle;
}