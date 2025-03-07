import 'package:flutter/material.dart';
import 'user_avatar.dart';
import 'user_welcome_message.dart';

class CustomAppbar extends StatelessWidget {
  const CustomAppbar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        UserWelcomeMessage(),
        UserAvatar(),
      ],
    );
  }
}
