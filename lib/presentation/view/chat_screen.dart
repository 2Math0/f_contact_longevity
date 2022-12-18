import "package:f_contact_longevity/presentation/resources/colors_manager.dart";
import 'package:f_contact_longevity/presentation/resources/strings_manager.dart';
import "package:f_contact_longevity/presentation/resources/text_styles_manager.dart";
import "package:f_contact_longevity/presentation/resources/values_manager.dart";
import 'package:f_contact_longevity/presentation/view/chat_custom_widgets/option_list.dart';
import "package:flutter/material.dart";
import 'package:intl/intl.dart';

import "chat_custom_widgets/chat_message.dart";
import 'chat_custom_widgets/chat_text_field.dart';
import "chat_custom_widgets/chat_user.dart";

List<Map> messagesJsonBody = [
  {
    "date": "2020/Aug/24",
    "message 1": {
      "message": "Hi",
      "user": "receiver",
    },
    "message 2": {
      "message": "Hi",
      "user": "sender",
      "seen Time": "18:00",
    },
  },
  {
    "date": "2020/Aug/25",
    "message 1": {
      "message": "Hi",
      "user": "sender",
      "seen Time": "14:00",
    },
    "message 2": {
      "message": "Hi",
      "user": "receiver",
    },
  },
];

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  var now = DateFormat("yyyy/MMM/dd").format(DateTime.now());
  final TextEditingController messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: AppColors.backgroundBluishWhite,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: AppPadding.p16, vertical: AppPadding.p12),
                  child: UserChat(
                    image: "assets/images/esther.png",
                    name: "Esther Howard",
                    isOnline: true,
                  )),
              const SizedBox(height: AppMargin.m16),
              SizedBox(
                height: size.height - 208 - 100,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: AppPadding.p16, vertical: AppPadding.p12),
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          itemCount: messagesJsonBody.length,
                          itemBuilder: (BuildContext context, int index) {
                            int messageNum = 1;
                            int optionsNum = 0;
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  messagesJsonBody[index]["date"],
                                  style: const AppTextStyles().dateTextRegular,
                                ),
                                ListView.builder(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount:
                                        messagesJsonBody[index].keys.length - 1,
                                    itemBuilder: (BuildContext context, int i) {
                                      if (messagesJsonBody[index]
                                          .keys
                                          .toList()
                                          .contains("message $messageNum")) {
                                        var neededMessageChild =
                                            messagesJsonBody[index]
                                                ["message $messageNum"];
                                        ++messageNum;
                                        return ChatMessage(
                                            message:
                                                neededMessageChild['message'],
                                            isSender:
                                                neededMessageChild['user'] ==
                                                    'sender',
                                            seenTime:
                                                neededMessageChild['user'] ==
                                                        'sender'
                                                    ? neededMessageChild[
                                                        "seen Time"]
                                                    : null);
                                      }
                                      if (messagesJsonBody[index]
                                          .keys
                                          .toList()
                                          .contains(
                                              "option list $optionsNum")) {
                                        var neededOptionsChild =
                                            messagesJsonBody[index]
                                                ["option list $optionsNum"];

                                        ++optionsNum;
                                        return ChatOptionList(
                                            question:
                                                neededOptionsChild['question'],
                                            options:
                                                neededOptionsChild['options']);
                                      }
                                      return const SizedBox(
                                        height: AppSize.s1,
                                      );
                                    }),
                                const Divider(
                                  height: AppSize.s20,
                                  color: AppColors.primaryTransBlue,
                                  thickness: AppSize.s1,
                                )
                              ],
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                color: AppColors.backgroundBluishWhite,
                child: Column(
                  children: [
                    SizedBox(
                        width: size.width - (AppPadding.p16 * 2),
                        child: Text(
                          'Esther is not available to chat now, meanwhile you can leave a message or try other contacts:',
                          style: const AppTextStyles().bodyTextNormalRegular,
                        )),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        TextButton.icon(
                          onPressed: () {},
                          icon: Image.asset(
                            'assets/icons/call.png',
                            scale: AppSize.s24,
                            color: AppColors.primaryBlue,
                          ),
                          label: const Text(AppStrings.call),
                        ),
                        TextButton.icon(
                          onPressed: () {},
                          icon: Image.asset(
                            'assets/icons/top_right_arrow.png',
                            scale: AppSize.s32,
                            color: AppColors.primaryBlue,
                          ),
                          label: const Text(AppStrings.whatsApp),
                        ),
                        TextButton.icon(
                          onPressed: () {},
                          icon: Image.asset(
                            'assets/icons/top_right_arrow.png',
                            scale: AppSize.s32,
                            color: AppColors.primaryBlue,
                          ),
                          label: const Text(AppStrings.email),
                        ),
                      ],
                    ),
                    Container(
                      color: AppColors.backgroundWhite,
                      constraints: BoxConstraints(
                          minHeight: AppSize.s100, minWidth: size.width),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.attach_file_outlined,
                                  color: AppColors.darkGrey)),
                          IconButton(
                              onPressed: () => _showModalSheet(),
                              icon: const Icon(Icons.list_alt_rounded,
                                  color: AppColors.darkGrey)),
                          ChatTextField(
                            textController: messageController,
                            maxWidthRatio: 0.6,
                            hintText: AppStrings.leaveMessage,
                          ),
                          IconButton(
                              onPressed: () => _sendMessage(),
                              icon: Image.asset(
                                'assets/icons/send.png',
                                scale: AppSize.s24,
                                color: AppColors.primaryBlue,
                              ))
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _sendMessage() {
    if (messageController.text.isNotEmpty) {
      bool changeHappened = false;
      for (int i = 0; i < messagesJsonBody.length; i++) {
        if (messagesJsonBody[i]['date'] == now) {
          setState(() {
            messagesJsonBody[i]
                ['message ${messagesJsonBody[i].keys.length}'] = {
              "message": messageController.text,
              "user": "sender",
            };
          });
          changeHappened = true;
        }
      }
      if (changeHappened == false) {
        setState(() {
          messagesJsonBody.add({
            'date': now.toString(),
            'message 1': {
              "message": messageController.text,
              "user": "sender",
            }
          });
        });
      }
    }
    messageController.clear();
  }

  void _showModalSheet() {
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
                                  optionsControllers
                                      .add(TextEditingController());
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
                                                item <
                                                    optionsControllers.length;
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
