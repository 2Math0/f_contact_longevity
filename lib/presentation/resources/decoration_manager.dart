import 'package:flutter/material.dart';

import 'values_manager.dart';

class AppDecoration {
  const AppDecoration();

  BoxDecoration get lightRoundedBorder =>
      BoxDecoration(borderRadius: BorderRadius.circular(AppCircularRadius.cr6));

  BoxDecoration get highRoundedBorder => BoxDecoration(
      borderRadius: BorderRadius.circular(AppCircularRadius.cr48));
}
