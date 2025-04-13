import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseAuthService {
  final _supabase = Supabase.instance.client;

  Future<void> registerUser({
    required String email,
    required String password,
    required String name,
    required String phone,
    XFile? avatar,
  }) async {
    final response =
    await _supabase.auth.signUp(email: email, password: password);
    final registeredUserId = response.user?.id;

    if (registeredUserId == null) {
      throw Exception('Registration failed. No user ID returned.');
    }

    // Insert additional info into profiles table
    await _supabase.from('profiles').insert({
      'id': registeredUserId,
      'name': name,
      'phone': phone,
    });

    // Upload avatar if exists
    if (avatar != null) {
      final avatarPath = '$registeredUserId/avatar.png';
      final file = File(avatar.path);
      await _supabase.storage.from('avatars').upload(avatarPath, file);
    }
  }

  Future<void> loginUser({
    required String email,
    required String password,
  }) async {
    await _supabase.auth.signInWithPassword(email: email, password: password);
  }

  Future<void> updateAvatar({
    required XFile avatar,
  }) async {
    final userId = _supabase.auth.currentUser?.id;
    if (userId != null) {
      final avatarPath = '$userId/avatar.png';
      final file = File(avatar.path);
      await _supabase.storage.from('avatars').update(avatarPath, file);
    }
  }

  Future<void> deleteAccount() async {
    final userId = _supabase.auth.currentUser?.id;
    if (userId != null) {
      await _supabase.storage.from('avatars').remove(['$userId/avatar.png']);
      await _supabase.auth.admin.deleteUser(userId);
    }
  }

  Future<void> signOut() async {
    await _supabase.auth.signOut();
  }

  String getAvatarUrl(String userId) {
    return _supabase.storage.from('avatars').getPublicUrl('$userId/avatar.png');
  }
}
