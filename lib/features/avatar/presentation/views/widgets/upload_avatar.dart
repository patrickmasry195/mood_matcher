import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mood_matcher/core/utils/constants.dart';
import 'package:mood_matcher/features/authentication/presentation/view_models/register_cubit/register_cubit.dart';

class UploadAvatar extends StatelessWidget {
  const UploadAvatar({super.key});

  Future<void> _pickImage(BuildContext context) async {
    final picker = ImagePicker();
    final image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      context.read<RegisterCubit>().setAvatar(image);
    }
  }

  @override
  Widget build(BuildContext context) {
    final avatar = context.watch<RegisterCubit>().state.avatar;

    return Stack(
      alignment: Alignment.center,
      children: [
        CircleAvatar(
          backgroundImage: avatar != null
              ? FileImage(File(avatar.path))
              : const AssetImage("assets/default_avatar2.png") as ImageProvider,
          maxRadius: 40,
        ),
        if (avatar == null)
          IconButton(
            onPressed: () => _pickImage(context),
            icon: const Icon(Icons.upload, color: kMainColor, size: 40),
          )
      ],
    );
  }
}
