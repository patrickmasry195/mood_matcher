import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static String id = "HomePage";

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/backgrounds/home_background.png"),
              fit: BoxFit.cover,
            ),
          ),
        ),
        const Scaffold(
          backgroundColor: Colors.transparent,
        ),
      ],
    );
  }
}
