import 'dart:convert';

class ImageClass {
  List<String>? image;
  ImageClass({
    this.image,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (image != null) {
      result.addAll({'announcementImages': image});
    }

    return result;
  }

  factory ImageClass.fromMap(Map<String, dynamic> map) {
    return ImageClass(
      image: List<String>.from(map['announcementImages']),
    );
  }

  String toJson() => json.encode(toMap());

  factory ImageClass.fromJson(String source) =>
      ImageClass.fromMap(json.decode(source) as Map<String, dynamic>);
}
