import 'package:bookshelf/edit_profile.dart';
import 'package:bookshelf/login.dart';
import 'package:bookshelf/models/login_response_dto.dart';
import 'package:bookshelf/profile.dart';
import 'package:go_router/go_router.dart';

import "home.dart";
import "signup.dart";

import 'package:flutter/material.dart';
import 'dart:io';



Future<void> main() async {

  HttpOverrides.global = MyHttpOverrides(); 
  runApp(const MyApp());
}


class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
         (X509Certificate cert, String host, int port) => true;
  }
}

class MyApp extends StatelessWidget {

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Bookshelf',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
        appBarTheme: AppBarTheme(
          backgroundColor: ColorScheme.fromSeed(seedColor: Colors.green).primary,
          foregroundColor: Colors.white,
        ),
      ),
      routerConfig: _router,
    );
  }


}

final GoRouter _router = GoRouter(
  initialLocation: '/login',
  // initialLocation: '/profile',
  routes: [
    GoRoute(
      path: '/login',
      builder: (context, state) => LoginPage(),
    ),
    GoRoute(
      path: '/',
      builder: (context, state) {
        final dto = state.extra as LoginResponseDto;
        return MyHomePage(dto: dto);
      },
    ),
    GoRoute(
      path: '/signup',
      builder: (context, state) => SignupPage(),
    ),
    GoRoute(
      path: '/profile',
      builder: (context, state) {
        final dto = state.extra as LoginResponseDto;
        return ProfilePage(dto: dto);
      },
    ),
    GoRoute(
      path: '/edit-profile',
      builder: (context, state) {
        final dto = state.extra as LoginResponseDto;
        return EditProfilePage(dto: dto);
      }
    ),
  ]
);

