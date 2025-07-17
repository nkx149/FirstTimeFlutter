import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';  

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>{

  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  var _passwordVisible;

  @override
  void initState(){
    super.initState();
    _passwordVisible = false;
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
            GoRouter.of(context).pushReplacement('/');
          },
          style: ElevatedButton.styleFrom(
            shape: const StadiumBorder(),
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            backgroundColor: Colors.green,
            foregroundColor: Colors.white,
          ),
          child: const Text("Login", style: TextStyle(fontSize: 20),),
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