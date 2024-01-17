import 'package:flutter/material.dart';

Widget UserBar() {
  return Container(
    margin: EdgeInsets.all(8),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(24),
      color: Colors.black,
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(Icons.person_2_rounded, color: Colors.white),
            SizedBox(
              width: 12,
            ),
            Column(
              children: [
                Text(
                  "Vansh Shah",
                  style: TextStyle(color: Colors.white),
                ),
                Text(
                  "2347152",
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ],
        ),
        TextButton.icon(
          onPressed: () {},
          icon: Icon(Icons.logout_rounded),
          label: Text("Log Out"),
        )
      ],
    ),
  );
}
