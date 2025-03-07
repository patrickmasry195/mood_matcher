import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mood_matcher/core/utils/constants.dart';
import 'package:mood_matcher/features/avatar/presentation/views/widgets/register_button.dart';
import 'package:mood_matcher/features/authentication/presentation/views/register_view.dart';
import 'package:mood_matcher/core/utils/app_backgrounds.dart';
import 'widgets/upload_avatar.dart';

class AvatarPage extends StatelessWidget {
  const AvatarPage({super.key});

  static String id = "AvatarPage";

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AppBackgrounds.avatarBackground,
        Scaffold(
          backgroundColor: Colors.transparent,
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 40, 0, 0),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () =>
                          Navigator.pushNamed(context, RegisterPage.id),
                      icon: const Icon(
                        Icons.arrow_back,
                        size: 70,
                        color: kMainColor,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                "Upload your avatar",
                style: GoogleFonts.lexend(
                  color: kMainColor,
                  fontSize: 25,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const UploadAvatar(),
              const RegisterButton()
            ],
          ),
        ),
      ],
    );
  }
}
