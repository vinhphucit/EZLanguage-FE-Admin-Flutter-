import 'package:fe_ezlang_admin/features/auth/signin/signin_screen.dart';
import 'package:fe_ezlang_admin/features/auth/signin/signin_vm.dart';

import 'package:fe_ezlang_admin/features/home/home_screen.dart';
import 'package:fe_ezlang_admin/features/auth/signup/signup_screen.dart';
import 'package:fe_ezlang_admin/features/splash/splash_screen.dart';
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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => SignInVM(),
        )
      ],
      child: Consumer<SignInVM>(
        builder: (context, authVM, child) => MaterialApp(
          title: 'EzLang Admin',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: authVM.isAuth
              ? HomeScreen()
              : FutureBuilder(
                  future: authVM.tryAutoLogin(),
                  builder: (ctx, authResultSnapshot) =>
                      // authResultSnapshot.connectionState ==
                      //         ConnectionState.waiting
                      //     ? SplashScreen()
                      //     :
                      SignInScreen(),
                ),
          routes: {SignUpScreen.routeName: (context) => SignUpScreen()},
        ),
      ),
    );
  }
}
