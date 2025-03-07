import 'package:flutter/material.dart';

import '../../register_view.dart';
import '../custom_button.dart';

class RegisterButton extends StatelessWidget {
  const RegisterButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: CustomButton(
        text: 'Register',
        onPressed: () => Navigator.pushNamed(context, RegisterPage.id),
      ),
    );
  }
}
