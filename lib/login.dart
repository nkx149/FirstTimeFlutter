import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'services/login_service.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import "models/login_response_dto.dart";

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>{

  final _usernameController = TextEditingController(text: 'test3');
  final _passwordController = TextEditingController(text: '12345');
  var _passwordVisible;

  var errorMessage;

  @override
  void initState(){
    super.initState();
    _passwordVisible = false;
  }
  final storage = FlutterSecureStorage();

  Future<void> debugPrintStoredTokens() async {
    Map<String, String> allTokens = await storage.readAll();
    allTokens.forEach((key, value) {
      print("Stored key: $key, Token: $value");
    });
  }


  void Login() async{
    final loginService = LoginService();

    try{
      final result = await loginService.login(
        username: _usernameController.text.trim(),
        password: _passwordController.text
      );

      GoRouter.of(context).pushReplacement('/', extra: result);
    }on LoginFailedExceptions catch (e) {
      setState(() {
        errorMessage = e.message;
      });
    } catch (e) {

      setState(() {
        errorMessage = 'An unexpected error occurred.';
      });
    }
  }
  
  @override
  Widget build(BuildContext context){
    return Scaffold(
        body: Container(
          margin: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _header(context),
              _inputFields(context),
              _signUp(context),
            ],
          ),
        ),
      );
  }

  _header(context){
    return const Column(
      children: [
        Text("Welcome!",
        style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold)),
        Text("Enter your credentials to log in.")
      ],
    );
  }

  _inputFields(context){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextField(
          decoration: InputDecoration(
            hintText: "Username",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
              borderSide: BorderSide.none,
            ),
            fillColor: Colors.green.withValues(alpha: 0.1),
            filled: true,
            prefixIcon: const Icon(Icons.person),
          ),
          controller: _usernameController,
        ),
        const SizedBox(height: 10),
        TextField(
          decoration: InputDecoration(
            hintText: "Password",
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18),
                borderSide: BorderSide.none),
            fillColor: Colors.green.withValues(alpha: 0.1),
            filled: true,
            prefixIcon: const Icon(Icons.password),
            suffixIcon: IconButton(
              icon: Icon(
                _passwordVisible ? Icons.visibility : Icons.visibility_off,
                color: Theme.of(context).primaryColor,
              ),
              onPressed: (){
                setState(() {
                  _passwordVisible = !_passwordVisible;
                });
              },
            )),
          obscureText: !_passwordVisible,
          controller: _passwordController,
        ),

        const SizedBox(height: 10,),
        ElevatedButton(
          onPressed: (){
            Login();
          },
          style: ElevatedButton.styleFrom(
            shape: const StadiumBorder(),
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            backgroundColor: Colors.green,
            foregroundColor: Colors.white,
          ),
          child: const Text("Login", style: TextStyle(fontSize: 20),),
        ),
        if (errorMessage != null)
          Text(
            errorMessage!,
            style: TextStyle(color: Colors.red),
          ),

      ],
    );
  }

  _signUp(context){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Don't have an account?"
        ),
        TextButton(
          onPressed:(){
            GoRouter.of(context).push('/signup');
        },
         child: const Text("Sign Up.", style: TextStyle(color: Colors.green),)
        ),
      ],
    );
  }

}