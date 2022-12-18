import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../resources/colors_manager.dart';
import '../../../resources/strings_manager.dart';
import '../../../resources/values_manager.dart';
import '../../chat_screen/chat_screen.dart';
import 'chat_text_field.dart';

void showModalSheet(BuildContext context, messagesJsonBody) {
  var now = DateFormat("yyyy/MMM/dd").format(DateTime.now());
  List<TextEditingController> optionsControllers = [
    TextEditingController(),
    TextEditingController()
  ];

  final TextEditingController questionController = TextEditingController();

  showModalBottomSheet(
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) => Container(
            decoration: const BoxDecoration(
                color: AppColors.backgroundWhite,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(AppCircularRadius.cr48),
                    topLeft: Radius.circular(AppCircularRadius.cr48))),
            child: Padding(
              // to move all bottom sheet layout above keyboard
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: AppPadding.p16, vertical: AppPadding.p24),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      ChatTextField(
                        hintText: AppStrings.typeQuestion,
                        textController: questionController,
                        maxWidthRatio: 0.9,
                      ),
                      ListView.builder(
                          shrinkWrap: true,
                          itemCount: optionsControllers.length,
                          itemBuilder: (BuildContext context, int index) =>
                              Padding(
                                padding: const EdgeInsets.all(AppPadding.p12),
                                child: ChatTextField(
                                    textController: optionsControllers[index],
                                    maxWidthRatio: 0.5,
                                    hintText: 'option'),
                              )),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: IconButton(
                            onPressed: () {
                              setState(() {
                                optionsControllers.add(TextEditingController());
                              });
                            },
                            icon: const Icon(
                              Icons.add_circle_outline_outlined,
                              color: AppColors.primaryBlue,
                            )),
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: ElevatedButton(
                            onPressed: () {
                              bool trigger = false;
                              bool allIsFilled = false;
                              for (int i = 0;
                                  i < optionsControllers.length;
                                  i++) {
                                allIsFilled =
                                    optionsControllers[i].text.isNotEmpty;
                                if (allIsFilled == false) {
                                  break;
                                }
                              }
                              var newItem;
                              if (questionController.text.isNotEmpty &&
                                  allIsFilled) {
                                for (int i = 0;
                                    i < messagesJsonBody.length;
                                    i++) {
                                  if (messagesJsonBody[i]['date'] == now) {
                                    newItem = {
                                      'option list ${countOccurrencesUsingLoop(messagesJsonBody[i].keys.toList(), 'option list')}':
                                          {
                                        'question': questionController.text,
                                        'options': [
                                          for (int item = 0;
                                              item < optionsControllers.length;
                                              item++)
                                            optionsControllers[item].text
                                        ],
                                        "user": "sender",
                                      }
                                    };
                                    messagesJsonBody[i].addAll(newItem);
                                    trigger = true;
                                  }
                                }
                                if (trigger == false) {
                                  newItem = {
                                    'date': now,
                                    'option list 0': {
                                      'question': questionController.text,
                                      'options': [
                                        for (int item = 0;
                                            item < optionsControllers.length;
                                            item++)
                                          optionsControllers[item].text
                                      ],
                                      "user": "sender",
                                    }
                                  };
                                  messagesJsonBody.add(newItem);
                                }
                                print(messagesJsonBody);
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const ChatScreen()));
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primaryBlue,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    AppCircularRadius.cr48),
                              ),
                            ),
                            child: const Text('Send')),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      });
}

int countOccurrencesUsingLoop(List list, String element) {
  if (list.isEmpty) {
    return 0;
  }

  int count = 0;
  for (int i = 0; i < list.length; i++) {
    if (list[i].contains(element)) {
      count++;
    }
  }

  return count;
}
