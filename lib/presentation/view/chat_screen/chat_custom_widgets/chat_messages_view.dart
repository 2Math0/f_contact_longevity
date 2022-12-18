import 'package:flutter/material.dart';

import '../../../resources/colors_manager.dart';
import '../../../resources/text_styles_manager.dart';
import '../../../resources/values_manager.dart';
import 'chat_message.dart';
import 'option_list.dart';

class ChatMessagesView extends StatelessWidget {
  final List messagesJsonBody;
  const ChatMessagesView({Key? key, required this.messagesJsonBody})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
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
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: messagesJsonBody[index].keys.length - 1,
                  itemBuilder: (BuildContext context, int i) =>
                      messageUIBuilder(index, messageNum, optionsNum)),
              const Divider(
                height: AppSize.s20,
                color: AppColors.primaryTransBlue,
                thickness: AppSize.s1,
              )
            ],
          );
        },
      ),
    );
  }

  Widget messageUIBuilder(int index, int messageNum, int optionsNum) {
    if (messagesJsonBody[index].keys.toList().contains("message $messageNum")) {
      var neededMessageChild = messagesJsonBody[index]["message $messageNum"];
      ++messageNum;
      return ChatMessage(
          message: neededMessageChild['message'],
          isSender: neededMessageChild['user'] == 'sender',
          seenTime: neededMessageChild['user'] == 'sender'
              ? neededMessageChild["seen Time"]
              : null);
    }
    if (messagesJsonBody[index]
        .keys
        .toList()
        .contains("option list $optionsNum")) {
      var neededOptionsChild =
          messagesJsonBody[index]["option list $optionsNum"];

      ++optionsNum;
      return ChatOptionList(
          question: neededOptionsChild['question'],
          options: neededOptionsChild['options']);
    }
    return const SizedBox(
      height: AppSize.s1,
    );
  }
}
