import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mood_matcher/features/chatbot/presentation/view_models/series_chatbot_cubit/series_chatbot_state.dart';
import 'package:mood_matcher/features/chatbot/services/series_chatbot_service.dart';

class TvShowsChatbotCubit extends Cubit<TvShowsChatbotState> {
  final SeriesChatbotService _chatbotService;

  TvShowsChatbotCubit(this._chatbotService) : super(TvShowsChatbotInitial());

  final List<Map<String, String>> _messages = [];
  List<String> _recommendations = [];

  List<Map<String, String>> get messages => _messages;

  List<String> get recommendations => _recommendations;

  Future<void> sendMessage(String message) async {
    if (message.trim().isEmpty) return;

    _addMessage('user', message);
    emit(TvShowsChatbotLoading(messages: _messages));

    try {
      final response = await _chatbotService.sendMessage(message);

      final botMessage =
          response['message'] as String? ?? 'Here are some recommendations:';

      _recommendations =
          (response['recommendations'] as List<dynamic>?)?.cast<String>() ?? [];
      final hasSeparateRecommendations =
          response['hasSeparateRecommendations'] as bool? ?? false;

      _addMessage('bot', botMessage);

      if (hasSeparateRecommendations && _recommendations.isNotEmpty) {
        for (final rec in _recommendations) {
          _addMessage('bot', rec);
        }
      }

      emit(TvShowsChatbotUpdated(
        messages: _messages,
        recommendations: _recommendations,
      ));
    } catch (e) {
      _addMessage('bot', 'Sorry, something went wrong: ${e.toString()}');

      emit(TvShowsChatbotError(
        errorMessage: e.toString(),
        messages: _messages,
      ));

      if (_messages.isNotEmpty) {
        emit(TvShowsChatbotUpdated(
          messages: _messages,
          recommendations: _recommendations,
        ));
      }
    }
  }

  void _addMessage(String sender, String message) {
    _messages.add({
      'sender': sender,
      'message': message,
    });
  }

  void clearMessages() {
    _messages.clear();
    _recommendations.clear();
    emit(TvShowsChatbotInitial());
  }
}
