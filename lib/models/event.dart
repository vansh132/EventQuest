import 'dart:convert';

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

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'eventId': eventId});
    result.addAll({'eventName': eventName});
    result.addAll({'eventDescription': eventDescription});
    result.addAll({'eventAmount': eventAmount});
    result.addAll({'eventImage': eventImage});
    result.addAll({'eventCategory': eventCategory});
    result
        .addAll({'eventPublishedOn': eventPublishedOn.millisecondsSinceEpoch});
    result.addAll({'eventNoOfParticipants': eventNoOfParticipants});
    result.addAll({'eventLink': eventLink});
    result.addAll({'eventContactPerson': eventContactPerson});
    result.addAll({'eventContactNo': eventContactNo});
    result.addAll({
      'eventRegistartionDeadline':
          eventRegistartionDeadline.millisecondsSinceEpoch
    });

    return result;
  }

  factory Event.fromMap(Map<String, dynamic> map) {
    return Event(
      eventId: map['_id'] ?? '',
      eventName: map['eventName'] ?? '',
      eventDescription: map['eventDescription'] ?? '',
      eventAmount: map['eventAmount']?.toDouble() ?? 0.0,
      eventImage: map['eventImage'] ?? '',
      eventCategory: map['eventCategory'] ?? '',
      eventPublishedOn:
          DateTime.fromMillisecondsSinceEpoch(map['eventPublishedOn']),
      eventNoOfParticipants: map['eventNoOfParticipants']?.toInt() ?? 0,
      eventLink: map['eventLink'] ?? '',
      eventContactPerson: map['eventContactPerson'] ?? '',
      eventContactNo: map['eventContactNo']?.toInt() ?? 0,
      eventRegistartionDeadline:
          DateTime.fromMillisecondsSinceEpoch(map['eventRegistartionDeadline']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Event.fromJson(String source) => Event.fromMap(json.decode(source));
}
