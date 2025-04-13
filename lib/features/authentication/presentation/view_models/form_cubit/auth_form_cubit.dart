import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mood_matcher/features/authentication/presentation/view_models/form_cubit/auth_form_state.dart';

class AuthFormCubit extends Cubit<AuthFormState> {
  AuthFormCubit() : super(AuthFormState.initial());

  void updateName(String value) {
    emit(state.copyWith(
      name: value,
      isNameValid: value.trim().isNotEmpty,
    ));
  }

  void updateEmail(String value) {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    emit(state.copyWith(
      email: value,
      isEmailValid: emailRegex.hasMatch(value),
    ));
  }

  void updatePhone(String value) {
    emit(state.copyWith(
      phone: value,
      isPhoneValid: value.length >= 11,
    ));
  }

  void updatePassword(String value) {
    emit(state.copyWith(
      password: value,
      isPasswordValid: value.length >= 8,
    ));
  }
}
