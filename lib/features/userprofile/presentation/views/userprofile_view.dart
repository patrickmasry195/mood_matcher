import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mood_matcher/core/utils/constants.dart';
import 'package:mood_matcher/core/utils/app_backgrounds.dart';

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
