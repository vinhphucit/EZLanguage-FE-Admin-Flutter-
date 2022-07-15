import 'package:fe_ezlang_admin/core/colors.dart';
import 'package:fe_ezlang_admin/mvvm/view_models/admin/user/user_list_view_model.dart';
import 'package:fe_ezlang_admin/providers/header_view_model.dart';
import 'package:google_fonts/google_fonts.dart';

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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => HeaderVM(),
        ),
        ChangeNotifierProvider(
          create: (context) => UserListVM(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'EzLang Admin',
        theme: ThemeData.dark().copyWith(
          appBarTheme: AppBarTheme(backgroundColor: bgColor, elevation: 0),
          scaffoldBackgroundColor: bgColor,
          primaryColor: greenColor,
          dialogBackgroundColor: secondaryColor,
          buttonColor: greenColor,
          textTheme: GoogleFonts.openSansTextTheme(Theme.of(context).textTheme)
              .apply(bodyColor: Colors.white),
          canvasColor: secondaryColor,
        ),
        home: SplashScreen(),
        routes: {
          SignInScreen.routeName: (context) => SignInScreen(),
          SignUpScreen.routeName: (context) => SignUpScreen(),
          HomeScreen.routeName: (context) => HomeScreen(),
          UserListScreen.routeName: ((context) => UserListScreen()),
          RoleListScreen.routeName: ((context) => RoleListScreen())
        },
      ),
    );
  }
}
