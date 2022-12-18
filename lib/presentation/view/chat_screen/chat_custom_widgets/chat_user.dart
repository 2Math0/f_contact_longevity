import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../resources/colors_manager.dart';
import '../../../resources/strings_manager.dart';
import '../../../resources/text_styles_manager.dart';
import '../../../resources/values_manager.dart';

class UserChat extends StatefulWidget {
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
  State<UserChat> createState() => _UserChatState();
}

class _UserChatState extends State<UserChat> {
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  DateTime dateTime = DateTime.now();
  bool showDateTime = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var now = DateFormat('yyyy/MMM/dd HH:mm').format(DateTime.now());
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
              child: Image.asset(widget.image),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.name,
                  style: const AppTextStyles().bodyTextLargeRegular,
                ),
                Text(
                  widget.isOnline ? AppStrings.online : AppStrings.offline,
                  style: const AppTextStyles().bodyTextSmallRegular.copyWith(
                      color: widget.isOnline
                          ? AppColors.primaryGreen
                          : Colors.red),
                )
              ],
            ),
            IconButton(
                onPressed: () {
                  _selectDateTime(context);
                  showDateTime = true;
                },
                iconSize: AppSize.s20,
                icon: Image.asset(
                  'assets/icons/meeting.png',
                  color: Colors.blue,
                  width: AppSize.s20,
                  fit: BoxFit.fitWidth,
                )),
            Visibility(
                visible: showDateTime || widget.meeting != null,
                child: SizedBox(
                  width: AppSize.s80,
                  child: Text(
                    softWrap: true,
                    'meeting at ${showDateTime ? getDateTime() : widget.meeting} ',
                    style: const AppTextStyles().dateTextRegular,
                  ),
                ))
          ],
        ),
        if (now == getDateTime() && showDateTime == true)
          MaterialButton(
            color: AppColors.primaryBlue,
            minWidth: size.width,
            onPressed: () {},
            child: Text(
              'go to meeting'.toUpperCase(),
              style: AppTextStyles()
                  .bodyTextNormalRegular
                  .copyWith(color: AppColors.backgroundWhite),
            ),
          )
      ],
    );
  }

  // Select for Date
  Future<DateTime> _selectDate(BuildContext context) async {
    final selected = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2022),
      lastDate: DateTime(2023),
    );
    if (selected != null && selected != selectedDate) {
      setState(() {
        selectedDate = selected;
      });
    }
    return selectedDate;
  }

// Select for Time
  Future<TimeOfDay> _selectTime(BuildContext context) async {
    final selected = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (selected != null && selected != selectedTime) {
      setState(() {
        selectedTime = selected;
      });
    }
    return selectedTime;
  }

  Future _selectDateTime(BuildContext context) async {
    final date = await _selectDate(context);
    final time = await _selectTime(context);

    setState(() {
      dateTime = DateTime(
        date.year,
        date.month,
        date.day,
        time.hour,
        time.minute,
      );
    });
  }

  String getDateTime() {
    // ignore: unnecessary_null_comparison
    if (dateTime == null) {
      return 'select date timer';
    } else {
      return DateFormat('yyyy/MMM/dd HH:mm').format(dateTime);
    }
  }
}
