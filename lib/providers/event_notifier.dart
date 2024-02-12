import 'package:eventquest/models/event.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EventNotifier extends StateNotifier<List<Event>> {
  EventNotifier() : super(const []);

  void addEvent(Event event) {
    final newEvent = Event(
        eventLink: event.eventLink,
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

  void updateEvent(Event updatedEvent) {
    state = state.map((event) {
      if (event.eventId == updatedEvent.eventId) {
        event.eventName = updatedEvent.eventName;
        event.description = updatedEvent.description;
        event.eventAmount = updatedEvent.eventAmount;
        event.eventImages = updatedEvent.eventImages;
        event.eventCategory = updatedEvent.eventCategory;
        event.publishedOn = updatedEvent.publishedOn;
        event.noOfParticipants = updatedEvent.noOfParticipants;
        event.contactNo = updatedEvent.contactNo;
        event.contactPerson = updatedEvent.contactPerson;
        event.registartionDeadline = updatedEvent.registartionDeadline;

        return updatedEvent;
      }

      return event;
    }).toList();
  }

  void removeEvent(Event event) {
    state = [...state.where((element) => element != event)];
  }
}

final eventProvider =
    StateNotifierProvider<EventNotifier, List<Event>>((ref) => EventNotifier());
