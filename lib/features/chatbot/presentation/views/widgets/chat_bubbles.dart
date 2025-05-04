import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mood_matcher/core/utils/constants.dart';
import 'package:chat_bubbles/chat_bubbles.dart';

class ChatBubbles extends StatelessWidget {
  final List<Map<String, String>> messages;

  const ChatBubbles({super.key, required this.messages});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      reverse: true,
      itemCount: messages.length,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
      itemBuilder: (context, index) {
        final reversedIndex = messages.length - 1 - index;
        final message = messages[reversedIndex];
        final isUser = message["sender"] == "user";
        final messageText = message["message"] ?? "";

        return isUser
            ? Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: BubbleSpecialThree(
                  text: messageText,
                  isSender: true,
                  color: kMainColor,
                  textStyle: GoogleFonts.lexend(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                  tail: true,
                ),
              )
            : Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: BubbleSpecialThree(
                  text: messageText,
                  isSender: false,
                  color: Colors.white,
                  textStyle: GoogleFonts.lexend(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                  tail: true,
                ),
              );
      },
    );
  }
}
