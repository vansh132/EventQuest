import 'package:eventquest/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Widget UserBar(BuildContext context) {
  final userProvider = Provider.of<UserProvider>(context, listen: false);

  return Container(
    margin: const EdgeInsets.all(8),
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(24),
      color: Color.fromARGB(240, 1, 42, 74),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            const Icon(Icons.person_2_rounded,
                color: Color.fromARGB(255, 204, 169, 57)),
            SizedBox(
              width: 12,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  userProvider.user.username,
                  style: const TextStyle(
                    color: Color(0xffefefd0),
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.3,
                    fontSize: 16,
                  ),
                ),
                Text(
                  userProvider.user.type,
                  style: const TextStyle(
                    color: Color.fromARGB(255, 251, 251, 213),
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.3,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ],
        ),
        TextButton.icon(
          onPressed: () {},
          icon: const Icon(
            Icons.logout_rounded,
            color: Color.fromARGB(255, 204, 169, 57),
          ),
          label: const Text(
            "Log Out",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 204, 169, 57),
            ),
          ),
        )
      ],
    ),
  );
}
