import 'package:chat_bubbles/message_bars/message_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mood_matcher/core/utils/constants.dart';
import 'package:mood_matcher/core/utils/app_backgrounds.dart';
import 'package:mood_matcher/features/chatbot/presentation/view_models/music_chatbot_cubit/music_chatbot_cubit.dart';
import 'package:mood_matcher/features/chatbot/presentation/view_models/music_chatbot_cubit/music_chatbot_state.dart';
import 'package:mood_matcher/features/chatbot/presentation/views/widgets/chat_bubbles.dart';
import 'package:mood_matcher/features/home/presentation/views/home_view.dart';

class MusicChatBotPage extends StatefulWidget {
  const MusicChatBotPage({super.key});

  static String id = "MusicChatBotPage";

  @override
  State<MusicChatBotPage> createState() => _MusicChatBotPageState();
}

class _MusicChatBotPageState extends State<MusicChatBotPage> {
  @override
  Widget build(BuildContext context) {
    final cubit = context.read<MusicChatbotCubit>();

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) {
          cubit.clearMessages();
          Navigator.pop(context);
        }
      },
      child: Stack(
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
                  child: BlocBuilder<MusicChatbotCubit, MusicChatbotState>(
                    builder: (context, state) {
                      List<Map<String, String>> currentMessages = [];

                      if (state is MusicChatbotUpdated) {
                        currentMessages = state.messages;
                      } else if (state is MusicChatbotLoading) {
                        currentMessages = state.messages;
                      }

                      if (currentMessages.isEmpty) {
                        return Center(
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Text(
                              "Send a message to get Music recommendations.",
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
                          if (state is MusicChatbotLoading)
                            const Center(
                              child:
                                  CircularProgressIndicator(color: kMainColor),
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
      ),
    );
  }
}
