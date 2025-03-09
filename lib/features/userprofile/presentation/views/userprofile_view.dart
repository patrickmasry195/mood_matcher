import 'package:animated_emoji/animated_emoji.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mood_matcher/core/utils/app_backgrounds.dart';
import 'package:mood_matcher/core/utils/constants.dart';
import 'package:mood_matcher/features/authentication/presentation/views/widgets/custom_button_with_emoji.dart';
import 'package:mood_matcher/features/home/presentation/views/home_view.dart';

class UserProfilePage extends StatelessWidget {
  const UserProfilePage({super.key});

  static String id = "UserProfilePage";

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AppBackgrounds.userProfileBackground,
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            leading: IconButton(
              onPressed: () => Navigator.pushNamed(context, HomePage.id),
              icon: const Icon(
                Icons.arrow_back,
                size: 40,
                color: kMainColor,
              ),
            ),
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 25,
              children: [
                Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(140),
                      ),
                      child: const CircleAvatar(
                        radius: 40,
                        backgroundImage:
                            AssetImage("assets/default_avatar.png"),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Daryl Dixon",
                      style: GoogleFonts.lexend(
                        fontSize: 30,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "daryl@gmail.com",
                      style: GoogleFonts.lexend(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
                const CustomButtonWithEmoji(
                  text: "Edit Account",
                  emoji: AnimatedEmojis.pencil,
                  buttonWidth: 326,
                ),
                const CustomButtonWithEmoji(
                  text: "Delete Account",
                  emoji: AnimatedEmojis.loudlyCrying,
                  buttonWidth: 326,
                ),
                const CustomButtonWithEmoji(
                  text: "Contact us",
                  emoji: AnimatedEmojis.loveLetter,
                  buttonWidth: 326,
                ),
                const SizedBox(
                  height: 40,
                ),
                const CustomButtonWithEmoji(
                  text: "Log out",
                  emoji: AnimatedEmojis.cry,
                  buttonWidth: 326,
                ),
                const Spacer(
                  flex: 10,
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
