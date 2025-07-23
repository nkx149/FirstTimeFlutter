import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:bookshelf/models/user_update_dto.dart';

class UpdateProfileService {
  Future<void> UpdateUser({required UserUpdateDto dto}) async {
    final token = await getActiveToken();
    if (token == null) throw ApiException('No token found. Login again.');

    try {
      final response = await http.put(
        Uri.parse('http://10.0.2.2:5000/api/auth/update/${dto.id}'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(dto.toJson()), // Null fields are omitted
      );

      if (response.statusCode < 200 || response.statusCode >= 300) {
        throw ApiException(
          'Update failed',
          statusCode: response.statusCode,
        );
      }
    } catch (e) {
      if (e is ApiException) rethrow;
      throw ApiException('Unexpected error: $e');
    }
  }
}




final storage = FlutterSecureStorage();

Future<String?> getActiveToken() async {
  final username = await storage.read(key: 'active_user');
  if (username == null) return null;

  final existing = await storage.read(key: 'all_jwt_tokens');
  if (existing == null) return null;

  final Map<String, dynamic> tokenMap = jsonDecode(existing);
  return tokenMap[username];
}

class ApiException implements Exception {
  final String message;
  final int? statusCode;

  ApiException(this.message, {this.statusCode});

  @override
  String toString() => 'ApiException: $message (Status code: $statusCode)';
}

