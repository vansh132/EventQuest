import 'dart:convert';

class Event {
  final String eventId;
  String eventName;
  String eventDescription;
  num eventAmount;
  String eventImage;
  String eventCategory;
  String eventPublishedOn;
  int eventNoOfParticipants;
  String? eventLink; // Made nullable
  String eventContactPerson;
  int eventContactPersonNo;
  String eventRegistrationDeadline;

  // Event Constructor
  Event({
    required this.eventId,
    required this.eventName,
    required this.eventDescription,
    required this.eventAmount,
    required this.eventImage,
    required this.eventCategory,
    required this.eventPublishedOn,
    required this.eventNoOfParticipants,
    this.eventLink, // Optional parameter
    required this.eventContactPerson,
    required this.eventContactPersonNo,
    required this.eventRegistrationDeadline,
  });

  // Map Function
  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'eventId': eventId});
    result.addAll({'eventName': eventName});
    result.addAll({'eventDescription': eventDescription});
    result.addAll({'eventAmount': eventAmount});
    result.addAll({'eventImage': eventImage});
    result.addAll({'eventCategory': eventCategory});
    result.addAll({'eventPublishedOn': eventPublishedOn});
    result.addAll({'eventNoOfParticipants': eventNoOfParticipants});
    if (eventLink != null) {
      result.addAll({'eventLink': eventLink});
    }
    result.addAll({'eventContactPerson': eventContactPerson});
    result.addAll({'eventContactPersonNo': eventContactPersonNo});
    result.addAll({'eventRegistrationDeadline': eventRegistrationDeadline});

    return result;
  }

  factory Event.fromMap(Map<String, dynamic> map) {
    return Event(
      eventId: map['_id'] ?? '',
      eventName: map['eventName'] ?? '',
      eventDescription: map['eventDescription'] ?? '',
      eventAmount: map['eventAmount'] ?? 0.0,
      eventImage: map['eventImage'] ?? '',
      eventCategory: map['eventCategory'] ?? '',
      eventPublishedOn: map['eventPublishedOn'],
      eventNoOfParticipants: map['eventNoOfParticipants'] ?? 0,
      eventLink: map['eventLink'], // Optional field
      eventContactPerson: map['eventContactPerson'] ?? '',
      eventContactPersonNo: map['eventContactPersonNo'] ?? 0,
      eventRegistrationDeadline: map['eventRegistrationDeadline'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Event.fromJson(String source) =>
      Event.fromMap(json.decode(source) as Map<String, dynamic>);
}
