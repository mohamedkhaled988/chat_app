import 'package:chat_app/config/app_rooutes.dart';
import 'package:chat_app/features/presentation/screen/login.dart';
import 'package:chat_app/main.dart';
import 'package:flutter/material.dart';

import 'config/theme/app_theme.dart';
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ChatApp',
      theme: appTheme(
      ),
      onGenerateRoute: AppRoutes.onGenerateRoute,
    );
  }
}