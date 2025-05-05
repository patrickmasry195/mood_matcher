import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mood_matcher/features/chatbot/services/movie_chatbot_service.dart';
import 'package:mood_matcher/features/chatbot/presentation/view_models/movie_chatbot_cubit/movie_chatbot_state.dart';

class MovieChatbotCubit extends Cubit<MovieChatbotState> {
  final MovieChatbotService service;
  final List<Map<String, String>> _messages = [];

  List<Map<String, String>> get messages => List.from(_messages);

  MovieChatbotCubit(this.service) : super(MovieChatbotInitial());

  void clearMessages() {
    _messages.clear();
    emit(MovieChatbotInitial());
  }

  void sendMessage(String userMessage) async {
    if (userMessage.trim().isEmpty) return;

    _messages.add({"sender": "user", "message": userMessage});
    emit(MovieChatbotUpdated(List.from(_messages)));

    try {
      emit(MovieChatbotLoading(List.from(_messages)));

      final response = await service.sendMessage(userMessage);

      final botMessage = response["message"] as String?;
      if (botMessage != null && botMessage.isNotEmpty) {
        _messages.add({"sender": "bot", "message": botMessage});
      }

      final recommendations = response["recommendations"] as List<String>?;
      if (recommendations != null && recommendations.isNotEmpty) {
        for (final title in recommendations) {
          _messages.add({"sender": "bot", "message": title});
        }
      } else if (botMessage == null || botMessage.isEmpty) {
        _messages.add({
          "sender": "bot",
          "message":
              "I couldn't find any movie matching your request. Try a different title!"
        });
      }

      emit(MovieChatbotUpdated(List.from(_messages)));
    } catch (e) {
      log("Error in sendMessage: $e");

      String errorMessage =
          "Oops, something went wrong. Please try again later.";

      if (e.toString().contains('Connection refused') ||
          e.toString().contains('not running') ||
          e.toString().contains('unreachable')) {
        errorMessage =
            "Cannot connect to movie service. Please check your connection and try again.";
      } else if (e.toString().contains('timeout')) {
        errorMessage =
            "Request timed out. The server might be busy, please try again.";
      }

      _messages.add({"sender": "bot", "message": errorMessage});
      emit(MovieChatbotUpdated(List.from(_messages)));
    }
  }
}
