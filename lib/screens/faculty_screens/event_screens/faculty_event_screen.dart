import 'dart:async';
import 'package:eventquest/models/event.dart';
import 'package:eventquest/screens/faculty_screens/event_screens/add_event_screen.dart';
import 'package:eventquest/screens/faculty_screens/event_screens/edit_event_screen.dart';
import 'package:eventquest/screens/faculty_screens/event_screens/faculty_event_detail_screen.dart';
import 'package:eventquest/screens/student_screens/event_screens/event_detail_screen.dart';
import 'package:eventquest/services/event_services.dart';
import 'package:eventquest/theme/theme_ext.dart';
import 'package:flutter/material.dart';

class FacultyEventScreen extends StatefulWidget {
  static const String routeName = '/event-screen';
  const FacultyEventScreen({Key? key}) : super(key: key);

  @override
  State<FacultyEventScreen> createState() => _FacultyEventScreenState();
}

class _FacultyEventScreenState extends State<FacultyEventScreen> {
  int? _value;
  List<Event> events = [];
  EventServices eventServices = EventServices();

  Future<List<Event>> getAllPost() async {
    if (_value == 0) {
      events = await eventServices.getAllUgEvents(context);
    } else if (_value == 1) {
      events = await eventServices.getAllPgEvents(context);
    } else {
      events = await eventServices.getAllBothEvents(context);
    }
    return events;
  }

  @override
  void initState() {
    super.initState();
    getAllPost();
  }

  @override
  Widget build(BuildContext context) {
    final appColors = context.appColors;
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Events",
                  style: Theme.of(context).textTheme.displayLarge,
                ),
                Image.asset(
                  scale: 1,
                  height: 60,
                  width: 70,
                  "assets/images/event.gif",
                  fit: BoxFit.cover,
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          filterOption(context),
          const SizedBox(height: 20),
          Expanded(
            child: FutureBuilder(
              future: getAllPost(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else {
                  events.sort((a, b) => a.eventRegistrationDeadline
                      .compareTo(b.eventRegistrationDeadline));
                  Map<String, List<Event>> groupedEvents = {};
                  events.forEach((event) {
                    String date = event.eventRegistrationDeadline.split("T")[0];
                    if (groupedEvents.containsKey(date)) {
                      groupedEvents[date]!.add(event);
                    } else {
                      groupedEvents[date] = [event];
                    }
                  });
                  return ListView(
                    children: groupedEvents.entries.map((entry) {
                      List<Event> eventsForDate = entry.value;
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: eventsForDate.length,
                            itemBuilder: (context, index) {
                              return buildEventCard(eventsForDate[index]);
                            },
                          ),
                        ],
                      );
                    }).toList(),
                  );
                }
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: appColors.primary,
        onPressed: () {
          Navigator.pushNamed(
            context,
            AddEventScreen.routeName,
          );
        },
        child: Icon(
          Icons.add,
          color: appColors.white,
        ),
      ),
    );
  }

  Widget buildEventCard(Event event) {
    var date = event.eventRegistrationDeadline.split("T")[0];

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        color: const Color(0xfffbfcf8),
        margin: const EdgeInsets.all(8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        elevation: 4.0,
        child: Column(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10), topRight: Radius.circular(10)),
              child: GestureDetector(
                child: Image.network(
                  event.eventImage,
                  height: 220,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                onTap: () {
                  Navigator.pushNamed(
                      context, FacultyEventDetailsScreen.routeName,
                      arguments: event);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              child: Row(
                children: [
                  Card(
                    color: Colors.white.withOpacity(0.9),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    elevation: 4.0,
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            date.split(" ")[0].split("-")[2],
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                          Text(
                            month(int.parse(date.split("-")[1])),
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(event.eventName,
                            style: Theme.of(context).textTheme.titleMedium),
                        Text(
                          event.eventDescription,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          textAlign: TextAlign.justify,
                          style: Theme.of(context).textTheme.bodySmall,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 4,
            ),
            const Divider(
              height: 2,
              thickness: 2,
            ),
            const SizedBox(
              height: 6,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/images/edit.png',
                        height: 14,
                      ),
                      const SizedBox(width: 12),
                      const Text('Edit'),
                    ],
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, EditEventScreen.routeName,
                        arguments: event);
                  },
                ),
                const SizedBox(width: 65),
                const Text(
                  '|',
                  style: TextStyle(fontSize: 25),
                ),
                const SizedBox(width: 65),
                GestureDetector(
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/images/delete.png',
                        height: 14,
                      ),
                      const SizedBox(width: 8),
                      const Text('Delete'),
                    ],
                  ),
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          actions: [
                            ElevatedButton(
                              onPressed: () {
                                eventServices.deleteEvent(
                                  context: context,
                                  event: event,
                                  onSuccess: () {
                                    setState(() {
                                      events;
                                    });
                                  },
                                );
                              },
                              child: const Text('Yes'),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text('No'),
                            ),
                          ],
                          title: const Text('Status'),
                          content: const Text('Are you sure to delete Event?'),
                        );
                      },
                    );
                  },
                ),
              ],
            ),
            const SizedBox(
              height: 12,
            )
          ],
        ),
      ),
    );
  }

  Widget filterOption(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          Text('Select your preference',
              style: Theme.of(context).primaryTextTheme.labelLarge),
          const SizedBox(height: 10.0),
          Wrap(
            spacing: 20.0,
            children: List<Widget>.generate(
              2,
              (int index) {
                String optionText = 'UG';

                switch (index) {
                  case 0:
                    optionText = 'UG';
                    break;
                  case 1:
                    optionText = 'PG';
                    break;

                  default:
                    optionText = '';
                    break;
                }
                return ChoiceChip(
                  checkmarkColor: _value == index ? Colors.white : Colors.black,
                  backgroundColor: const Color(0xffE9F2F5),
                  selectedColor: const Color(0xff0B3F63),
                  label: Text(
                    optionText,
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: _value == index
                          ? Colors.white // Text color when selected
                          : Colors.black, // Text color when not selected
                    ),
                  ),
                  selected: _value == index,
                  onSelected: (bool selected) {
                    setState(() {
                      _value = selected ? index : null;
                    });
                  },
                );
              },
            ).toList(),
          ),
        ],
      ),
    );
  }

  String month(int? index) {
    switch (index) {
      case 00:
        return '';
      case 01:
        return 'Jan';
      case 02:
        return 'Feb';
      case 03:
        return 'Mar';
      case 04:
        return 'Apr';
      case 05:
        return 'May';
      case 06:
        return 'Jun';
      case 07:
        return 'Jul';
      case 08:
        return 'Aug';
      case 09:
        return 'Sep';
      case 10:
        return 'Oct';
      case 11:
        return 'Nov';
      case 12:
        return 'Dec';

      default:
        return '';
    }
  }
}
