import 'package:flutter/material.dart';

Widget Highlights() {
  return Container(
    height: 210,
    padding: EdgeInsets.symmetric(horizontal: 8),
    // width: 300,
    // color: Colors.cyanAccent,
    child: ListView.builder(
      itemCount: 9,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        return Container(
          // height: 100,
          width: 140,
          margin: EdgeInsets.symmetric(horizontal: 4),
          decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(child: Text("Img $index")),
        );
      },
    ),
  );
}
