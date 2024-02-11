class Registration {
  final String userId;
  final String eventId;
  final List<TeamMember> teamDetails;
  final String paymentStatus;

  Registration(
      {required this.userId, //whole object
      required this.eventId,
      required this.teamDetails,
      required this.paymentStatus});
}

class TeamMember {
  final String name;

  TeamMember({required this.name});
}
