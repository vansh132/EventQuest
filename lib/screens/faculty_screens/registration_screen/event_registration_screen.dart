import 'package:event_quest/models/registration.dart';
import 'package:event_quest/screens/faculty_screens/registration_screen/event_registration_detail_screen.dart';
import 'package:event_quest/services/registration_services.dart';
import 'package:flutter/material.dart';

class EventRegistrationScreen extends StatefulWidget {
  static const String routeName = "/event-registration-screen";

  const EventRegistrationScreen({Key? key}) : super(key: key);

  @override
  State<EventRegistrationScreen> createState() =>
      _EventRegistrationScreenState();
}

class _EventRegistrationScreenState extends State<EventRegistrationScreen> {
  RegistrationServices registrationServices = RegistrationServices();
  late Future<List<Registration>> _registrationsFuture;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _registrationsFuture = registrationServices.getAllRegistrations(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Event Registrations"),
      ),
      backgroundColor: const Color(0xffFfFfFf),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: _searchController,
                decoration: const InputDecoration(
                  labelText: 'Search by Event Name',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  setState(() {});
                },
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: FutureBuilder<List<Registration>>(
                future: _registrationsFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text('Error: ${snapshot.error}'),
                    );
                  } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                    List<Registration> filteredRegistrations =
                        snapshot.data!.where((registration) {
                      return registration.eventName
                          .toLowerCase()
                          .contains(_searchController.text.toLowerCase());
                    }).toList();

                    if (filteredRegistrations.isEmpty) {
                      return const Center(
                        child: Text('No matching results found.'),
                      );
                    }

                    // Group registrations by event name
                    Map<String, List<Registration>> groupedRegistrations = {};
                    filteredRegistrations.forEach((registration) {
                      if (!groupedRegistrations
                          .containsKey(registration.eventName)) {
                        groupedRegistrations[registration.eventName] = [];
                      }
                      groupedRegistrations[registration.eventName]!
                          .add(registration);
                    });

                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: groupedRegistrations.entries.map((entry) {
                            String eventName = entry.key;
                            List<Registration> registrations = entry.value;

                            return ListTile(
                              title: Text(
                                eventName,
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                              trailing: const Icon(Icons.arrow_forward_ios),
                              onTap: () {
                                Navigator.of(context).pushNamed(
                                    EventRegistrationDetailScreen.routeName,
                                    arguments: registrations);
                              },
                            );
                          }).toList(),
                        ),
                      ),
                    );
                  } else {
                    return const Center(
                      child: Text("No data found"),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
