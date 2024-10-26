import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mood_matcher/constants.dart';
import 'package:mood_matcher/forms/register_form.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 40, 0, 0),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => context.go('/login_page'),
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
    );
  }
}
