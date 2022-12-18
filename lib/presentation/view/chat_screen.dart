import "package:f_contact_longevity/presentation/resources/colors_manager.dart";
import 'package:f_contact_longevity/presentation/resources/strings_manager.dart';
import "package:f_contact_longevity/presentation/resources/text_styles_manager.dart";
import "package:f_contact_longevity/presentation/resources/values_manager.dart";
import "package:flutter/material.dart";

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

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.backgroundBluishWhite,
      body: SafeArea(
          child: Stack(children: [
        Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: AppPadding.p16, vertical: AppPadding.p12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const UserChat(
                image: "assets/images/esther.png",
                name: "Esther Howard",
                isOnline: true,
              ),
              const SizedBox(height: AppMargin.m16),
              SingleChildScrollView(
                child: Column(
                  children: [
                    ListView.builder(
                      shrinkWrap: true,
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
                  ],
                ),
              ),
            ],
          ),
        ),
        Positioned(
          bottom: 0,
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
                        onPressed: () {},
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
                      onChanged: (value) {
                        // do something
                      },
                    ),
                    IconButton(
                        onPressed: () {},
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
        )
      ])),
    );
  }
}
