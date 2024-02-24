import 'package:eventquest/models/event.dart';
import 'package:eventquest/screens/faculty_screens/event_screens/add_event_screen.dart';
import 'package:eventquest/screens/faculty_screens/event_screens/edit_event_screen.dart';
import 'package:eventquest/screens/student_screens/event_screens/event_detail_screen.dart';
import 'package:eventquest/services/event_services.dart';

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

  EventServices eventServices = EventServices();

  // Future<List<Event>> _data;
  List<Event> events = [];
  Future<List<Event>> getAllPost() async {
    if (_value == 0) {
      events = await eventServices.getAllUgEvents(context);
    } else if (_value == 1) {
      events = await eventServices.getAllPgEvents(context);
    } else {
      events = await eventServices.getAllEvents(context);
    }
    setState(() {
      events;
    });
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
        body: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              TopBar(),
              UserBar(),
              const SizedBox(
                height: 8,
              ),
              filterOption(context),
              const SizedBox(height: 20),
              FutureBuilder(
                future: getAllPost(),
                initialData: events,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            return buildEventCard(snapshot.data![index]);
                          },
                        ),
                      ),
                    );
                  } else if (snapshot.data == null) {
                    return const Center(
                      child: Text("No data found"),
                    );
                  } else {
                    return const CircularProgressIndicator();
                  }
                },
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(
              context,
              AddEventScreen.routeName,
            );
          },
          child: const Icon(Icons.add),
        ));
  }

  Widget buildEventCard(Event event) {
    var date = event.eventRegistrationDeadline.split("T")[0];
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, EventDetailsScreen.routeName,
            arguments: event);
      },
      child: Card(
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
                  icon: const Icon(Icons.remove_red_eye),
                  onPressed: () {
                    Navigator.pushNamed(context, EventDetailsScreen.routeName,
                        arguments: event);
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () {
                    Navigator.pushNamed(context, EditEventScreen.routeName,
                        arguments: event);
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    eventServices.deleteEvent(
                        context: context,
                        event: event,
                        onSuccess: () {
                          setState(() {
                            events;
                          });
                        });
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
                    color: Colors.white.withOpacity(0.7),
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
                            date.split("-")[2],
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            month(int.parse(date.split("-")[1])),
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
              fontWeight: FontWeight.w500,
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

                  default:
                    optionText = '';
                    break;
                }

                return ChoiceChip(
                  label: Text(
                    optionText,
                    style: const TextStyle(
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

  String getCategory(int? index) {
    if (index == null) {
      return '';
    }

    switch (index) {
      case 0:
        return 'UG';
      case 1:
        return 'PG';

      default:
        return '';
    }
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
