import 'package:flutter/material.dart';
import 'package:mood_matcher/pages/login_page.dart';
import 'package:mood_matcher/pages/register_page.dart';
import 'package:mood_matcher/widgets/custom_button.dart';

class AuthenticationPage extends StatelessWidget {
  const AuthenticationPage({super.key});

  static String id = "AuthenticationPage";

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/backgrounds/auth_background.png"),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(
              flex: 2,
            ),
            const Center(
              child: Image(
                width: 300,
                height: 300,
                image: AssetImage(
                  'assets/logos/auth_logo.png',
                ),
              ),
            ),
            const Spacer(
              flex: 1,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: CustomButton(
                text: 'Login',
                onPressed: () => Navigator.pushNamed(context, LoginPage.id),
              ),
            ),
            const Spacer(
              flex: 1,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: CustomButton(
                text: 'Register',
                onPressed: () => Navigator.pushNamed(context, RegisterPage.id),
              ),
            ),
            const Spacer(
              flex: 4,
            ),
          ],
        ),
      ],
    );
  }
}
