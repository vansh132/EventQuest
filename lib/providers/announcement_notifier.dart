import 'package:eventquest/models/announcement.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AnnouncementNotifier extends StateNotifier<List<Announcement>> {
  AnnouncementNotifier() : super(const []);

  void addAnnouncement(Announcement announcement) {
    final newAnnouncement = Announcement(
        id: announcement.id,
        title: announcement.title,
        description: announcement.description,
        publishedBy: announcement.publishedBy,
        publishedOn: announcement.publishedOn,
        image: announcement.image);
    state = [newAnnouncement, ...state];
  }

  void editAnnouncement(Announcement updatedAnnouncement) {
    state = state.map((announcement) {
      if (announcement.id == updatedAnnouncement.id) {
        announcement.title = updatedAnnouncement.title;
        announcement.description = updatedAnnouncement.description;
        announcement.publishedBy = updatedAnnouncement.publishedBy;

        return updatedAnnouncement;
      }

      return announcement;
    }).toList();
  }

  void removeAnnouncement(Announcement announcement) {
    state = [...state.where((element) => element != announcement)];
  }
}

final announcementProvider =
    StateNotifierProvider<AnnouncementNotifier, List<Announcement>>(
        (ref) => AnnouncementNotifier());
