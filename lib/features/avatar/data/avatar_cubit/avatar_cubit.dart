import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'avatar_state.dart';

class AvatarCubit extends Cubit<AvatarState> {
  final SupabaseClient supabase;

  AvatarCubit({required this.supabase}) : super(const AvatarState());

  void updateAvatar(File? image) {
    if (image != null) {
      final sizeInMB = image.lengthSync() / (1024 * 1024);
      if (sizeInMB > 5) {
        emit(state.copyWith(error: 'Image must be less than 5MB'));
        return;
      }
    }
    emit(state.copyWith(avatar: image, isAvatarValid: image != null));
  }

  Future<void> saveAvatar({
    required String userId,
    required String username,
    required String phone,
  }) async {
    emit(state.copyWith(isLoading: true, error: null));
    try {
      String? avatarUrl;
      if (state.avatar != null) {
        final fileName = '$userId-${DateTime.now().millisecondsSinceEpoch}.jpg';
        await supabase.storage
            .from('avatars')
            .upload('public/$fileName', state.avatar!);
        avatarUrl =
            supabase.storage.from('avatars').getPublicUrl('public/$fileName');
      }

      await supabase.from('profiles').upsert({
        'id': userId,
        'username': username,
        'phone': phone,
        if (avatarUrl != null) 'avatar_url': avatarUrl,
      });

      emit(state.copyWith(isLoading: false, isUploaded: true));
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        error: 'Failed to save profile: ${e.toString()}',
      ));
    }
  }

  void clearError() {
    emit(state.copyWith(error: null));
  }
}
