import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mood_matcher/features/authentication/presentation/view_models/auth_cubit/auth_state.dart';
import 'package:mood_matcher/features/authentication/presentation/view_models/form_cubit/auth_form_state.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthSupaCubit extends Cubit<AuthSupaState> {
  final SupabaseClient supabase;

  AuthSupaCubit(this.supabase) : super(AuthSupaState());

  Future<void> signUpWithEmail(AuthFormState formState) async {
    emit(AuthSupaState(isLoading: true));
    try {
      final response = await supabase.auth.signUp(
        email: formState.email,
        password: formState.password,
      );

      if (response.user != null) {
        emit(AuthSupaState(isSuccess: true));
      } else {
        emit(AuthSupaState(errorMessage: 'Signup failed. Please try again.'));
      }
    } on AuthException catch (e) {
      emit(AuthSupaState(errorMessage: e.message));
    } catch (_) {
      emit(AuthSupaState(errorMessage: 'An unexpected error occurred.'));
    }
  }
}
