import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mood_matcher/constants.dart';
import 'package:mood_matcher/pages/home_page.dart';
import 'package:mood_matcher/pages/register_page.dart';
import 'package:mood_matcher/widgets/custom_button.dart';

class AvatarPage extends StatelessWidget {
  const AvatarPage({super.key});

  static String id = "AvatarPage";

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/backgrounds/avatar_background.png"),
              fit: BoxFit.cover,
            ),
          ),
        ),
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
              Stack(
                alignment: Alignment.center,
                children: [
                  const CircleAvatar(
                    backgroundImage: AssetImage("assets/default_avatar2.png"),
                    maxRadius: 40,
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.upload,
                      color: kMainColor,
                      size: 40,
                    ),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 380, 16, 0),
                child: CustomButton(
                  text: "Register",
                  onPressed: () => Navigator.pushNamed(context, HomePage.id),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
