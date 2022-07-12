import 'package:fe_ezlang_admin/view_models/auth_vm.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

class AuthScreen extends StatefulWidget {
  static final String routeName = 'login';
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  String? email, password;
  Future<void> _submit() async {
    _formKey.currentState?.save();
    try {
      await Provider.of<AuthVM>(context, listen: false)
          .signIn(email ?? '', password ?? '');
    } catch (e) {
      _showErrorDialog(e.toString());
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            title: Text("Error"),
            content: Text(message),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text("OK")),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500,
      width: 500,
      child: Card(
        child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(labelText: 'Email'),
                  onSaved: (value) {
                    email = value;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Password'),
                  obscureText: true,
                  onSaved: (value) {
                    password = value;
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                Consumer<AuthVM>(
                  builder: (context, authVM, child) {
                    if (authVM.isLoading) {
                      return CircularProgressIndicator();
                    } else {
                      return ElevatedButton(
                        onPressed: _submit,
                        child: Text("Login"),
                      );
                    }
                  },
                )
              ],
            )),
      ),
    );
  }
}
