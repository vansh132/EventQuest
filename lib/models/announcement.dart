class Announcement {
  final String id;
  String title;
  String description;
  List<String>? image;
  DateTime publishedOn;
  String publishedBy;

  Announcement({
    required this.id,
    required this.title,
    required this.description,
    this.image,
    required this.publishedBy,
    required this.publishedOn,
  });
}
