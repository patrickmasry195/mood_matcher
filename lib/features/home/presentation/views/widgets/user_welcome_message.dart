import 'package:animated_emoji/emoji.dart';
import 'package:animated_emoji/emojis.g.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mood_matcher/core/utils/constants.dart';

class UserWelcomeMessage extends StatelessWidget {
  const UserWelcomeMessage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(25, 45, 0, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Welcome",
            style: GoogleFonts.lexend(
              fontSize: 30,
              color: kMainColor,
            ),
          ),
          Row(
            children: [
              Text(
                "Username",
                style: GoogleFonts.lexend(
                  fontSize: 30,
                  color: kMainColor,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              const AnimatedEmoji(
                AnimatedEmojis.wave,
                size: 40,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
