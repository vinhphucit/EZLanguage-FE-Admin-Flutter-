import 'mvvm/view_models/auth/signin_view_model.dart';
import 'mvvm/views/admin/role/role_list_screen.dart';
import 'mvvm/views/admin/user/user_list_screen.dart';
import 'mvvm/views/auth/signin_screen.dart';
import 'mvvm/views/auth/signup_screen.dart';
import 'mvvm/views/home/home_screen.dart';
import 'mvvm/views/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const AdminApp());
}

class AdminApp extends StatelessWidget {
  const AdminApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'EzLang Admin',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashScreen(),
      // authVM.isAuth
      //     ? HomeScreen()
      //     : FutureBuilder(
      //         future: authVM.tryAutoLogin(),
      //         builder: (ctx, authResultSnapshot) =>
      //             // authResultSnapshot.connectionState ==
      //             //         ConnectionState.waiting
      //             //     ? SplashScreen()
      //             //     :
      //             SignInScreen(),
      //       ),
      routes: {
        SignInScreen.routeName: (context) => SignInScreen(),
        SignUpScreen.routeName: (context) => SignUpScreen(),
        HomeScreen.routeName: (context) => HomeScreen(),
        UserListScreen.routeName: ((context) => UserListScreen()),
        RoleListScreen.routeName: ((context) => RoleListScreen())
      },
    );
  }
}
