import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mood_matcher/features/authentication/services/supabase_auth_service.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  final SupabaseAuthService _authService;

  UserCubit(this._authService) : super(UserInitial());

  Future<void> loadUserProfile() async {
    emit(UserLoading());
    try {
      final userData = await _authService.getUserProfile();
      emit(UserLoaded(
        name: userData['name'],
        avatarUrl: userData['avatarUrl'],
      ));
    } catch (e) {
      emit(UserError(message: e.toString()));
    }
  }
}
