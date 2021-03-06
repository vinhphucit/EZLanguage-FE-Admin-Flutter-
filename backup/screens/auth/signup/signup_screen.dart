import 'package:fe_ezlang_admin/mvvm/views/components/base_screen.dart';

import '../../../../models/user.dart';
import '../../../../view_models/auth/signup_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatefulWidget {
  static final String routeName = 'signup';
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends SignUpVM with BaseScreen {
  static final String routeName = 'signup';
  final GlobalKey<FormState> _formKey = GlobalKey();

  String? email;
  String? password;
  String? lastName;
  String? firstName;

  final _passwordFieldController = TextEditingController();

  void _submit(BuildContext context) async {
    if (!_formKey.currentState!.validate()) {
      // Invalid!
      return;
    }

    _formKey.currentState?.save();
    try {
      UserModel u = await Provider.of<SignUpVM>(context, listen: false)
          .signUp(email ?? '', password ?? '', lastName ?? '', firstName ?? '');
      showDialog(
          context: context,
          builder: (ctx) {
            return AlertDialog(
              title: Text("Created successfully"),
              content: Text('You created user $u.email successfully'),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text("OK")),
              ],
            );
          });
    } catch (e) {
      showErrorDialog(context, e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SignUpVM(),
      child: Scaffold(
        appBar: AppBar(title: Text("Create New Account")),
        body: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(labelText: 'Email'),
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
                  controller: _passwordFieldController,
                  validator: (value) {
                    if (value?.isEmpty ?? false || (value?.length ?? 0) < 5) {
                      return 'Password is too short!';
                    }
                  },
                  onSaved: (value) {
                    password = value;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Repeat Password'),
                  obscureText: true,
                  validator: (value) {
                    if (value != _passwordFieldController.text) {
                      return 'Password do not match';
                    }
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'First Name'),
                  validator: (value) {
                    if (value?.isEmpty ?? false) {
                      return 'First Name must be not empty';
                    }
                  },
                  onSaved: (value) {
                    firstName = value;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Last Name'),
                  validator: (value) {
                    if (value?.isEmpty ?? false) {
                      return 'Last Name must be not empty';
                    }
                  },
                  onSaved: (value) {
                    lastName = value;
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                if (isLoading)
                  CircularProgressIndicator()
                else
                  ElevatedButton(
                    onPressed: () => _submit(context),
                    child: Text("SignUp"),
                  )
              ],
            )),
      ),
    );
  }
}
