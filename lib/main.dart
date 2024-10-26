import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mood_matcher/pages/authentication_page.dart';
import 'package:mood_matcher/pages/login_page.dart';
import 'package:mood_matcher/pages/register_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: router,
    );
  }

  final router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const AuthenticationPage(),
        name: 'AuthenticationPage',
      ),
      GoRoute(
        path: '/login_page',
        builder: (context, state) => const LoginPage(),
        name: 'LoginPage',
      ),
      GoRoute(
        path: '/register_page',
        builder: (context, state) => const RegisterPage(),
        name: 'RegisterPage',
      ),
    ],
  );
}
