import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mood_matcher/features/authentication/presentation/view_models/login_cubit/login_cubit.dart';
import 'package:mood_matcher/features/authentication/presentation/views/register_view.dart';
import 'package:mood_matcher/features/authentication/presentation/views/widgets/sign_up_suggestion.dart';
import 'package:mood_matcher/features/authentication/presentation/views/widgets/custom_button.dart';
import 'package:mood_matcher/features/authentication/presentation/views/widgets/custom_text_form_field.dart';
import 'package:mood_matcher/features/home/presentation/views/home_view.dart';

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

  void _submitForm(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      context.read<LoginCubit>().updateEmail(_emailController.text.trim());
      context
          .read<LoginCubit>()
          .updatePassword(_passwordController.text.trim());
      context.read<LoginCubit>().login();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state.isSuccess) {
          Navigator.pushReplacementNamed(context, HomePage.id);
        } else if (state.errorMessage != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.errorMessage!)),
          );
        }
      },
      builder: (context, state) {
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
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  final emailRegex =
                      RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                  if (!emailRegex.hasMatch(value)) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              CustomTextFormField(
                keyboardType: TextInputType.visiblePassword,
                obscureText: true,
                hintText: 'Password',
                preIcon: const Icon(Icons.password),
                controller: _passwordController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a password';
                  }
                  if (value.length < 8) {
                    return 'Password must be at least 8 characters';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              SignUpSuggestion(
                onTap: () => Navigator.pushNamed(context, RegisterPage.id),
              ),
              const SizedBox(height: 100),
              CustomButton(
                onPressed: state.isLoading ? null : () => _submitForm(context),
                child: state.isLoading
                    ? const CircularProgressIndicator(color: Colors.red)
                    : Text(
                        'Login',
                        style: GoogleFonts.lexend(
                          fontSize: 30,
                          color: Colors.white,
                        ),
                      ),
              ),
            ],
          ),
        );
      },
    );
  }
}
