import 'dart:convert';
import 'package:http/http.dart' as http;


class SignupService {
  Future<String?> signup(
    {
      required String username,
      required String email,
      required String password,
      required String passwordConfirm,
    }
  ) async {

    if (password != passwordConfirm) {
      return "Password does not match";
    }

    try {
      final apiResponse = await http.post(
        // Uri.parse('https://flutterapi.local/api/auth/signup'),
        Uri.parse('http://10.0.2.2:5000/api/auth/signup'),
        headers: {'Content-type': 'application/json'},
        body: jsonEncode(
          {
            "username": username,
            "email": email,
            "password": password
          }
        ),
      );

      if (apiResponse.statusCode >= 200 && apiResponse.statusCode < 300) {
        return null;
      }else {
        final error = jsonDecode(apiResponse.body);
        return error["message"] ?? "Signup failed, try again";

      }

    }catch(e){
      return "An error occured: $e";
    }
  }
}