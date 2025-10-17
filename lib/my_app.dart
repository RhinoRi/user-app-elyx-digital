import 'package:elyx_digital_user_app/core/constants/app_strings.dart';
import 'package:elyx_digital_user_app/core/themes/app_theme.dart';
import 'package:elyx_digital_user_app/features/users/bloc/user_bloc.dart';
import 'package:elyx_digital_user_app/features/users/bloc/user_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'features/users/screens/user_home_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appName,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.appMainTheme,
      home: BlocProvider(
        create: (_) => UserBloc()..add(UserFetchDataEvent()),
        child: UserHomeScreen(),
      ),
    );
  }
}
