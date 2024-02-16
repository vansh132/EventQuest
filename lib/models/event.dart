class Event {
  final String eventId;
  String eventName;
  String eventDescription;
  double eventAmount;
  String eventImage;
  String eventCategory;
  DateTime eventPublishedOn;
  int eventNoOfParticipants;
  String eventLink;
  String eventContactPerson;
  int eventContactNo;
  DateTime eventRegistartionDeadline;

  Event({
    required this.eventId,
    required this.eventName,
    required this.eventDescription,
    required this.eventAmount,
    required this.eventImage,
    required this.eventCategory,
    required this.eventPublishedOn,
    required this.eventNoOfParticipants,
    required this.eventLink,
    required this.eventContactPerson,
    required this.eventContactNo,
    required this.eventRegistartionDeadline,
  });
}
