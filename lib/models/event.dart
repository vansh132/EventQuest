import 'dart:html';

class Event {
  final int eventId;
  final String eventName;
  final String description;
  final double eventAmount;
  final List<String> eventImages;
  final DateTime publishedOn;
  final int noOfParticipants;
  final String eventLink;
  final String contactPerson;
  final int contactNo;
  final DateTime registartionDeadline;

  Event({
    required this.eventId,
    required this.eventName,
    required this.description,
    required this.publishedOn,
    required this.eventImages,
    required this.eventLink,
    required this.eventAmount,
    required this.contactPerson,
    required this.contactNo,
    required this.noOfParticipants,
    required this.registartionDeadline,
  });
}
