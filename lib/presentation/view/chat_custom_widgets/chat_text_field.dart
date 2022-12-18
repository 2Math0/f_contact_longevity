import 'package:flutter/material.dart';

import '../../resources/colors_manager.dart';
import '../../resources/text_styles_manager.dart';
import '../../resources/values_manager.dart';

class ChatTextField extends StatelessWidget {
  const ChatTextField({
    Key? key,
    required this.textController,
    required this.maxWidthRatio,
    required this.hintText,
  }) : super(key: key);

  final TextEditingController textController;
  final double maxWidthRatio;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return TextField(
      decoration: InputDecoration(
          filled: true,
          constraints: BoxConstraints(maxWidth: size.width * maxWidthRatio),
          isDense: true,
          hintText: hintText,
          fillColor: AppColors.primaryTransBlue,
          hintStyle: const AppTextStyles().hintTextRegular,
          contentPadding: const EdgeInsets.symmetric(
              horizontal: AppPadding.p12, vertical: AppPadding.p4),
          border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(AppCircularRadius.cr48))),
      controller: textController,
    );
  }
}
