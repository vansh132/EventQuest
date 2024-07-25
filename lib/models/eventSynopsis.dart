class EventSynopsis {
  final String highlights;
  final String keyTakeaways;
  final String summary;
  final String? followUp;

  EventSynopsis({
    required this.highlights,
    required this.keyTakeaways,
    required this.summary,
    this.followUp,
  });

  factory EventSynopsis.fromJson(Map<String, dynamic> json) {
    return EventSynopsis(
      highlights: json['highlights'],
      keyTakeaways: json['keyTakeaways'],
      summary: json['summary'],
      followUp: json['followUp'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'highlights': highlights,
      'keyTakeaways': keyTakeaways,
      'summary': summary,
      'followUp': followUp,
    };
  }
}
