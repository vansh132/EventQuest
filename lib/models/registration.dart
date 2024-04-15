class Registration {
  final String registrationId;
  final String eventName;
  final String userName;
  final num eventAmount;
  final List<String> participantsName;
  final List<String> participantsCategory;
  final List<int> participantsRegisterNo;

  Registration(
      {required this.registrationId,
      required this.eventName,
      required this.userName,
      required this.eventAmount,
      required this.participantsName,
      required this.participantsCategory,
      required this.participantsRegisterNo});
}
