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
      () async {
        await Provider.of<UserListVM>(context, listen: false).getUsers();
      },
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<UserListVM>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Users"),
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.add))],
      ),
      body: vm.isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: vm.users?.length ?? 0,
              itemBuilder: (context, index) => ListTile(
                title: Text(vm.users![index].email!),
                subtitle: Text((vm.users![index].firstName ?? '') +
                    " " +
                    (vm.users![index].lastName ?? '')),
                onTap: () {},
              ),
            ),
    );
  }
}
