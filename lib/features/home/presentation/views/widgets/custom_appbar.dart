import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animated_emoji/emoji.dart';
import 'package:animated_emoji/emojis.g.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:mood_matcher/core/utils/constants.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    super.key,
    required this.userName,
    required this.userAvatarUrl,
  });

  final String userName;
  final String userAvatarUrl;

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: screenWidth * 0.05,
        vertical: 16,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Welcome',
                  style: GoogleFonts.lexend(
                    fontSize: screenWidth * 0.07,
                    color: kMainColor,
                  ),
                ),
                Row(
                  children: [
                    Flexible(
                      child: AutoSizeText(
                        userName,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.lexend(
                          fontSize: screenWidth * 0.06,
                          color: kMainColor,
                        ),
                      ),
                    ),
                    const SizedBox(width: 6),
                    AnimatedEmoji(
                      AnimatedEmojis.wave,
                      size: screenWidth * 0.08,
                    ),
                  ],
                ),
              ],
            ),
          ),
          ClipOval(
            child: Image.network(
              userAvatarUrl,
              width: 48,
              height: 48,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => const Icon(Icons.person, size: 48),
            ),
          ),
        ],
      ),
    );
  }
}
