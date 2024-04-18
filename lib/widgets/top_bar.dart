import 'package:eventquest/constants/custom_colors.dart';
import 'package:flutter/material.dart';

Widget TopBar() {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: CustomColors.bgDark,
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "EventQuest",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: CustomColors.secondaryLightTextColor,
            fontFamily: 'Roboto-Black',
          ),
        ),
        Image.asset(
          scale: 1,
          height: 48,
          "assets/images/christ-logo-color.png",
          fit: BoxFit.cover,
        ),
      ],
    ),
  );
}
