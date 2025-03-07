import 'package:flutter/material.dart';
import 'package:mood_matcher/features/authentication/presentation/views/widgets/custom_button.dart';
import 'package:mood_matcher/features/home/presentation/views/home_view.dart';

class RegisterButton extends StatelessWidget {
  const RegisterButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 380, 16, 0),
      child: CustomButton(
        text: "Register",
        onPressed: () => Navigator.pushNamed(context, HomePage.id),
      ),
    );
  }
}
