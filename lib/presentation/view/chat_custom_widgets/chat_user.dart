import 'package:flutter/material.dart';

import '../../resources/colors_manager.dart';
import '../../resources/strings_manager.dart';
import '../../resources/text_styles_manager.dart';
import '../../resources/values_manager.dart';

class UserChat extends StatelessWidget {
  final String name;
  final bool isOnline;
  final String image;
  final String? meeting;
  const UserChat({
    Key? key,
    required this.name,
    required this.image,
    required this.isOnline,
    this.meeting,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CircleAvatar(
              radius: AppSize.s24,
              // this will remove color border of the image
              backgroundColor: Colors.transparent,
              child: Image.asset(image),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const AppTextStyles().bodyTextLargeRegular,
                ),
                Text(
                  isOnline ? AppStrings.online : AppStrings.offline,
                  style: const AppTextStyles().bodyTextSmallRegular.copyWith(
                      color: isOnline ? AppColors.primaryGreen : Colors.red),
                )
              ],
            ),
            IconButton(
                onPressed: () {},
                icon: Image.asset(
                  'assets/icons/meeting.png',
                  color: Colors.blue,
                  width: AppSize.s20,
                )),
            Visibility(
                visible: meeting != null,
                child: Text(
                  'meeting at $meeting',
                  style: const AppTextStyles().dateTextRegular,
                ))
          ],
        )
      ],
    );
  }
}
