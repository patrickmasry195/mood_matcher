import 'package:flutter/material.dart';
import '../../../../userprofile/presentation/views/userprofile_view.dart';

class UserAvatar extends StatelessWidget {
  const UserAvatar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 50),
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, UserProfilePage.id);
        },
        child: ClipOval(
          child: Image.asset(
            "assets/default_avatar.png",
            width: 50,
            height: 50,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
