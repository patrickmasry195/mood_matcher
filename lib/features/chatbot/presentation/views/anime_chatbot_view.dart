import 'package:chat_bubbles/message_bars/message_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mood_matcher/core/utils/constants.dart';
import 'package:mood_matcher/core/utils/app_backgrounds.dart';
import 'package:mood_matcher/features/chatbot/presentation/view_models/anime_chatbot_cubit/anime_chatbot_cubit.dart';
import 'package:mood_matcher/features/chatbot/presentation/view_models/anime_chatbot_cubit/anime_chatbot_state.dart';
import 'package:mood_matcher/features/chatbot/presentation/views/widgets/chat_bubbles.dart';
import 'package:mood_matcher/features/home/presentation/views/home_view.dart';

class AnimeChatBotPage extends StatefulWidget {
  const AnimeChatBotPage({super.key});

  static String id = "AnimeChatBotPage";

  @override
  State<AnimeChatBotPage> createState() => _AnimeChatBotPageState();
}

class _AnimeChatBotPageState extends State<AnimeChatBotPage> {
  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AnimeChatbotCubit>();

    return Stack(
      children: [
        AppBackgrounds.chatBotBackground,
        Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: Text(
              'Hanafy The Bot',
              style: GoogleFonts.lexend(
                color: kMainColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            leading: IconButton(
              onPressed: () {
                cubit.clearMessages();
                Navigator.pushNamed(context, HomePage.id);
              },
              icon: const Icon(
                Icons.arrow_back,
                size: 40,
                color: kMainColor,
              ),
            ),
            backgroundColor: Colors.transparent,
          ),
          body: Column(
            children: [
              Expanded(
                child: BlocBuilder<AnimeChatbotCubit, AnimeChatbotState>(
                  builder: (context, state) {
                    List<Map<String, String>> currentMessages = [];

                    if (state is AnimeChatbotUpdated) {
                      currentMessages = state.messages;
                    } else if (state is AnimeChatbotLoading) {
                      currentMessages = state.messages;
                    }

                    if (currentMessages.isEmpty) {
                      return Center(
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Text(
                            "Send a message to get Anime recommendations.",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.lexend(
                              color: Colors.white70,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      );
                    }

                    return Stack(
                      children: [
                        ChatBubbles(messages: currentMessages),
                        if (state is AnimeChatbotLoading)
                          const Center(
                            child: CircularProgressIndicator(color: kMainColor),
                          ),
                      ],
                    );
                  },
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * .02),
              MessageBar(
                messageBarColor: kMainColor,
                sendButtonColor: Colors.white,
                messageBarHintStyle: GoogleFonts.lexend(color: Colors.black),
                onSend: (message) {
                  if (message.trim().isNotEmpty) {
                    cubit.sendMessage(message);
                  }
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
