import 'package:flutter/material.dart';

import '../../core/app_colors.dart';
import '../../core/app_strings.dart';

ThemeData appTheme () {
  return ThemeData(
    colorScheme: ThemeData().colorScheme.copyWith(primary: Colors.grey[700]),
    appBarTheme: AppBarTheme(
      centerTitle: true ,
      color: AppColors.primary,
      elevation: 0.0 ,
      titleTextStyle: TextStyle(
        fontSize: 20.0 ,
        fontWeight: FontWeight.bold,
        color:AppColors().textColor ,
      )
    ),
    primaryColor:AppColors.primary ,
    hintColor: AppColors.hint ,
    scaffoldBackgroundColor: Colors.white ,
    brightness: Brightness.light ,



  ) ;
}