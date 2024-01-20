class Event {
  final String eventId;
  final String eventName;
  final String description;
  final double eventAmount;
  List<String>? eventImages;
  final String eventCategory;
  final DateTime publishedOn;
  final int noOfParticipants;
  String? eventLink;
  final String contactPerson;
  final int contactNo;
  final DateTime registartionDeadline;

  Event({
    required this.eventId,
    required this.eventName,
    required this.description,
    required this.eventAmount,
    this.eventImages,
    required this.eventCategory,
    required this.publishedOn,
    required this.noOfParticipants,
    this.eventLink,
    required this.contactPerson,
    required this.contactNo,
    required this.registartionDeadline,
  });
}
