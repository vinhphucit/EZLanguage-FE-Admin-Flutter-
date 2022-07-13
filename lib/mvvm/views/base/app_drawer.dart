import '../../view_models/auth/signin_view_model.dart';
import '../admin/role/role_list_screen.dart';
import '../admin/user/user_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
            title: Text('Menu'),
            automaticallyImplyLeading: false,
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Home'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed('/');
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('Users'),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(UserListScreen.routeName);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.accessible),
            title: Text('Roles'),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(RoleListScreen.routeName);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Logout'),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).pushReplacementNamed('/');

              Provider.of<SignInVM>(context, listen: false).signOut();
            },
          ),
        ],
      ),
    );
  }
}
