import 'dart:convert';

class Registration {
  final String registrationId;
  final String eventName;
  final String userName;
  final String eventAmount;
  final List<String> participantsName;
  final List<String> participantsCategory;
  final List<String> participantsRegisterNo;

  Registration(
      {required this.registrationId,
      required this.eventName,
      required this.userName,
      required this.eventAmount,
      required this.participantsName,
      required this.participantsCategory,
      required this.participantsRegisterNo});

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'registrationId': registrationId});
    result.addAll({'eventName': eventName});
    result.addAll({'userName': userName});
    result.addAll({'eventAmount': eventAmount});
    result.addAll({'participantsName': participantsName});
    result.addAll({'participantsCategory': participantsCategory});
    result.addAll({'participantsRegisterNo': participantsRegisterNo});

    return result;
  }

  factory Registration.fromMap(Map<String, dynamic> map) {
    return Registration(
      registrationId: map['_id'] ?? '',
      eventName: map['eventName'] ?? '',
      userName: map['userName'] ?? '',
      eventAmount: map['eventAmount'] ?? '',
      participantsName: List<String>.from(map['participantsName']),
      participantsCategory: List<String>.from(map['participantsCategory']),
      participantsRegisterNo: List<String>.from(map['participantsRegisterNo']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Registration.fromJson(String source) =>
      Registration.fromMap(json.decode(source));
}
