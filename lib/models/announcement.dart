class Announcement {
  final String title;
  final String description;
  final List<String>? image;
  final DateTime publishedOn;
  final String publishedBy;

  Announcement({
    required this.title,
    required this.description,
    this.image,
    required this.publishedBy,
    required this.publishedOn,
  });
}
