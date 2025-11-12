import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:wldd/features/developers/presentation/screens/home_screen.dart';


class AppNavigator {
  // Private constructor to prevent instantiation
  AppNavigator._();

  // NavigatorKeys
  static final rootNavigatorKey = GlobalKey<NavigatorState>();

  // Path Names
  static const String homeScreen = "homeScreen";


  static final GoRouter router = GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: '/$homeScreen',
    debugLogDiagnostics: true, // Helpful for debugging
    routes: [
      GoRoute(
        path: '/$homeScreen',
        name: homeScreen,
        builder: (context, state) => const HomeScreen(),
      ),

    ],
  );
}