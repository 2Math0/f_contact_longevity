import "package:f_contact_longevity/presentation/resources/colors_manager.dart";
import 'package:f_contact_longevity/presentation/resources/strings_manager.dart';
import "package:f_contact_longevity/presentation/resources/text_styles_manager.dart";
import "package:f_contact_longevity/presentation/resources/values_manager.dart";
import "package:flutter/material.dart";
import 'package:intl/intl.dart';

import "chat_custom_widgets/chat_message.dart";
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
  final TextEditingController messageController = TextEditingController();

  void _showModalSheet() {
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        builder: (builder) {
          return Container(
            decoration: const BoxDecoration(
                color: AppColors.backgroundWhite,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(AppCircularRadius.cr48),
                    topLeft: Radius.circular(AppCircularRadius.cr48))),
            constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height * 0.4),
            child: const Center(
              child: Text(" Modal BottomSheet",
                  textScaleFactor: 2,
                  style: TextStyle(
                      color: Colors.red, fontWeight: FontWeight.bold)),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.backgroundBluishWhite,
      body: SafeArea(
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
                      itemBuilder: (BuildContext context, int index) => Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            messagesJsonBody[index]["date"],
                            style: const AppTextStyles().dateTextRegular,
                          ),
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: messagesJsonBody[index].keys.length - 1,
                            itemBuilder: (BuildContext context, int i) {
                              var neededChild =
                                  messagesJsonBody[index]["message ${i + 1}"];
                              return ChatMessage(
                                  message: neededChild['message'],
                                  isSender: neededChild['user'] == 'sender',
                                  seenTime: neededChild['user'] == 'sender'
                                      ? neededChild["seen Time"]
                                      : null);
                            },
                          ),
                          const Divider(
                            height: AppSize.s20,
                            color: AppColors.primaryTransBlue,
                            thickness: AppSize.s1,
                          )
                        ],
                      ),
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
                      TextField(
                        decoration: InputDecoration(
                            filled: true,
                            constraints:
                                BoxConstraints(maxWidth: size.width * 0.6),
                            isDense: true,
                            hintText: 'Leave a message',
                            fillColor: AppColors.primaryTransBlue,
                            hintStyle: const AppTextStyles().hintTextRegular,
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: AppPadding.p12,
                                vertical: AppPadding.p4),
                            border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(
                                    AppCircularRadius.cr48))),
                        controller: messageController,
                      ),
                      IconButton(
                          onPressed: () {
                            var now = DateFormat("yyyy, MMM, dd")
                                .format(DateTime.now());
                            if (messageController.text.isNotEmpty) {
                              bool changeHappened = false;
                              for (int i = 0;
                                  i < messagesJsonBody.length;
                                  i++) {
                                if (messagesJsonBody[i]['date'] == now) {
                                  setState(() {
                                    messagesJsonBody[i][
                                        'message ${messagesJsonBody[i].keys.length}'] = {
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
                          },
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
      )),
    );
  }
}
