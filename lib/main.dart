import 'package:fe_ezlang_admin/view_models/auth_vm.dart';
import 'package:fe_ezlang_admin/views/auth_screen.dart';
import 'package:fe_ezlang_admin/views/home_screen.dart';
import 'package:fe_ezlang_admin/views/splash_screen.dart';
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
          create: (context) => AuthVM(),
        )
      ],
      child: Consumer<AuthVM>(
        builder: (context, authVM, child) => MaterialApp(
          title: 'EzLang Admin',
          theme: ThemeData(
            // This is the theme of your application.
            //
            // Try running your application with "flutter run". You'll see the
            // application has a blue toolbar. Then, without quitting the app, try
            // changing the primarySwatch below to Colors.green and then invoke
            // "hot reload" (press "r" in the console where you ran "flutter run",
            // or simply save your changes to "hot reload" in a Flutter IDE).
            // Notice that the counter didn't reset back to zero; the application
            // is not restarted.
            primarySwatch: Colors.blue,
          ),
          home: authVM.isAuth
              ? HomeScreen()
              : FutureBuilder(
                  future: authVM.tryAutoLogin(),
                  builder: (ctx, authResultSnapshot) =>
                      authResultSnapshot.connectionState ==
                              ConnectionState.waiting
                          ? SplashScreen()
                          : AuthScreen(),
                ),
          routes: {},
        ),
      ),
    );
  }
}
