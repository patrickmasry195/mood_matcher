import 'package:flutter/material.dart';
import '../../login_view.dart';
import '../custom_button.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: CustomButton(
        text: 'Login',
        onPressed: () => Navigator.pushNamed(context, LoginPage.id),
      ),
    );
  }
}
