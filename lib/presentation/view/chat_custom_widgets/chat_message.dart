import 'package:flutter/material.dart';

import '../../resources/colors_manager.dart';
import '../../resources/decoration_manager.dart';
import '../../resources/strings_manager.dart';
import '../../resources/text_styles_manager.dart';
import '../../resources/values_manager.dart';

class ChatMessage extends StatelessWidget {
  final String message;
  final bool isSender;
  final String? seenTime;
  const ChatMessage({
    Key? key,
    required this.message,
    required this.isSender,
    this.seenTime,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (isSender == true) const Expanded(child: SizedBox()),
        Column(
          children: [
            ConstrainedBox(
              constraints: const BoxConstraints(minWidth: AppSize.s100),
              child: Container(
                padding: const EdgeInsets.symmetric(
                    vertical: AppPadding.p4, horizontal: AppPadding.p8),
                decoration: const AppDecoration()
                    .lightRoundedBorder
                    .copyWith(color: AppColors.primaryTransBlue),
                child: Text(
                  message,
                  style: const AppTextStyles().bodyTextMediumRegular,
                ),
              ),
            ),
            if (isSender == true)
              Text(
                '${AppStrings.seen}  ${seenTime.toString()}',
                style: const AppTextStyles().dateTextRegular,
              ),
            const SizedBox(
              height: AppMargin.m8,
            )
          ],
        ),
        if (isSender == false) const Expanded(child: SizedBox()),
      ],
    );
  }
}
