import 'package:eventquest/constants/custom_colors.dart';
import 'package:eventquest/provider/user_provider.dart';
import 'package:eventquest/screens/login_screen.dart';
import 'package:eventquest/theme/theme_ext.dart';
import 'package:eventquest/widgets/fade.dart';
import 'package:eventquest/widgets/slide.dart';
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
            const SizedBox(
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

Widget userDetails(BuildContext context) {
  final userProvider = Provider.of<UserProvider>(context, listen: false);
  final appColors = context.appColors;
  return Container(
    alignment: Alignment.center,
    padding: const EdgeInsets.all(12),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            IconButton(
              style: ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(
                  appColors.accent,
                ),
              ),
              onPressed: () {},
              icon: const Icon(
                size: 30,
                Icons.person_3,
              ),
              color: appColors.primary,
            ),
            const SizedBox(
              width: 12,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  userProvider.user.username,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                Text(
                  userProvider.user.type,
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                      color: appColors.primary.withOpacity(0.8)),
                ),
              ],
            ),
          ],
        ),
        ElevatedButton.icon(
          autofocus: true,
          style: ButtonStyle(
              animationDuration: Durations.extralong4,
              backgroundColor: WidgetStatePropertyAll(appColors.accent)),
          iconAlignment: IconAlignment.end,
          onPressed: () {
            // Navigator.of(context).pushNamedAndRemoveUntil(
            //   LoginScreen.routeName,
            //   (route) => false,
            // );
            Navigator.of(context).pushAndRemoveUntil(
              SlidePageRoute(
                  page:
                      LoginScreen()), // Use your actual LoginScreen widget here
              (route) => false,
            );
            // Navigator.of(context).pushAndRemoveUntil(
            //   FadePageRoute(
            //       page:
            //           LoginScreen()), // Use your actual LoginScreen widget here
            //   (route) => false,
            // );
            // showAboutDialog(context: context);
          },
          icon: Icon(
            Icons.logout,
            color: appColors.primary,
          ),
          label: Text(
            "Log Out",
            style: Theme.of(context).textTheme.titleSmall,
          ),
        )
      ],
    ),
  );
}
