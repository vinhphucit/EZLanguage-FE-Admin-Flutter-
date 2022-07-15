import 'package:fe_ezlang_admin/providers/user_list_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

class UserListScreen extends StatefulWidget {
  static final String routeName = 'userlist';
  const UserListScreen({Key? key}) : super(key: key);

  @override
  State<UserListScreen> createState() => _UserListScreenState();
}

class _UserListScreenState extends UserListVM {
  @override
  void initState() {
    super.initState();
    Provider.of<UserListVM>(context, listen: false).getUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // We want this side menu only for large screen
          if (Responsive.isDesktop(context))
            Expanded(
              // default flex = 1
              // and it takes 1/6 part of the screen
              child: SideMenu(),
            ),
          Expanded(
              // It takes 5/6 part of the screen
              flex: 5,
              child: Consumer<UserListVM>(
                builder: (context, value, child) {
                  return (value.isLoading
                      ? Center(child: CircularProgressIndicator())
                      : (Responsive.isMobile(context)
                          ? MobileUserList()
                          : WebUserList()));
                },
              )),
        ],
      ),
    ));
  }
}
