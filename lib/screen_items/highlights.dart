import 'package:flutter/material.dart';

List<String> images = [
  "https://images.unsplash.com/photo-1525921429624-479b6a26d84d?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
  "https://plus.unsplash.com/premium_photo-1682284353470-53c3a913bded?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
  "https://img.freepik.com/free-vector/flat-illustration-back-school-season_23-2150599794.jpg?w=740&t=st=1706267291~exp=1706267891~hmac=c3c73e2c9eb34f4cbc57004f0ac546bc6e2b0d97d7e067cf45de01845ff1ea68",
  "https://img.freepik.com/free-photo/front-view-smiley-man-holding-book_23-2149915900.jpg?w=360&t=st=1706267307~exp=1706267907~hmac=7f9fb76e4341662680c8ecde9d05a1aa2226ead4509564c8a88f61a2f5bf3363",
];

Widget Highlights() {
  return Container(
    height: 210,
    padding: const EdgeInsets.symmetric(horizontal: 8),
    // width: 300,
    // color: Colors.cyanAccent,
    child: ListView.builder(
      itemCount: images.length,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        return Container(
          // height: 100,
          width: 140,
          margin: const EdgeInsets.symmetric(horizontal: 4),
          decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.circular(12),
            image: DecorationImage(
              image: NetworkImage(
                images[index],
              ),
              fit: BoxFit.cover,
            ),
          ),
        );
      },
    ),
  );
}
