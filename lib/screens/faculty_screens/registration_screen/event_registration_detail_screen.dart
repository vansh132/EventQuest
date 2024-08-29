import 'package:event_quest/models/registration.dart';
import 'package:flutter/material.dart';

class EventRegistrationDetailScreen extends StatefulWidget {
  static const String routeName = "/event-registration-detail-screen";

  const EventRegistrationDetailScreen({super.key});

  @override
  State<EventRegistrationDetailScreen> createState() =>
      _EventRegistrationDetailScreenState();
}

class _EventRegistrationDetailScreenState
    extends State<EventRegistrationDetailScreen> {
  TextEditingController _searchController = TextEditingController();
  List<Registration> _filteredRegistrations = [];
  List<Registration> _allRegistrations = [];

  @override
  void initState() {
    super.initState();
    // Initialize search controller and listen for changes
    _searchController.addListener(() {
      _filterRegistrations(_searchController.text);
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterRegistrations(String query) {
    setState(() {
      if (query.isEmpty) {
        _filteredRegistrations = _allRegistrations;
      } else {
        _filteredRegistrations = _allRegistrations.where((registration) {
          bool matchesName = registration.participantsName
              .any((name) => name.toLowerCase().contains(query.toLowerCase()));
          bool matchesRegisterNo = registration.participantsRegisterNo.any(
              (registerNo) =>
                  registerNo.toLowerCase().contains(query.toLowerCase()));
          return matchesName || matchesRegisterNo;
        }).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // Get the list of registrations passed from the previous screen
    _allRegistrations =
        ModalRoute.of(context)!.settings.arguments as List<Registration>;

    // Initialize the filtered list with all registrations
    _filteredRegistrations = _filteredRegistrations.isNotEmpty
        ? _filteredRegistrations
        : _allRegistrations;

    // Get the event name from the first registration (assuming all registrations are for the same event)
    String eventName = _filteredRegistrations.isNotEmpty
        ? _filteredRegistrations.first.eventName
        : "Unknown Event";

    return Scaffold(
      appBar: AppBar(
        title: Text(eventName),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Search by Name or Register No',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(
              "Total Registrations: ${_filteredRegistrations.length}",
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _filteredRegistrations.length,
              itemBuilder: (context, index) {
                var registration = _filteredRegistrations[index];
                var participantNames = registration.participantsName;
                var participantRegisterNos =
                    registration.participantsRegisterNo;
                var participantCategories = registration.participantsCategory;

                return Container(
                  margin: const EdgeInsets.all(8),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(
                        0xffFEFEFA), // Background color of the container
                    borderRadius: BorderRadius.circular(8.0), // Rounded corners
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5), // Shadow color
                        spreadRadius: 2, // How much the shadow spreads
                        blurRadius: 5, // How much the shadow is blurred
                        offset: const Offset(0, 3), // Shadow offset (x, y)
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Text(
                          'Registered By: ${registration.userName}',
                          style:
                              Theme.of(context).textTheme.titleSmall!.copyWith(
                                    color: Colors.black.withOpacity(0.8),
                                  ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Table(
                        border: TableBorder.all(color: Colors.grey),
                        columnWidths: const {
                          0: FlexColumnWidth(1.5),
                          1: FlexColumnWidth(1.5),
                          2: FlexColumnWidth(1.5),
                        },
                        children: [
                          // Header Row
                          const TableRow(
                            children: [
                              TableCell(
                                  child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Center(
                                  child: Text('Name',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                ),
                              )),
                              TableCell(
                                  child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Center(
                                  child: Text('Register No',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                ),
                              )),
                              TableCell(
                                  child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Center(
                                  child: Text('Course',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                ),
                              )),
                            ],
                          ),
                          // Data Rows
                          for (int i = 0; i < participantNames.length; i++)
                            TableRow(
                              children: [
                                TableCell(
                                    child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(participantNames[i]),
                                )),
                                TableCell(
                                    child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(participantRegisterNos[i]),
                                )),
                                TableCell(
                                    child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(participantCategories[i]),
                                )),
                              ],
                            ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
