class Registration {
  final String userId;
  final String eventId;
  final List<String> teamDetails;
  final String paymentStatus;

  Registration(
      {required this.userId,
      required this.eventId,
      required this.teamDetails,
      required this.paymentStatus});
}
