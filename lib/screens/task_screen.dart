import 'package:eventquest/widgets/top_bar.dart';
import 'package:eventquest/widgets/user_info.dart';
import 'package:flutter/material.dart';

class TaskScreen extends StatelessWidget {
  const TaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.amber,
        child: Column(
          children: [
            TopBar(),
            UserBar(),
            Container(
                color: Colors.tealAccent,
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                            style: const ButtonStyle(
                              padding:
                                  MaterialStatePropertyAll(EdgeInsets.all(16)),
                              backgroundColor: MaterialStatePropertyAll(
                                Colors.black,
                              ),
                            ),
                            onPressed: () {},
                            child: const Text(
                              "Assigned Tasks",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 72,
                          ),
                          TextButton(
                            onPressed: () {},
                            child: const Text("History"),
                          ),
                        ],
                      ),
                    )
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
