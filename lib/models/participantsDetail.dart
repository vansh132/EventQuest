class ParticipantsDetail {
  final String typeOfParticipants;
  final int noOfParticipants;

  ParticipantsDetail({
    required this.typeOfParticipants,
    required this.noOfParticipants,
  });

  factory ParticipantsDetail.fromJson(Map<String, dynamic> json) {
    return ParticipantsDetail(
      typeOfParticipants: json['typeOfParticipants'],
      noOfParticipants: json['noOfParticipants'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'typeOfParticipants': typeOfParticipants,
      'noOfParticipants': noOfParticipants,
    };
  }
}
