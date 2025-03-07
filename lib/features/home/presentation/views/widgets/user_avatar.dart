import 'package:flutter/material.dart';
import '../../../../userprofile/presentation/views/userprofile_view.dart';

class UserAvatar extends StatelessWidget {
  const UserAvatar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        MediaQuery.of(context).size.width / 4.5,
        MediaQuery.of(context).size.width / 8,
        0,
        0,
      ),
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, UserProfilePage.id);
        },
        child: const CircleAvatar(
          backgroundImage: AssetImage("assets/default_avatar2.png"),
          maxRadius: 25,
        ),
      ),
    );
  }
}
