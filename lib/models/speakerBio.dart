class SpeakersBio {
  String image;
  final String bio;

  SpeakersBio({
    required this.image,
    required this.bio,
  });

  factory SpeakersBio.fromJson(Map<String, dynamic> json) {
    return SpeakersBio(
      image: json['image'],
      bio: json['bio'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'image': image,
      'bio': bio,
    };
  }
}
