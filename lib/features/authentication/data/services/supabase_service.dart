import 'dart:io';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';

class SupabaseService {
  final SupabaseClient _client = Supabase.instance.client;

  Future<AuthResponse> signUp(String email, String password) async {
    return await _client.auth.signUp(email: email, password: password);
  }

  String? get currentUserId => _client.auth.currentUser?.id;

  Future<String> uploadAvatar(File file) async {
    final userId = currentUserId;
    final fileExt = file.path.split('.').last;
    final fileName = '${const Uuid().v4()}.$fileExt';
    final storagePath = 'avatars/$userId/$fileName';

    await _client.storage.from('avatars').upload(storagePath, file);
    return _client.storage.from('avatars').getPublicUrl(storagePath);
  }

  Future<void> saveUserProfile({
    required String id,
    required String name,
    required String phone,
    required String avatarUrl,
  }) async {
    await _client.from('profiles').upsert({
      'id': id,
      'name': name,
      'phone': phone,
      'avatar_url': avatarUrl,
    });
  }
}
