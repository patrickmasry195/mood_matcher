import 'package:flutter/material.dart';
import 'package:mood_matcher/features/authentication/presentation/views/register_view.dart';
import 'package:mood_matcher/features/authentication/presentation/views/widgets/sign_up_suggestion.dart';
import 'package:mood_matcher/features/authentication/presentation/views/widgets/custom_button.dart';
import 'package:mood_matcher/features/authentication/presentation/views/widgets/custom_text_form_field.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a password';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      // Add your login logic here
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          CustomTextFormField(
            keyboardType: TextInputType.emailAddress,
            obscureText: false,
            hintText: 'Email',
            preIcon: const Icon(Icons.email),
            controller: _emailController,
            validator: _validateEmail,
            onSaved: (value) {
              // Save email value if needed
            },
          ),
          const SizedBox(height: 20),
          CustomTextFormField(
            keyboardType: TextInputType.visiblePassword,
            obscureText: true,
            hintText: 'Password',
            preIcon: const Icon(Icons.password),
            controller: _passwordController,
            validator: _validatePassword,
            onSaved: (value) {
              // Save password value if needed
            },
          ),
          const SizedBox(height: 20),
          SignUpSuggestion(
            onTap: () => Navigator.pushNamed(context, RegisterPage.id),
          ),
          const SizedBox(height: 100),
          CustomButton(
            onPressed: _submitForm,
            child: const Text('Login'),
          ),
        ],
      ),
    );
  }
}