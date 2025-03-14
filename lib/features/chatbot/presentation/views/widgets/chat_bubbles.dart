import 'package:chat_bubbles/bubbles/bubble_special_three.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mood_matcher/core/utils/constants.dart';
import 'package:mood_matcher/features/chatbot/dummy_data.dart';

class ChatBubbles extends StatelessWidget {
  const ChatBubbles({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: ListView.separated(
        shrinkWrap: true,
        reverse: true,
        itemBuilder: (BuildContext context, int index) {
          DummyData dummyData = DummyData();
          final message = dummyData.chatData[index];
          bool isUser = message["sender"] == "user";
          return Align(
            alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
            child: BubbleSpecialThree(
              isSender: isUser ? true : false,
              color: isUser ? Colors.white : kMainColor,
              text: '${message["message"]}',
              textStyle: GoogleFonts.lexend(
                color: isUser ? Colors.black : Colors.white,
                fontSize: 16,
              ),
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) => SizedBox(
          height: MediaQuery.of(context).size.height * .01,
        ),
        itemCount: DummyData().chatData.length,
      ),
    );
  }
}
