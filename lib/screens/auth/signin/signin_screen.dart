import 'package:fe_ezlang_admin/core/components/containers/gradient_container.dart';
import 'package:fe_ezlang_admin/core/components/textfields/textfield_with_title.dart';
import 'package:fe_ezlang_admin/core/resources/dimens.dart';
import 'package:fe_ezlang_admin/core/resources/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        GradientContainer(),
        Container(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(
                horizontal: Dimens.h_padding_form,
                vertical: Dimens.v_padding_form),
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
                )
              ],
            ),
          ),
        )
      ],
    ));
  }
}
