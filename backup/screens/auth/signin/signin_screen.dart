import 'package:fe_ezlang_admin/mvvm/views/components/base_screen.dart';

import '../../../../view_models/auth/signin_view_model.dart';
import '../signup/signup_screen.dart';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

class SignInScreen extends StatefulWidget {
  static final String routeName = 'signin';
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends SignInVM with BaseScreen {
  final GlobalKey<FormState> _formKey = GlobalKey();
  String? email, password;
  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) {
      // Invalid!
      return;
    }

    _formKey.currentState?.save();
    try {
      signIn(email ?? '', password ?? '');
    } catch (e) {
      showErrorDialog(context, e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("SignIn"),
      ),
      body: Container(
        child: Card(
          child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Email'),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value?.isEmpty ??
                          false || !(value ?? '').contains('@')) {
                        return 'Invalid email!';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      email = value;
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Password'),
                    obscureText: true,
                    validator: (value) {
                      if (value?.isEmpty ?? false || (value?.length ?? 0) < 5) {
                        return 'Password is too short!';
                      }
                    },
                    onSaved: (value) {
                      password = value;
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  if (isLoading)
                    CircularProgressIndicator()
                  else
                    ElevatedButton(
                      onPressed: _submit,
                      child: Text("Login"),
                    ),
                  SizedBox(
                    height: 20,
                  ),
                  TextButton(
                      onPressed: () => Navigator.of(context)
                          .pushNamed(SignUpScreen.routeName),
                      child: Text("Create new account")),
                  TextButton(onPressed: () {}, child: Text("Forgot password")),
                ],
              )),
        ),
      ),
    );
  }
}
