class Announcement {
  final String title;
  final String description;
  final List<String>? image;

  Announcement({
    required this.title,
    required this.description,
    this.image,
  });
}
