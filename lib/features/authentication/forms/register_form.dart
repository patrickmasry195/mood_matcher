import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mood_matcher/features/authentication/presentation/views/widgets/custom_button_with_emoji.dart';
import 'package:mood_matcher/features/authentication/presentation/views/widgets/custom_text_form_field.dart';
import 'package:animated_emoji/animated_emoji.dart';
import 'package:mood_matcher/features/avatar/presentation/views/avatar_view.dart';
import '../presentation/view_models/register_cubit/register_cubit.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      context.read<RegisterCubit>().updateUserInfo(
            name: _nameController.text,
            email: _emailController.text,
            phone: _phoneController.text,
            password: _passwordController.text,
          );
      Navigator.pushNamed(context, AvatarPage.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          CustomTextFormField(
            controller: _nameController,
            hintText: 'Name',
            keyboardType: TextInputType.text,
            preIcon: const Icon(Icons.person),
            validator: (value) =>
                value == null || value.length < 2 ? 'Invalid name' : null,
            obscureText: false,
          ),
          const SizedBox(height: 20),
          CustomTextFormField(
            controller: _emailController,
            hintText: 'Email',
            keyboardType: TextInputType.emailAddress,
            preIcon: const Icon(Icons.email),
            validator: (value) {
              if (value == null || value.isEmpty) return 'Email required';
              final regex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
              return !regex.hasMatch(value) ? 'Invalid email' : null;
            },
            obscureText: false,
          ),
          const SizedBox(height: 20),
          CustomTextFormField(
            controller: _phoneController,
            hintText: 'Phone number',
            keyboardType: TextInputType.number,
            preIcon: const Icon(Icons.phone),
            validator: (value) =>
                value == null || value.length < 10 ? 'Invalid number' : null,
            obscureText: false,
          ),
          const SizedBox(height: 20),
          CustomTextFormField(
            controller: _passwordController,
            hintText: 'Password',
            keyboardType: TextInputType.visiblePassword,
            obscureText: true,
            preIcon: const Icon(Icons.lock),
            validator: (value) => value == null || value.length < 8
                ? 'Password must be at least 8 characters'
                : null,
          ),
          const SizedBox(height: 40),
          CustomButtonWithEmoji(
            text: 'Next',
            emoji: AnimatedEmojis.rocket,
            onPressed: _submitForm,
          ),
        ],
      ),
    );
  }
}
