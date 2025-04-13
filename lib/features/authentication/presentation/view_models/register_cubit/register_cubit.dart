import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mood_matcher/features/authentication/services/supabase_auth_service.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final SupabaseAuthService _authService;

  RegisterCubit(this._authService) : super(RegisterState());

  void updateUserInfo({
    required String name,
    required String email,
    required String phone,
    required String password,
  }) {
    emit(state.copyWith(
      name: name,
      email: email,
      phone: phone,
      password: password,
    ));
  }

  void setAvatar(XFile avatar) {
    emit(state.copyWith(avatar: avatar));
  }

  Future<void> register() async {
    try {
      emit(state.copyWith(isLoading: true));
      await _authService.registerUser(
        email: state.email!,
        password: state.password!,
        avatar: state.avatar,
      );
      emit(state.copyWith(isSuccess: true, isLoading: false));
    } catch (e) {
      emit(state.copyWith(errorMessage: e.toString(), isLoading: false));
    }
  }
}
