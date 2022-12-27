
import 'package:chat_app/app.dart';
import 'package:chat_app/features/presentation/cubit/login/login_cubit.dart';
import 'package:chat_app/features/presentation/cubit/register/register_cubit.dart';
import 'package:chat_app/features/presentation/provider/obsecure_provider.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
      MultiProvider(
          providers:[
        BlocProvider(create:(context) => LoginCubit()) ,
        BlocProvider(create: (context) => RegisterCubit()) ,
        ChangeNotifierProvider(create: (context) => ObsecureProvider()) ,
      ], child: MyApp())
  );
}


