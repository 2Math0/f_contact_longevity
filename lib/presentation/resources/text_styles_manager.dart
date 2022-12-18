import 'package:f_contact_longevity/presentation/resources/colors_manager.dart';
import 'package:f_contact_longevity/presentation/resources/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextStyles {
  const AppTextStyles();

  TextStyle get bodyTextLargeRegular => const TextStyle(
        fontSize: AppSize.s24,
        decoration: TextDecoration.none,
        fontStyle: FontStyle.normal,
        color: AppColors.messageTextColorDark,
      );

  TextStyle get bodyTextMediumRegular => const TextStyle(
        fontSize: AppSize.s18,
        decoration: TextDecoration.none,
        fontStyle: FontStyle.normal,
        color: AppColors.messageTextColorDark,
      );
  TextStyle get bodyTextNormalRegular => const TextStyle(
        fontSize: AppSize.s16,
        decoration: TextDecoration.none,
        fontStyle: FontStyle.normal,
        color: AppColors.messageTextColorDark,
      );

  TextStyle get hintTextRegular => const TextStyle(
        fontSize: AppSize.s14,
        decoration: TextDecoration.none,
        fontStyle: FontStyle.normal,
        color: AppColors.hintTextGreyColor,
      );

  TextStyle get dateTextRegular => TextStyle(
        fontSize: AppSize.s12,
        decoration: TextDecoration.none,
        fontStyle: FontStyle.normal,
        color: AppColors.neutralDark,
        fontFamily: GoogleFonts.dmMono().fontFamily,
      );

  TextStyle get bodyTextSmallRegular => const TextStyle(
        fontSize: AppSize.s14,
        decoration: TextDecoration.none,
        fontStyle: FontStyle.normal,
        color: AppColors.primaryGreen,
      );
}
