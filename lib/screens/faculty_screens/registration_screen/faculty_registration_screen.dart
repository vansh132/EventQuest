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

  @override
  void initState() {
    super.initState();
    _registrationsFuture = registrationServices.getAllRegistrations(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            TopBar(),
            UserBar(context),
            const SizedBox(height: 20),
            FutureBuilder<List<Registration>>(
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
                  return Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: DataTable(
                          columnSpacing: 10,
                          columns: [
                            const DataColumn(label: Text('Event Name')),
                            const DataColumn(label: Text('User Name')),
                            const DataColumn(label: Text('Event Amount')),
                            const DataColumn(label: Text('Participants Name')),
                            const DataColumn(
                                label: Text('Participants Category')),
                            const DataColumn(
                                label: Text('Participants Register No')),
                          ],
                          rows: snapshot.data!.map((registration) {
                            return DataRow(cells: [
                              DataCell(Text(registration.eventName)),
                              DataCell(Text(registration.userName)),
                              DataCell(Text(registration.eventAmount)),
                              DataCell(Text(
                                  registration.participantsName.toString())),
                              DataCell(Text(registration.participantsCategory
                                  .toString())),
                              DataCell(Text(registration.participantsRegisterNo
                                  .toString())),
                            ]);
                          }).toList(),
                        ),
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
          ],
        ),
      ),
    );
  }
}
