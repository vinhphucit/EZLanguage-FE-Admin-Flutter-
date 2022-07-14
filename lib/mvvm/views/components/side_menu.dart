import 'package:fe_ezlang_admin/mvvm/view_models/auth/signin_view_model.dart';
import 'package:fe_ezlang_admin/mvvm/views/admin/role/role_list_screen.dart';
import 'package:fe_ezlang_admin/mvvm/views/admin/user/user_list_screen.dart';
import 'package:fe_ezlang_admin/mvvm/views/components/drawer_list_tile.dart';
import 'package:fe_ezlang_admin/mvvm/views/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SideMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          DrawerHeader(child: Text("Title Drawer")),
          Divider(),
          DrawerListTile(
            icon: Icons.home,
            title: 'Home',
            press: () {
              Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
            },
          ),
          Divider(),
          DrawerListTile(
            icon: Icons.people,
            title: 'User',
            press: () {
              Navigator.of(context)
                  .pushReplacementNamed(UserListScreen.routeName);
            },
          ),
          Divider(),
          DrawerListTile(
            icon: Icons.exit_to_app,
            title: 'Logout',
            press: () {
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
