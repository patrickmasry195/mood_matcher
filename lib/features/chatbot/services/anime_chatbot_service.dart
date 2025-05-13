import 'dart:developer';
import 'package:dio/dio.dart';

class AnimeChatbotService {
  final Dio _dio;

  AnimeChatbotService({Dio? dio})
      : _dio = dio ??
            Dio(
              BaseOptions(
                baseUrl: 'http://10.0.2.2:5002',
                connectTimeout: const Duration(seconds: 15),
                receiveTimeout: const Duration(seconds: 15),
                headers: {'Content-Type': 'application/json'},
              ),
            );

  Future<Map<String, dynamic>> sendMessage(String message) async {
    try {
      log("Sending message: $message");

      final response = await _dio.post(
        '/animes_chatbot',
        data: {'message': message},
      );

      log("Response received: ${response.data}");

      if (response.statusCode == 200) {
        final data = response.data;

        if (data['response'] is String) {
          return {'message': data['response'], 'recommendations': <String>[]};
        } else if (data['response'] is Map<String, dynamic>) {
          final resp = data['response'];
          return {
            'message': 'Here are some animes similar to "${resp['anime']}":',
            'recommendations': List<String>.from(resp['recommendations'])
          };
        } else {
          return {
            'message': 'Unexpected response format.',
            'recommendations': <String>[]
          };
        }
      } else {
        throw Exception('Server error: ${response.statusCode}');
      }
    } on DioException catch (e) {
      log("Dio error: ${e.message}");
      log("Response data: ${e.response?.data}");
      log("Status code: ${e.response?.statusCode}");

      String errorMessage;
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        errorMessage =
            'Connection timeout. Server might be down or unreachable.';
      } else if (e.message?.contains('Connection refused') == true) {
        errorMessage =
            'Server is not running or not accessible. Please check the server address.';
      } else {
        errorMessage = 'Network error: ${e.message}';
      }

      throw Exception(errorMessage);
    } catch (e) {
      log("Unexpected error: $e");
      throw Exception('Failed to communicate with anime chatbot: $e');
    }
  }
}
