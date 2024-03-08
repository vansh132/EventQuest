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
      color: const Color(0xff0D1B2A),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
         Row(
          children: [
            Icon(Icons.person_2_rounded,
                color: Color.fromARGB(255, 245, 211, 97)),
            SizedBox(
              width: 12,
            ),
            Column(
              children: [
                Text(
                  userProvider.user.username,
                  style: TextStyle(
                    color: Color(
                      0xffFFCF33,
                    ),
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.3,
                    fontSize: 16,
                  ),
                ),
                Text(
                  userProvider.user.type,

                  style: TextStyle(
                    color: Color(
                      0xffFFCF33,
                    ),
                    fontWeight: FontWeight.w400,
                    letterSpacing: 0.3,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ],
        ),
        TextButton.icon(
          onPressed: () {

          },
          icon: const Icon(
            Icons.logout_rounded,
            color: Color(0xffe8e8e4),
          ),
          label: const Text(
            "Log Out",
            style: TextStyle(
              color: Color(0xffe8e8e4),
            ),
          ),
        )
      ],
    ),
  );
}
