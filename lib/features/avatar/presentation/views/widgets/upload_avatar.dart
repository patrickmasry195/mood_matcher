import 'package:flutter/material.dart';
import 'package:mood_matcher/core/utils/constants.dart';

class UploadAvatar extends StatelessWidget {
  const UploadAvatar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        const CircleAvatar(
          backgroundImage: AssetImage("assets/default_avatar2.png"),
          maxRadius: 40,
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.upload,
            color: kMainColor,
            size: 40,
          ),
        )
      ],
    );
  }
}
