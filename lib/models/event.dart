class Event {
  final String eventId;
  String eventName;
  String description;
  double eventAmount;
  String eventImages;
  String eventCategory;
  DateTime publishedOn;
  int noOfParticipants;
  String eventLink;
  String contactPerson;
  int contactNo;
  DateTime registartionDeadline;

  Event({
    required this.eventId,
    required this.eventName,
    required this.description,
    required this.eventAmount,
    required this.eventImages,
    required this.eventCategory,
    required this.publishedOn,
    required this.noOfParticipants,
    required this.eventLink,
    required this.contactPerson,
    required this.contactNo,
    required this.registartionDeadline,
  });
}
