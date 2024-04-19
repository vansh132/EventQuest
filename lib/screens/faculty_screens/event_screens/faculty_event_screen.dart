import 'dart:async';
import 'package:eventquest/models/event.dart';
import 'package:eventquest/screens/faculty_screens/event_screens/add_event_screen.dart';
import 'package:eventquest/screens/faculty_screens/event_screens/edit_event_screen.dart';
import 'package:eventquest/screens/student_screens/event_screens/event_detail_screen.dart';
import 'package:eventquest/services/event_services.dart';
import 'package:eventquest/themes.dart';
import 'package:eventquest/widgets/top_bar.dart';
import 'package:eventquest/widgets/user_info.dart';
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
      events = await eventServices.getAllEvents(context);
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
    return Scaffold(
      body: Column(
        children: [
          TopBar(),
          UserBar(context),
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
                  return Center(child: CircularProgressIndicator());
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
                      String date = entry.key;
                      List<Event> eventsForDate = entry.value;
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
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
        backgroundColor: AppColors.mainColor,
        onPressed: () {
          Navigator.pushNamed(
            context,
            AddEventScreen.routeName,
          );
        },
        child: const Icon(
          Icons.add,
          color: Color(0xffffffff),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  color: const Color(0xff012a4a),
                  icon: const Icon(Icons.remove_red_eye),
                  onPressed: () {
                    Navigator.pushNamed(context, EventDetailsScreen.routeName,
                        arguments: event);
                  },
                ),
                IconButton(
                  color: const Color(0xff012a4a),
                  icon: const Icon(Icons.edit),
                  onPressed: () {
                    Navigator.pushNamed(context, EditEventScreen.routeName,
                        arguments: event);
                  },
                ),
                IconButton(
                  color: const Color(0xff012a4a),
                  icon: const Icon(Icons.delete),
                  onPressed: () {
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
                                      events.remove(event);
                                    });
                                  },
                                );
                              },
                              child: const Text('Yes'),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text('No'),
                            )
                          ],
                          title: const Text('Status'),
                          content: const Text('Are you sure to delete Event ?'),
                        );
                      },
                    );
                  },
                ),
              ],
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                event.eventImage,
                height: 224,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Card(
                    color: const Color(0xffd4d7df),
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
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            month(int.parse(date.split(" ")[0].split("-")[1])),
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
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
                        Text(
                          event.eventName,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          event.eventDescription,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          textAlign: TextAlign.justify,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
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
          const Text(
            'Select your preference:',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 10.0),
          Wrap(
            spacing: 20.0,
            children: List<Widget>.generate(
              2,
              (int index) {
                String optionText = '';
                switch (index) {
                  case 0:
                    optionText = 'UG';
                    break;
                  case 1:
                    optionText = 'PG';
                    break;
                  case 2:
                    optionText = 'Both';
                    break;

                  default:
                    optionText = '';
                    break;
                }

                return ChoiceChip(
                  selectedColor: const Color(0xffd4d7df),
                  label: Text(
                    optionText,
                    style: const TextStyle(
                      color: Color(0xff012a4a),
                      fontWeight: FontWeight.w700,
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
