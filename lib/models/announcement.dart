class Announcement {
  final String title;
  final String description;
  final DateTime date;
  final String? image;

  Announcement({
    required this.title,
    required this.description,
    required this.date,
    this.image,
  });
}
