import 'package:flutter/material.dart';

Widget UserBar() {
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
        const Row(
          children: [
            Icon(Icons.person_2_rounded,
                color: Color.fromARGB(255, 245, 211, 97)),
            SizedBox(
              width: 12,
            ),
            Column(
              children: [
                Text(
                  "Vansh Shah",
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
                  "2347152",
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
          onPressed: () {},
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
