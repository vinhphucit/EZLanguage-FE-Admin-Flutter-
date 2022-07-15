import '../../../providers/splash_view_model.dart';
import '../auth/signin_screen.dart';
import '../home/home_screen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends SplashVM {
  @override
  void initState() {
    super.initState();
    tryAutoLogin().then((value) async {
      await Future.delayed(const Duration(seconds: 2));
      if (value == true) {
        Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
      } else {
        Navigator.of(context).pushReplacementNamed(SignInScreen.routeName);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FittedBox(
            child: Column(children: [
          CircularProgressIndicator(),
          SizedBox(
            height: 10,
          ),
          Text('Loading...')
        ])),
      ),
    );
  }
}
