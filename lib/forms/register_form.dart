import 'package:flutter/material.dart';
import 'package:mood_matcher/widgets/custom_button.dart';
import 'package:mood_matcher/widgets/custom_text_form_field.dart';

class RegisterForm extends StatelessWidget {
  const RegisterForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          const CustomTextFormField(
            keyboardType: TextInputType.text,
            obscureText: false,
            hintText: 'Name',
            preIcon: Icon(Icons.person),
          ),
          const SizedBox(
            height: 20,
          ),
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
            keyboardType: TextInputType.number,
            obscureText: false,
            hintText: 'Phone number',
            preIcon: Icon(Icons.phone),
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
            height: 40,
          ),
          CustomButton(
            text: 'Register',
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
