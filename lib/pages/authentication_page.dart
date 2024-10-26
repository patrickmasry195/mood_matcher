import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mood_matcher/widgets/custom_button.dart';

class AuthenticationPage extends StatelessWidget {
  const AuthenticationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
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
                'assets/auth_logo.png',
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
              onPressed: () => context.go('/login_page'),
            ),
          ),
          const Spacer(
            flex: 1,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: CustomButton(
              text: 'Register',
              onPressed: () => context.go('/register_page'),
            ),
          ),
          const Spacer(
            flex: 4,
          ),
        ],
      ),
    );
  }
}
