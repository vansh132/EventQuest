import 'package:event_quest/theme/app_colors.dart';
import 'package:flutter/material.dart';

extension ThemeExt on BuildContext {
  AppColors get appColors =>
      Theme.of(this).extension<AppColors>() ?? LightColor();
}
