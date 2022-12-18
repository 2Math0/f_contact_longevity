import 'package:f_contact_longevity/presentation/resources/text_styles_manager.dart';
import 'package:f_contact_longevity/presentation/resources/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'colors_manager.dart';

ThemeData getApplicationTheme() {
  return ThemeData(
      // main colors of the app
      primaryColor: AppColors.primaryBlue,
      disabledColor: AppColors.neutralDark,

      // App bar theme
      appBarTheme: AppBarTheme(
          centerTitle: true,
          elevation: AppElevation.e3,
          titleTextStyle: const AppTextStyles().bodyTextLargeRegular),
      // Button theme
      buttonTheme: const ButtonThemeData(
        shape: StadiumBorder(),
        disabledColor: AppColors.neutralDark,
        buttonColor: AppColors.primaryBlue,
        // splashColor:
      ),

      // elevated button theme
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              textStyle: const AppTextStyles().bodyTextMediumRegular,
              // primary: AppColors.primaryBlue, // deprecated
              shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(AppCircularRadius.cr48)))),

      // default font family
      fontFamily: GoogleFonts.dmSans().fontFamily,

      // Text theme

      // input decoration theme (text form field)

      inputDecorationTheme: InputDecorationTheme(
        contentPadding: const EdgeInsets.all(AppPadding.p8),
        // hint style
        hintStyle: const AppTextStyles().hintTextRegular,

        // error style
        // enabled border
        // focused border
        // error border
        // focused error border
      ));
}
