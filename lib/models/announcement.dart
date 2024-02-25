import 'dart:convert';

class Announcement {
  final String announcementId;
  String announcementTitle;
  String announcementDescription;
  List<String>? announcementImages;
  String announcementPublishedOn;
  String announcementPublishedBy;

  Announcement({
    required this.announcementId,
    required this.announcementTitle,
    required this.announcementDescription,
    this.announcementImages,
    required this.announcementPublishedBy,
    required this.announcementPublishedOn,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'announcementId': announcementId});
    result.addAll({'announcementTitle': announcementTitle});
    result.addAll({'announcementDescription': announcementDescription});
    if (announcementImages != null) {
      result.addAll({'announcementImages': announcementImages});
    }
    result.addAll({'announcementPublishedOn': announcementPublishedOn});
    result.addAll({'announcementPublishedBy': announcementPublishedBy});

    return result;
  }

  factory Announcement.fromMap(Map<String, dynamic> map) {
    return Announcement(
      announcementId: map['_id'] ?? '',
      announcementTitle: map['announcementTitle'] ?? '',
      announcementDescription: map['announcementDescription'] ?? '',
      announcementImages: List<String>.from(map['announcementImages']),
      announcementPublishedOn: map['announcementPublishedOn'],
      announcementPublishedBy: map['announcementPublishedBy'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Announcement.fromJson(String source) =>
      Announcement.fromMap(json.decode(source) as Map<String, dynamic>);
}
