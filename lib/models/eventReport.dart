import 'generalInfo.dart';
import 'speakerDetails.dart';
import 'participantsDetail.dart';
import 'eventSynopsis.dart';
import 'speakerBio.dart';

class EventReport {
  final GeneralInfo generalInfo;
  final List<SpeakerDetails> speakerDetails;
  final ParticipantsDetail participantsDetail;
  final EventSynopsis eventSynopsis;
  final String rapporteurName;
  final String rapporteurEmail;
  final String eventDescriptiveReport;
  final List<SpeakersBio> speakersProfile;
  final String geoTagPhotos;
  final String feedbackForm;
  final String activityImages;
  final String poster;

  EventReport({
    required this.generalInfo,
    required this.speakerDetails,
    required this.participantsDetail,
    required this.eventSynopsis,
    required this.rapporteurName,
    required this.rapporteurEmail,
    required this.eventDescriptiveReport,
    required this.speakersProfile,
    required this.geoTagPhotos,
    required this.feedbackForm,
    required this.activityImages,
    required this.poster,
  });

  factory EventReport.fromJson(Map<String, dynamic> json) {
    return EventReport(
      generalInfo: GeneralInfo.fromJson(json['generalInfo']),
      speakerDetails: (json['speakerDetails'] as List)
          .map((i) => SpeakerDetails.fromJson(i))
          .toList(),
      participantsDetail:
          ParticipantsDetail.fromJson(json['participantsDetail']),
      eventSynopsis: EventSynopsis.fromJson(json['eventSynopsis']),
      rapporteurName: json['rapporteurName'],
      rapporteurEmail: json['rapporteurEmail'],
      eventDescriptiveReport: json['eventDescriptiveReport'],
      speakersProfile: (json['speakersProfile'] as List)
          .map((i) => SpeakersBio.fromJson(i))
          .toList(),
      geoTagPhotos: json['geoTagPhotos'],
      feedbackForm: json['feedbackForm'],
      activityImages: json['activityImages'],
      poster: json['poster'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'generalInfo': generalInfo.toJson(),
      'speakerDetails': speakerDetails.map((e) => e.toJson()).toList(),
      'participantsDetail': participantsDetail.toJson(),
      'eventSynopsis': eventSynopsis.toJson(),
      'rapporteurName': rapporteurName,
      'rapporteurEmail': rapporteurEmail,
      'eventDescriptiveReport': eventDescriptiveReport,
      'speakersProfile': speakersProfile.map((e) => e.toJson()).toList(),
      'geoTagPhotos': geoTagPhotos,
      'feedbackForm': feedbackForm,
      'activityImages': activityImages,
      'poster': poster,
    };
  }
}
