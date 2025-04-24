import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mood_matcher/features/authentication/services/supabase_auth_service.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final SupabaseAuthService _authService;

  LoginCubit(this._authService) : super(LoginState());

  void updateEmail(String email) {
    emit(state.copyWith(email: email));
  }

  void updatePassword(String password) {
    emit(state.copyWith(password: password));
  }

  Future<void> login() async {
    try {
      emit(state.copyWith(isLoading: true, errorMessage: null));
      await _authService.loginUser(
        email: state.email!,
        password: state.password!,
      );
      emit(state.copyWith(isSuccess: true, isLoading: false));
    } catch (e) {
      emit(state.copyWith(
        errorMessage: e.toString(),
        isSuccess: false,
        isLoading: false,
      ));
    }
  }
}
