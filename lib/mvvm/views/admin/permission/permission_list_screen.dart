import '../../../view_models/admin/permission/permission_list_view_model.dart';
import '../../base/app_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class PermissionListScreen extends StatefulWidget {
  const PermissionListScreen({Key? key}) : super(key: key);

  @override
  State<PermissionListScreen> createState() => _PermissionListScreenState();
}

class _PermissionListScreenState extends PermissionListVM {
  @override
  void initState() {
    super.initState();
    getPermissions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Permissions"),
      ),
      drawer: AppDrawer(),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: permissions?.length ?? 0,
              itemBuilder: (context, index) => ListTile(
                title: Text(permissions![index].name!),
                subtitle: Text((permissions![index].id ?? '')),
                onTap: () {},
              ),
            ),
    );
  }
}
