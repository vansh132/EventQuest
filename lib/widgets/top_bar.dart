import 'package:event_quest/constants/custom_colors.dart';
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

Widget branding(BuildContext context) {
  return Container(
    padding: const EdgeInsets.all(12),
    child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "EventQuest",
              style: Theme.of(context).textTheme.displayLarge,
            ),
            Image.asset(
              scale: 1,
              height: 48,
              "assets/images/christ-logo-color.png",
              fit: BoxFit.cover,
            ),
          ],
        ),
        SizedBox(
          height: 12,
        ),
        Text(
          "Developed by",
          style: Theme.of(context).primaryTextTheme.labelLarge!.copyWith(
                fontSize: 16,
                fontWeight: FontWeight.w300,
              ),
        ),
        Text(
          "Department of Computer Science",
          style: Theme.of(context).primaryTextTheme.labelLarge!.copyWith(
                fontSize: 16,
                fontWeight: FontWeight.w300,
              ),
        ),
      ],
    ),
  );
}
