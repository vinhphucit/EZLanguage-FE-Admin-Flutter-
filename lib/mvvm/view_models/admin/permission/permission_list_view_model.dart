import '../../../models/permission.dart';
import '../../../views/admin/permission/permission_list_screen.dart';
import '../../../../repositories/respository.dart';
import 'package:flutter/material.dart';

class PermissionListVM extends State<PermissionListScreen> {
  bool _isLoading = false;
  List<PermissionModel> _permissions = [];

  void set isLoading(bool isLoading) {
    _isLoading = isLoading;
    setState(() {});
  }

  bool get isLoading {
    return _isLoading;
  }

  List<PermissionModel>? get permissions {
    return _permissions;
  }

  @override
  Widget build(BuildContext context) {
    throw UnimplementedError();
  }

  getPermissions() async {
    try {
      isLoading = true;
      var permissionList = await Repository.getInstance().getPermissions();
      _permissions = permissionList.items ?? [];
    } catch (e) {
      throw e;
    } finally {
      isLoading = false;
    }
  }
}
