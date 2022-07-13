import '../../../models/role.dart';
import '../../../views/admin/role/role_list_screen.dart';
import '../../../../repositories/respository.dart';
import 'package:flutter/material.dart';

class RoleListVM extends State<RoleListScreen> {
  bool _isLoading = false;
  List<RoleModel> _roles = [];

  void set isLoading(bool isLoading) {
    _isLoading = isLoading;
    setState(() {});
  }

  bool get isLoading {
    return _isLoading;
  }

  List<RoleModel>? get roles {
    return _roles;
  }

  @override
  Widget build(BuildContext context) {
    throw UnimplementedError();
  }

  getRoles() async {
    try {
      isLoading = true;
      var roleList = await Repository.getInstance().getRoles();
      _roles = roleList.items ?? [];
    } catch (e) {
      throw e;
    } finally {
      isLoading = false;
    }
  }
}
