import '../../../view_models/admin/user/user_list_view_model.dart';
import '../../base/app_drawer.dart';
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
    getUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Users"),
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.add))],
      ),
      drawer: AppDrawer(),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: users?.length ?? 0,
              itemBuilder: (context, index) => ListTile(
                title: Text(users![index].email!),
                subtitle: Text((users![index].firstName ?? '') +
                    " " +
                    (users![index].lastName ?? '')),
                onTap: () {},
              ),
            ),
    );
  }
}
