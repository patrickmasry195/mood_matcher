import 'package:flutter/material.dart';
import 'package:mood_matcher/pages/authentication_page.dart';
import 'package:mood_matcher/pages/avatar_page.dart';
import 'package:mood_matcher/pages/home_page.dart';
import 'package:mood_matcher/pages/login_page.dart';
import 'package:mood_matcher/pages/register_page.dart';

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
      },
    );
  }
}
