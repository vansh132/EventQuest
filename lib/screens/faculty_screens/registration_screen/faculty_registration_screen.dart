import 'package:eventquest/models/registration.dart';
import 'package:eventquest/services/registration_services.dart';
import 'package:eventquest/widgets/top_bar.dart';
import 'package:eventquest/widgets/user_info.dart';
import 'package:flutter/material.dart';

class FacultyRegistrationScreen extends StatefulWidget {
  static const String routeName = "/faculty-registration-screen";

  const FacultyRegistrationScreen({Key? key}) : super(key: key);

  @override
  State<FacultyRegistrationScreen> createState() =>
      _FacultyRegistrationScreenState();
}

class _FacultyRegistrationScreenState extends State<FacultyRegistrationScreen> {
  RegistrationServices registrationServices = RegistrationServices();
  late Future<List<Registration>> _registrationsFuture;
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _registrationsFuture = registrationServices.getAllRegistrations(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffFfFfFf),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            TopBar(),
            UserBar(context),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
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
                    // Filter registrations based on search query
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

                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  eventName,
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: DataTable(
                                    columnSpacing: 10,
                                    columns: [
                                      DataColumn(label: Text('User Name')),
                                      DataColumn(label: Text('Event Amount')),
                                      DataColumn(
                                          label: Text('Participants Name')),
                                      DataColumn(
                                          label: Text('Participants Category')),
                                      DataColumn(
                                          label:
                                              Text('Participants Register No')),
                                    ],
                                    rows: registrations.map((registration) {
                                      return DataRow(cells: [
                                        DataCell(Text(registration.userName)),
                                        DataCell(
                                            Text(registration.eventAmount)),
                                        DataCell(Text(registration
                                            .participantsName
                                            .toString()
                                            .replaceAll(
                                                RegExp(r'[\[\]]'), ''))),
                                        DataCell(Text(registration
                                            .participantsCategory
                                            .toString()
                                            .replaceAll(
                                                RegExp(r'[\[\]]'), ''))),
                                        DataCell(Text(registration
                                            .participantsRegisterNo
                                            .toString()
                                            .replaceAll(
                                                RegExp(r'[\[\]]'), ''))),
                                      ]);
                                    }).toList(),
                                  ),
                                ),
                              ],
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
