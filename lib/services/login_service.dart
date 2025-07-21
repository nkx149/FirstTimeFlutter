import 'dart:convert';
import "package:bookshelf/models/login_response_dto.dart";

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class LoginService {
  Future<LoginResponseDto?> login({required String username, required String password}) async {
    try {
      final apiResponse = await http.post(
        Uri.parse('http://10.0.2.2:5000/api/auth/login'),
        headers: {'Content-type': 'application/json'},
        body: jsonEncode({
          "username": username,
          "password": password
        })
      );

      // print("Signup response code: ${apiResponse.statusCode}");
      // print("Signup response body: ${apiResponse.body}");

      if (apiResponse.statusCode == 200){
        final data = jsonDecode(apiResponse.body);
        final token = data['token'];
        final loginDto = LoginResponseDto.fromJson(data);


        final storage = const FlutterSecureStorage();

        final existing = await storage.read(key: 'all_jwt_tokens');
        final Map<String, dynamic> tokenMap = existing != null ? jsonDecode(existing): {};

        tokenMap[username] = token;
        await storage.write(key: 'all_jwt_tokens', value: jsonEncode(tokenMap));
        await storage.write(key: 'active_user', value: username);

        return loginDto;
      }else {
        print(apiResponse.body);
        final error = jsonDecode(apiResponse.body);
        final message = error["message"] ?? "Login failed, try again";
        throw LoginFailedExceptions(message);
      }
    }catch(e){
      throw LoginFailedExceptions("An Error has occured: $e");
    }
  }
}

class LoginFailedExceptions implements Exception {
  final String message;
  LoginFailedExceptions(this.message);
}