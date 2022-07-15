import 'package:fe_ezlang_admin/core/components/containers/gradient_container.dart';
import 'package:fe_ezlang_admin/core/components/textfields/textfield_with_title.dart';
import 'package:fe_ezlang_admin/core/resources/dimens.dart';
import 'package:fe_ezlang_admin/core/resources/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class SignInScreen extends StatefulWidget {
  SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  bool _rememberMe = false;

  Widget _buildForgotPasswordBtn() {
    return Container(
      child: TextButton(
        onPressed: () => print('Forgot Password Button Pressed'),
        // padding: EdgeInsets.only(right: 0.0),
        child: Text(
          'Forgot Password?',
          style: Styles.kLabelStyle,
        ),
      ),
    );
  }

  Widget _buildRememberMeCheckbox() {
    return Container(
      child: Row(
        children: <Widget>[
          Theme(
            data: ThemeData(unselectedWidgetColor: Colors.white),
            child: Checkbox(
              value: _rememberMe,
              checkColor: Colors.green,
              activeColor: Colors.white,
              onChanged: (value) {
                setState(() {
                  _rememberMe = value!;
                });
              },
            ),
          ),
          Text(
            'Remember me',
            style: Styles.kLabelStyle,
          ),
        ],
      ),
    );
  }

  Widget _buildLoginBtn() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: RaisedButton(
          elevation: 5.0,
          onPressed: () => print('Login Button Pressed'),
          padding: EdgeInsets.all(15.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          color: Colors.white,
          child: CircularProgressIndicator()
          // Text(
          //   'LOGIN',
          //   style: TextStyle(
          //     color: Color(0xFF527DAA),
          //     letterSpacing: 1.5,
          //     fontSize: 18.0,
          //     fontWeight: FontWeight.bold,
          //     fontFamily: 'OpenSans',
          //   ),
          // ),
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        GradientContainer(),
        Center(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: Dimens.h_padding_form),
            child: Container(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Text(
                      "Sign In",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: Dimens.t_large_title,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                    TextfieldWithTitle(
                      title: 'Email',
                      hint: 'Enter Your Email',
                      leadingIcon: Icons.email,
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                    TextfieldWithTitle(
                      title: 'Password',
                      hint: 'Enter Your Password',
                      leadingIcon: Icons.lock,
                      obscureText: true,
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // _buildRememberMeCheckbox(),
                        SizedBox(),
                        _buildForgotPasswordBtn(),
                      ],
                    ),

                    _buildLoginBtn(),

                    SizedBox(height: 140)
                    // _buildSignInWithText(),
                    // _buildSocialBtnRow(),
                    // _buildSignupBtn(),
                  ],
                ),
              ),
            ),
          ),
        )
      ],
    ));
  }
}
