import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:wldd/features/developers/presentation/screens/users_list_screen.dart';

import '../features/developers/presentation/screens/developer_details_screen.dart';
import '../features/developers/presentation/screens/web_view_screen.dart';


class AppNavigator {
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

      GoRoute(
        path: '/developerDetails',
        name: 'developerDetails',
        builder: (context, state) {
          final params = state.extra as Map<String, dynamic>;
          return DeveloperDetailsScreen(

            name: params['name'] ?? '',


          );
        },
      ),
      GoRoute(
        path: '/webview',
        name: 'webview',
        builder: (context, state) {
          final url = state.extra as String;
          return WebViewScreen(url: url);
        },
      ),

    ],
  );
}