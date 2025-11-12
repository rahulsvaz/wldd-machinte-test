import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wldd/core/app_navigator.dart';
import 'package:wldd/core/hive_support.dart';
import 'package:wldd/features/developers/presentation/bloc/user_details_bloc/user_details_bloc.dart';
import 'package:wldd/features/developers/repository/user_details_repo_impl.dart';
import 'package:wldd/features/developers/repository/user_repository_implements.dart';

import 'features/developers/presentation/bloc/user_bloc/users_bloc.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await HiveSupport.initHive();
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => UsersBloc(UserRepositoryImplements()),
        ),
        BlocProvider(
          create: (context) => UserDetailsBloc(UserDetailsRepoImpl()),
        ),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: AppNavigator.router,


      ),
    );
  }
}
