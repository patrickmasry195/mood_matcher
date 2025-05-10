import 'dart:developer';
import 'package:dio/dio.dart';

class SeriesChatbotService {
  final Dio _dio;

  SeriesChatbotService([Dio? dio])
      : _dio = dio ??
            Dio(
              BaseOptions(
                baseUrl: 'http://10.0.2.2:5000',
                connectTimeout: const Duration(seconds: 15),
                receiveTimeout: const Duration(seconds: 15),
                headers: {'Content-Type': 'application/json'},
              ),
            );

  Future<Map<String, dynamic>> sendMessage(String message) async {
    try {
      log("Sending message: $message");

      final response = await _dio.post(
        '/chat',
        data: {'message': message},
      );

      log("Response received: ${response.data}");

      if (response.statusCode == 200) {
        final data = response.data;

        if (data['response'] is String) {
          return {
            'message': data['response'],
            'recommendations': <String>[],
            'hasSeparateRecommendations': false,
          };
        } else if (data['response'] is Map<String, dynamic>) {
          final resp = data['response'];

          String seriesName =
              resp['series'] ?? resp['seriesName'] ?? 'unknown series';
          if (seriesName == 'unknown series') {
            final match =
                RegExp(r'recommend me a series like (.*)', caseSensitive: false)
                    .firstMatch(message);
            if (match != null) {
              seriesName = match.group(1)?.trim() ?? 'your requested series';
            }
          }

          seriesName = seriesName.replaceAll('"', '').trim();

          final recommendations =
              List<String>.from(resp['recommendations'] ?? []);

          return {
            'message': 'Here are some shows similar to $seriesName:',
            'recommendations': recommendations,
            'hasSeparateRecommendations': true,
            'seriesName': seriesName,
          };
        } else {
          return {
            'message': 'Unexpected response format from server.',
            'recommendations': <String>[],
            'hasSeparateRecommendations': false,
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
      throw Exception('Failed to communicate with series chatbot: $e');
    }
  }
}
