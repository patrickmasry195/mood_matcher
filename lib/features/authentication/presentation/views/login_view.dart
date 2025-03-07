import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mood_matcher/core/utils/constants.dart';
import 'package:mood_matcher/features/authentication/forms/login_form.dart';
import 'package:mood_matcher/features/authentication/presentation/views/authentication_view.dart';
import 'package:mood_matcher/core/utils/app_backgrounds.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  static String id = "LoginPage";

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AppBackgrounds.loginBackground,
        Scaffold(
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
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
                  padding: const EdgeInsets.fromLTRB(15, 60, 0, 0),
                  child: Row(
                    children: [
                      Text(
                        'Login',
                        style: GoogleFonts.lexend(
                          fontSize: 50,
                          color: kMainColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: 15,
                    right: 15,
                    top: 60,
                    bottom: MediaQuery.of(context).viewInsets.bottom,
                  ),
                  child: const LoginForm(),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
