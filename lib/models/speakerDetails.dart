class SpeakerDetails {
  final String name;
  final String position;
  final String organization;
  final String presentationTitle;

  SpeakerDetails({
    required this.name,
    required this.position,
    required this.organization,
    required this.presentationTitle,
  });

  factory SpeakerDetails.fromJson(Map<String, dynamic> json) {
    return SpeakerDetails(
      name: json['name'],
      position: json['position'],
      organization: json['organization'],
      presentationTitle: json['presentationTitle'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'position': position,
      'organization': organization,
      'presentationTitle': presentationTitle,
    };
  }
}
