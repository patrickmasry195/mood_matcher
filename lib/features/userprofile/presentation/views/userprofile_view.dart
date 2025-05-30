import 'package:animated_emoji/animated_emoji.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:mood_matcher/core/utils/app_backgrounds.dart';
import 'package:mood_matcher/core/utils/constants.dart';
import 'package:mood_matcher/features/authentication/presentation/views/authentication_view.dart';
import 'package:mood_matcher/features/authentication/presentation/views/widgets/custom_button_with_emoji.dart';
import 'package:mood_matcher/features/home/presentation/view_models/user_cubit/user_cubit.dart';
import 'package:mood_matcher/features/home/presentation/views/home_view.dart';
import 'package:mood_matcher/features/userprofile/presentation/views/widgets/update_name.dart';

class UserProfilePage extends StatelessWidget {
  const UserProfilePage({super.key});

  static String id = "UserProfilePage";

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AppBackgrounds.userProfileBackground,
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            leading: IconButton(
              onPressed: () => Navigator.pushNamed(context, HomePage.id),
              icon: const Icon(
                Icons.arrow_back,
                size: 40,
                color: kMainColor,
              ),
            ),
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 20),
                  BlocConsumer<UserCubit, UserState>(
                    listener: (context, state) {
                      if (state is UserError) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(state.message)),
                        );
                      }

                      if (state is UserDeleted || state is UserSignedOut) {
                        Navigator.pushNamedAndRemoveUntil(
                            context, AuthenticationPage.id, (_) => false);
                      }
                    },
                    builder: (context, state) {
                      if (state is UserLoading) {
                        return const CircularProgressIndicator(
                          color: kMainColor,
                        );
                      } else if (state is UserLoaded) {
                        return Column(
                          children: [
                            GestureDetector(
                              onTap: () async {
                                final picker = ImagePicker();
                                final pickedFile = await picker.pickImage(
                                    source: ImageSource.gallery);
                                if (pickedFile != null && context.mounted) {
                                  context
                                      .read<UserCubit>()
                                      .updateUserAvatar(pickedFile);
                                }
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(140),
                                ),
                                child: ClipOval(
                                  child: Image.network(
                                    state.avatarUrl,
                                    width: 80,
                                    height: 80,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      return Image.asset(
                                        'assets/default_avatar.png',
                                        width: 80,
                                        height: 80,
                                        fit: BoxFit.cover,
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            GestureDetector(
                              onTap: () {
                                final controller = TextEditingController();
                                bool isLoading = false;

                                showDialog(
                                  context: context,
                                  builder: (context) => StatefulBuilder(
                                    builder: (BuildContext context, setState) {
                                      return UpdateName(
                                        controller: controller,
                                        onUpdatePressed: () async {
                                          final name = controller.text.trim();
                                          if (name.isEmpty) return;

                                          setState(() => isLoading = true);
                                          await context
                                              .read<UserCubit>()
                                              .updateUserName(name);
                                          if (context.mounted) {
                                            Navigator.pop(context);
                                          }
                                        },
                                        isLoading: isLoading,
                                      );
                                    },
                                  ),
                                );
                              },
                              child: AutoSizeText(
                                state.name,
                                style: GoogleFonts.lexend(
                                  fontSize: 30,
                                  color: Colors.white,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            const SizedBox(height: 10),
                            AutoSizeText(
                              state.email,
                              style: GoogleFonts.lexend(
                                fontSize: 20,
                                color: Colors.white,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 20),
                          ],
                        );
                      } else if (state is UserError) {
                        return Text(
                          state.message,
                          style: const TextStyle(color: Colors.red),
                        );
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                  const SizedBox(height: 25),
                  CustomButtonWithEmoji(
                    text: "Delete Account",
                    emoji: AnimatedEmojis.loudlyCrying,
                    onPressed: () {
                      context.read<UserCubit>().deleteAccount();
                      context.read<UserCubit>().signOut();
                    },
                  ),
                  const SizedBox(height: 25),
                  CustomButtonWithEmoji(
                    onPressed: () {
                      FocusScope.of(context).unfocus();
                      AwesomeDialog(
                        context: context,
                        dialogType: DialogType.noHeader,
                        customHeader:
                            Lottie.asset('assets/contact_animation.json'),
                        dialogBackgroundColor: kMainColor,
                        title: 'Contact us',
                        titleTextStyle: GoogleFonts.lexend(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                        desc: 'moodmatcher2024@gmail.com',
                        descTextStyle: GoogleFonts.lexend(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ).show();
                    },
                    text: "Contact us",
                    emoji: AnimatedEmojis.loveLetter,
                  ),
                  const SizedBox(height: 40),
                  CustomButtonWithEmoji(
                    text: "Log out",
                    emoji: AnimatedEmojis.cry,
                    onPressed: () {
                      context.read<UserCubit>().signOut();
                    },
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
