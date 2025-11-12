import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:wldd/core/app_navigator.dart';

import 'features/developers/presentation/screens/home_screen.dart';
import 'features/developers/presentation/screens/profile_screen.dart';
import 'features/developers/presentation/widgets/developer_list_card.dart';

void main() {
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp.router(
      debugShowCheckedModeBanner: false,
       routerConfig: AppNavigator.router,






    );
  }
}
