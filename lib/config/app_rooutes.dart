import 'package:chat_app/features/presentation/cubit/login/login_cubit.dart';
import 'package:chat_app/features/presentation/screen/chat_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../features/presentation/screen/login.dart';
import '../features/presentation/screen/sign_up.dart';

class Routes {
  static const initialRoute = "/";
  static const signUpScreen = "signUpScreen";
  static const chatPage = "chatPage";
}

// Named routes
final routes = {
  Routes.initialRoute: (context) => LoginScreen(),
  Routes.signUpScreen: (context) => SignUpScreen(),
};
/* then in MaterialApp (routes : routes)
*/

// generated routes
class AppRoutes {
  static Route? onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routes.initialRoute:
        return MaterialPageRoute(
            builder: (context) =>  LoginScreen() ) ;

      case Routes.signUpScreen:
        return MaterialPageRoute(builder: (context) => SignUpScreen());
      case Routes.chatPage:
        return MaterialPageRoute(builder: (context) => ChatPage());
      default:
        return undefinedRoute();
    }
  }

  static Route<dynamic> undefinedRoute() {
    return MaterialPageRoute(
      builder: (context) => const Scaffold(
        body: Center(
          child: Text('Undefined Route'),
        ),
      ),
    );
  }
}
