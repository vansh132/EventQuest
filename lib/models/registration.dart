class Registration {
  final String userId;
  final String eventId; // object
  final List<TeamMember> teamDetails;
  final String studentCategory;

  Registration({
    required this.userId,
    required this.eventId,
    required this.teamDetails,
    required this.studentCategory,
  });
}

class TeamMember {
  final String name;

  TeamMember({required this.name});
}
