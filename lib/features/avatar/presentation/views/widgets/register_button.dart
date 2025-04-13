import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mood_matcher/features/authentication/presentation/view_models/register_cubit/register_cubit.dart';
import 'package:mood_matcher/features/authentication/presentation/views/widgets/custom_button.dart';
import 'package:mood_matcher/features/home/presentation/views/home_view.dart';

class RegisterButton extends StatelessWidget {
  const RegisterButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterCubit, RegisterState>(
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
        return Padding(
          padding: const EdgeInsets.fromLTRB(16, 380, 16, 0),
          child: CustomButton(
            onPressed: state.isLoading
                ? null
                : () => context.read<RegisterCubit>().register(),
            child: state.isLoading
                ? const CircularProgressIndicator(color: Colors.red,)
                : Text(
                    "Register",
                    style: GoogleFonts.lexend(
                      fontSize: 30,
                      color: Colors.white,
                    ),
                  ),
          ),
        );
      },
    );
  }
}
// ElevatedButton(
// onPressed: state.isLoading
// ? null
//     : () => context.read<RegisterCubit>().register(),
// child: state.isLoading
// ? const CircularProgressIndicator()
//     : const Text("Register"),
// ),
