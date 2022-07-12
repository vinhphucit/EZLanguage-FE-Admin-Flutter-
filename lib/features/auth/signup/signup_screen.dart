import 'package:fe_ezlang_admin/features/auth/signup/signup_vm.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatelessWidget {
  static final String routeName = 'signup';
  const SignUpScreen({Key? key}) : super(key: key);

  void _submit() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Create New Account")),
      body: Form(
          child: Column(
        children: [
          TextFormField(
            decoration: InputDecoration(labelText: 'Email'),
          ),
          TextFormField(
            decoration: InputDecoration(labelText: 'Password'),
            obscureText: true,
          ),
          TextFormField(
            decoration: InputDecoration(labelText: 'Repeat Password'),
            obscureText: true,
          ),
          TextFormField(
            decoration: InputDecoration(labelText: 'First Name'),
          ),
          TextFormField(
            decoration: InputDecoration(labelText: 'Last Name'),
          ),
          SizedBox(
            height: 20,
          ),
          Consumer<SignUpVM>(
            builder: (context, authVM, child) {
              if (authVM.isLoading) {
                return CircularProgressIndicator();
              } else {
                return ElevatedButton(
                  onPressed: _submit,
                  child: Text("SignUp"),
                );
              }
            },
          ),
        ],
      )),
    );
  }
}
