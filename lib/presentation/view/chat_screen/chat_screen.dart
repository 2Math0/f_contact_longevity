import "package:f_contact_longevity/presentation/resources/colors_manager.dart";
import 'package:f_contact_longevity/presentation/resources/strings_manager.dart';
import "package:f_contact_longevity/presentation/resources/text_styles_manager.dart";
import "package:f_contact_longevity/presentation/resources/values_manager.dart";
import "package:flutter/material.dart";
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import 'chat_custom_widgets/chat_messages_view.dart';
import 'chat_custom_widgets/chat_text_field.dart';
import 'chat_custom_widgets/chat_user.dart';
import 'chat_custom_widgets/show_modal_sheet.dart';

var userData = {
  'email': 'thomas.meshail@gmail.com',
  'phone': '+201206207320',
};

List<Map> messagesJsonBody = [
  {
    "date": "2020/Aug/24",
    "message 1": {
      "message": "say hi",
      "user": "receiver",
    },
    "message 2": {
      "message": "hello",
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
      "message": "Welcome",
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
                      ChatMessagesView(messagesJsonBody: messagesJsonBody)
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
                          onPressed: () {
                            launchUrl(Uri(
                              scheme: 'tel',
                              path: userData['phone'],
                            ));
                          },
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
                          onPressed: () {
                            String? encodeQueryParameters(
                                Map<String, String> params) {
                              return params.entries
                                  .map((MapEntry<String, String> e) =>
                                      '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
                                  .join('&');
                            }

                            final Uri emailLaunchUri = Uri(
                              scheme: 'mailto',
                              path: userData['email'],
                              query: encodeQueryParameters(<String, String>{
                                'subject': 'Saying Hello!',
                              }),
                            );
                            launchUrl(emailLaunchUri);
                          },
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
                              onPressed: () =>
                                  showModalSheet(context, messagesJsonBody),
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
          print(countOccurrencesUsingLoop(
              messagesJsonBody[i].keys.toList(), 'message'));
          print(messagesJsonBody[i]);

          setState(() {
            messagesJsonBody[i][
                'message ${countOccurrencesUsingLoop(messagesJsonBody[i].keys.toList(), 'message') + 1}'] = {
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
}
