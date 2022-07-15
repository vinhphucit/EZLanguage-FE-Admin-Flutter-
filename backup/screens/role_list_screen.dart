import '../../../view_models/admin/role/role_list_view_model.dart';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class RoleListScreen extends StatefulWidget {
  static final String routeName = 'rolelist';

  const RoleListScreen({Key? key}) : super(key: key);

  @override
  State<RoleListScreen> createState() => _RoleListScreenState();
}

class _RoleListScreenState extends RoleListVM {
  @override
  void initState() {
    super.initState();
    getRoles();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Roles"),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: roles?.length ?? 0,
              itemBuilder: (context, index) => ListTile(
                title: Text(roles![index].name!),
                subtitle: Text((roles![index].id ?? '')),
                onTap: () {},
              ),
            ),
    );
  }
}
