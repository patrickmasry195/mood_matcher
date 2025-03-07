import 'package:flutter/material.dart';
import 'package:mood_matcher/features/authentication/presentation/views/authentication_view.dart';
import 'package:mood_matcher/features/avatar/presentation/views/avatar_view.dart';
import 'package:mood_matcher/features/chatbot/presentation/views/chatbot_view.dart';
import 'package:mood_matcher/features/home/presentation/views/home_view.dart';
import 'package:mood_matcher/features/authentication/presentation/views/login_view.dart';
import 'package:mood_matcher/features/authentication/presentation/views/register_view.dart';
import 'package:mood_matcher/features/userprofile/presentation/views/userprofile_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: AuthenticationPage.id,
      routes: {
        AuthenticationPage.id: (context) => const AuthenticationPage(),
        LoginPage.id: (context) => const LoginPage(),
        RegisterPage.id: (context) => const RegisterPage(),
        AvatarPage.id: (context) => const AvatarPage(),
        HomePage.id: (context) => const HomePage(),
        ChatBotPage.id: (context) => const ChatBotPage(),
        UserProfilePage.id: (context) => const UserProfilePage(),
      },
    );
  }
}
