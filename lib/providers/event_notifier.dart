import 'package:eventquest/models/announcement.dart';
import 'package:eventquest/models/event.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EventNotifier extends StateNotifier<List<Event>> {
  EventNotifier() : super(const []);

  void addAnnouncement(Event event) {
    final newEvent = Event(
        eventId: event.eventId,
        eventName: event.eventName,
        description: event.description,
        eventAmount: event.eventAmount,
        eventImages: event.eventImages,
        eventCategory: event.eventCategory,
        publishedOn: event.publishedOn,
        noOfParticipants: event.noOfParticipants,
        contactPerson: event.contactPerson,
        contactNo: event.contactNo,
        registartionDeadline: event.registartionDeadline);
    state = [newEvent, ...state];
  }

  // void editAnnouncement(Event updatedEvent) {
  //   state = state.map((event) {
  //     if (event.id == updatedevent.id) {
  //       event.title = updatedevent.title;
  //       event.description = updatedevent.description;
  //       event.publishedBy = updatedevent.publishedBy;

  //       return updatedAnnouncement;
  //     }

  //     return announcement;
  //   }).toList();
  // }

  void removeEvent(Event event) {
    state = [...state.where((element) => element != event)];
  }
}

final announcementProvider =
    StateNotifierProvider<EventNotifier, List<Event>>((ref) => EventNotifier());
