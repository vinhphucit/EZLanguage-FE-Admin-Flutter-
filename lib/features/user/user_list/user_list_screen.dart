import 'package:fe_ezlang_admin/features/user/user_list/user_list_vm.dart';
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

class _UserListScreenState extends State<UserListScreen> {
  @override
  void initState() {
    Future.delayed(
      Duration.zero,
      () {
        Provider.of<UserListVM>(context, listen: false)
            .getUsers()
            .then((value) => print(value));
      },
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
