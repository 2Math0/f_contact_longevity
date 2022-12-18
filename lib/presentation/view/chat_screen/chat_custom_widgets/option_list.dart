import 'package:flutter/material.dart';

import '../../../resources/colors_manager.dart';
import '../../../resources/decoration_manager.dart';
import '../../../resources/text_styles_manager.dart';
import '../../../resources/values_manager.dart';

class ChatOptionList extends StatelessWidget {
  final String question;
  final List<String> options;
  const ChatOptionList(
      {Key? key, required this.question, required this.options})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(children: [
      Row(
        children: [
          const Expanded(child: SizedBox()),
          Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
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
                  question,
                  softWrap: true,
                  style: const AppTextStyles().bodyTextMediumRegular,
                ),
              ),
            ),
          ])
        ],
      ),
      Align(
        alignment: Alignment.centerLeft,
        child: SizedBox(
          width: size.width * 0.75,
          child: Wrap(
            children: [
              for (int i = 0; i < options.length; i++)
                BluishContainer(
                    child: Text(
                  options[i],
                  style: const AppTextStyles().bodyTextMediumRegular,
                )),
            ],
          ),
        ),
      )
    ]);
  }
}

class BluishContainer extends StatelessWidget {
  final Widget child;
  const BluishContainer({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: AppPadding.p12, vertical: AppPadding.p4),
      child: Container(
        padding: const EdgeInsets.symmetric(
            horizontal: AppPadding.p12, vertical: AppPadding.p8),
        decoration: BoxDecoration(
            color: AppColors.primaryTransBlue,
            borderRadius: BorderRadius.circular(AppCircularRadius.cr48)),
        child: child,
      ),
    );
  }
}
