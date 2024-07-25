class GeneralInfo {
  final String type;
  final String title;
  final String date;
  final String time;
  final String venue;
  final String? collaboration;

  GeneralInfo({
    required this.type,
    required this.title,
    required this.date,
    required this.time,
    required this.venue,
    this.collaboration,
  });

  factory GeneralInfo.fromJson(Map<String, dynamic> json) {
    return GeneralInfo(
      type: json['type'],
      title: json['title'],
      date: json['date'],
      time: json['time'],
      venue: json['venue'],
      collaboration: json['collaboration'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'title': title,
      'date': date,
      'time': time,
      'venue': venue,
      'collaboration': collaboration,
    };
  }
}
