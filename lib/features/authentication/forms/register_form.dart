import 'package:animated_emoji/animated_emoji.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mood_matcher/features/authentication/presentation/view_models/form_cubit/auth_form_cubit.dart';
import 'package:mood_matcher/features/authentication/presentation/view_models/form_cubit/auth_form_state.dart';
import 'package:mood_matcher/features/authentication/presentation/views/widgets/custom_button_with_emoji.dart';
import 'package:mood_matcher/features/authentication/presentation/views/widgets/custom_text_form_field.dart';

class RegisterForm extends StatelessWidget {
  const RegisterForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      child: BlocBuilder<AuthFormCubit, AuthFormState>(
        builder: (context, formState) {
          final formCubit = context.read<AuthFormCubit>();
          return Column(
            children: [
              CustomTextFormField(
                onChanged: formCubit.updateName,
                errorText: formState.name.isEmpty || formState.isNameValid
                    ? null
                    : 'Name cannot be empty',
                keyboardType: TextInputType.text,
                obscureText: false,
                hintText: 'Name',
                preIcon: const Icon(Icons.person),
              ),
              const SizedBox(
                height: 20,
              ),
              CustomTextFormField(
                onChanged: formCubit.updateEmail,
                errorText: formState.email.isEmpty || formState.isEmailValid
                    ? null
                    : 'Invalid email address',
                keyboardType: TextInputType.emailAddress,
                obscureText: false,
                hintText: 'Email',
                preIcon: const Icon(Icons.email),
              ),
              const SizedBox(
                height: 20,
              ),
              CustomTextFormField(
                onChanged: formCubit.updatePhone,
                errorText: formState.phone.isEmpty || formState.isPhoneValid
                    ? null
                    : 'Phone number must be at least 11 digits',
                keyboardType: TextInputType.number,
                obscureText: false,
                hintText: 'Phone number',
                preIcon: const Icon(Icons.phone),
              ),
              const SizedBox(
                height: 20,
              ),
              CustomTextFormField(
                onChanged: formCubit.updatePassword,
                errorText:
                    formState.password.isEmpty || formState.isPasswordValid
                        ? null
                        : 'Password must be at least 8 characters',
                keyboardType: TextInputType.visiblePassword,
                obscureText: true,
                hintText: 'Password',
                preIcon: const Icon(Icons.password),
              ),
              const SizedBox(
                height: 40,
              ),
              CustomButtonWithEmoji(
                text: 'Next',
                emoji: AnimatedEmojis.rocket,
                onPressed: () {

                  // Navigator.pushNamed(context, AvatarPage.id)
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
