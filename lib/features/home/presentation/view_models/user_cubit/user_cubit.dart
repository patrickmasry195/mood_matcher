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
        email: userData['email'],
      ));
    } catch (e) {
      emit(UserError(message: e.toString()));
    }
  }

  Future<void> deleteAccount() async {
    emit(UserLoading());
    try {
      await _authService.deleteAccount();
      emit(UserDeleted());
    } catch (e) {
      emit(UserError(message: 'Failed to delete account: ${e.toString()}'));
    }
  }

  Future<void> signOut() async {
    emit(UserLoading());
    try {
      await _authService.signOut();
      emit(UserSignedOut());
    } catch (e) {
      emit(UserError(message: 'Failed to sign out: ${e.toString()}'));
    }
  }
}
