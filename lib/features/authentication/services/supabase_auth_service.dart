import 'dart:developer';
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
    final response = await _supabase.auth.signUp(
      email: email,
      password: password,
    );

    final registeredUser = response.user;
    if (registeredUser == null) {
      throw Exception('Registration failed. No user returned.');
    }

    final userId = registeredUser.id;

    await Future.delayed(const Duration(seconds: 1));

    await _supabase.from('profiles').insert({
      'id': userId,
      'name': name,
      'phone': phone,
    });

    if (avatar != null) {
      final avatarPath = '$userId/avatar.png';
      final file = File(avatar.path);
      await _supabase.storage.from('avatars').upload(avatarPath, file);
    }

    await _supabase.auth.signInWithPassword(
      email: email,
      password: password,
    );
  }

  Future<void> loginUser({
    required String email,
    required String password,
  }) async {
    await _supabase.auth.signInWithPassword(
      email: email,
      password: password,
    );
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
    final user = _supabase.auth.currentUser;
    final userId = user?.id;

    if (userId == null) {
      throw Exception("No user logged in");
    }

    try {
      await _supabase.storage.from('avatars').remove(['$userId/avatar.png']);
    } catch (e) {
      log("Error deleting avatar: $e");
    }

    try {
      await _supabase.from('profiles').delete().eq('id', userId);
    } catch (e) {
      log("Error deleting user profile: $e");
    }

    try {
      await _supabase.auth.admin.deleteUser(userId);
    } catch (e) {
      log("Error deleting user account: $e");
    }

    try {
      await signOut();
    } catch (e) {
      log("Error during sign-out: $e");
    }
  }

  Future<void> signOut() async {
    await _supabase.auth.signOut();
  }

  String getAvatarUrl(String userId) {
    return _supabase.storage.from('avatars').getPublicUrl('$userId/avatar.png');
  }

  Future<Map<String, dynamic>> getUserProfile() async {
    final user = _supabase.auth.currentUser;
    final userId = user?.id;

    if (userId == null) throw Exception("No user logged in");

    final response =
        await _supabase.from('profiles').select().eq('id', userId).single();

    return {
      'id': userId,
      'name': response['name'],
      'avatarUrl': getAvatarUrl(userId),
      'email': user?.email,
    };
  }
}
