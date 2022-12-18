import 'package:flutter/material.dart';

import '../../../resources/colors_manager.dart';
import '../../../resources/decoration_manager.dart';
import '../../../resources/strings_manager.dart';
import '../../../resources/text_styles_manager.dart';
import '../../../resources/values_manager.dart';

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
    Size size = MediaQuery.of(context).size;
    return Row(
      children: [
        if (isSender == true) const Expanded(child: SizedBox()),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            ConstrainedBox(
              constraints: BoxConstraints(
                  minWidth: AppSize.s100, maxWidth: size.width * 0.75),
              child: Container(
                padding: const EdgeInsets.symmetric(
                    vertical: AppPadding.p4, horizontal: AppPadding.p8),
                decoration: const AppDecoration()
                    .lightRoundedBorder
                    .copyWith(color: AppColors.primaryTransBlue),
                child: Text(
                  message,
                  softWrap: true,
                  style: const AppTextStyles().bodyTextMediumRegular,
                ),
              ),
            ),
            if (isSender == true)
              Text(
                seenTime == null
                    ? 'not seen'
                    : '${AppStrings.seen}  ${seenTime.toString()}',
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
