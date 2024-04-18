import 'package:eventquest/constants/custom_colors.dart';
import 'package:eventquest/provider/user_provider.dart';
import 'package:eventquest/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Widget UserBar(BuildContext context) {
  final userProvider = Provider.of<UserProvider>(context, listen: false);

  return Container(
    margin: const EdgeInsets.all(8),
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(24),
      color: CustomColors.bgDark,
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(Icons.person_2_rounded,
                color: CustomColors.secondaryTextColor),
            SizedBox(
              width: 12,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  userProvider.user.username,
                  style: TextStyle(
                    color: CustomColors.secondaryLightTextColor,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.3,
                    fontSize: 16,
                  ),
                ),
                Text(
                  userProvider.user.type,
                  style: TextStyle(
                    color: CustomColors.secondaryLightTextColor,
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
          onPressed: () {
            Navigator.of(context).pushNamedAndRemoveUntil(
                LoginScreen.routeName, (route) => false);
          },
          icon: Icon(
            Icons.logout_rounded,
            color: CustomColors.secondaryTextColor,
          ),
          label: Text(
            "Log Out",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: CustomColors.secondaryTextColor,
            ),
          ),
        )
      ],
    ),
  );
}
