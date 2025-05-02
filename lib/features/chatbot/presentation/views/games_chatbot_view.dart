import 'package:chat_bubbles/message_bars/message_bar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mood_matcher/core/utils/constants.dart';
import 'package:mood_matcher/core/utils/app_backgrounds.dart';
import 'package:mood_matcher/features/chatbot/presentation/views/widgets/chat_bubbles.dart';
import 'package:mood_matcher/features/home/presentation/views/home_view.dart';

class GamesChatBotPage extends StatelessWidget {
  const GamesChatBotPage({super.key});

  static String id = "GamesChatBotPage";

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AppBackgrounds.chatBotBackground,
        Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            leading: IconButton(
              onPressed: () => Navigator.pushNamed(context, HomePage.id),
              icon: const Icon(
                Icons.arrow_back,
                size: 40,
                color: kMainColor,
              ),
            ),
            backgroundColor: Colors.transparent,
          ),
          body: Column(
            children: [
               Expanded(
                child: ChatBubbles(messages: [],),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * .02,
              ),
              MessageBar(
                messageBarColor: kMainColor,
                sendButtonColor: Colors.white,
                messageBarHintStyle: GoogleFonts.lexend(
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
