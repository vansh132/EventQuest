import 'package:eventquest/models/event.dart';
import 'package:eventquest/screens/student_screens/event_screens/event_detail_screen.dart';
import 'package:eventquest/services/event_services.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class EventScreen extends StatefulWidget {
  static const String routeName = '/event-screen';
  const EventScreen({Key? key}) : super(key: key);

  @override
  State<EventScreen> createState() => _EventScreenState();
}

class _EventScreenState extends State<EventScreen> {
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
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
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
            const SizedBox(height: 8),
            filterOption(context),
            const SizedBox(height: 20),
            // Here, remove the Expanded and just use SizedBox
            SizedBox(
              height: height * 0.59,
              child: FutureBuilder(
                future: Future.delayed(
                    const Duration(seconds: 1), () => getAllPost()),
                initialData: events,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListView.builder(
                        itemCount: 5,
                        itemBuilder: (context, index) {
                          return Shimmer.fromColors(
                            baseColor: Colors.grey[300]!,
                            highlightColor: Colors.grey[100]!,
                            child: buildShimmerEventCard(),
                          );
                        },
                      ),
                    );
                  } else if (snapshot.data!.isEmpty) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/noDataFound.gif',
                          height: 100,
                        ),
                        Text(
                          'No Events found',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ],
                    );
                  } else if (snapshot.hasData) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          return buildEventCard(snapshot.data![index]);
                        },
                      ),
                    );
                  } else {
                    return const CircularProgressIndicator();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildEventCard(Event event) {
    var date = event.eventRegistrationDeadline.split("T")[0];
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, EventDetailsScreen.routeName,
            arguments: event);
      },
      child: Card(
        color: const Color(0xffF7FCFF),
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
              child: Image.network(
                event.eventImage,
                height: 220,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
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

  Widget buildShimmerEventCard() {
    return Card(
      margin: const EdgeInsets.all(8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      elevation: 4.0,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Container(
          height: 224,
          width: double.infinity,
          color: Colors.grey[300],
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
