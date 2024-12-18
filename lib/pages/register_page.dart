import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mood_matcher/constants.dart';
import 'package:mood_matcher/forms/register_form.dart';
import 'package:mood_matcher/pages/authentication_page.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  static String id = "RegisterPage";

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/backgrounds/register_background.png"),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 40, 0, 0),
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () =>
                            Navigator.pushNamed(context, AuthenticationPage.id),
                        icon: const Icon(
                          Icons.arrow_back,
                          size: 70,
                          color: kMainColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
                  child: Row(
                    children: [
                      Text(
                        'Register',
                        style: GoogleFonts.lexend(
                          fontSize: 50,
                          color: kMainColor,
                        ),
                      ),
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.fromLTRB(15, 60, 15, 0),
                  child: RegisterForm(),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
