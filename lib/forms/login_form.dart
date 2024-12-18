import 'package:flutter/material.dart';
import 'package:mood_matcher/pages/register_page.dart';
import 'package:mood_matcher/sign_up_suggestion.dart';
import 'package:mood_matcher/widgets/custom_button.dart';
import 'package:mood_matcher/widgets/custom_text_form_field.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          const CustomTextFormField(
            keyboardType: TextInputType.emailAddress,
            obscureText: false,
            hintText: 'Email',
            preIcon: Icon(Icons.email),
          ),
          const SizedBox(
            height: 20,
          ),
          const CustomTextFormField(
            keyboardType: TextInputType.visiblePassword,
            obscureText: true,
            hintText: 'Password',
            preIcon: Icon(Icons.password),
          ),
          const SizedBox(
            height: 20,
          ),
          SignUpSuggestion(
            onTap: () => Navigator.pushNamed(context, RegisterPage.id),
          ),
          const SizedBox(
            height: 100,
          ),
          CustomButton(
            text: 'Login',
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
