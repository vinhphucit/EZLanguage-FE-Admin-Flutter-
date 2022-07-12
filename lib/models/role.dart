import 'package:fe_ezlang_admin/models/permission.dart';

class Role {
  String id;
  String name;
  List<Permission>? permissions;
  String? createdAt;
  String? updatedAt;
  Role(this.id, this.name, this.permissions, this.createdAt, this.updatedAt);
}
