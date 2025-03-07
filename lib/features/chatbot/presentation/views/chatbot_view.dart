import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mood_matcher/core/utils/constants.dart';
import 'package:mood_matcher/core/utils/app_backgrounds.dart';

class ChatBotPage extends StatelessWidget {
  const ChatBotPage({super.key});

  static String id = "ChatBotPage";

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AppBackgrounds.chatBotBackground,
        Scaffold(
          backgroundColor: Colors.transparent,
          body: Center(
            child: Text(
              "Under development",
              style: GoogleFonts.lexend(
                fontSize: 40,
                color: kMainColor,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
