import 'package:fe_ezlang_admin/models/role.dart';

class User {
  String id;
  String email;
  String? firstName;
  String? lastName;
  String? title;
  String? address;
  String? mobile;
  String? status;
  List<Role>? roles;
  String? createdAt;
  String? updatedAt;

  User(
      this.id,
      this.firstName,
      this.lastName,
      this.title,
      this.address,
      this.email,
      this.mobile,
      this.status,
      this.roles,
      this.createdAt,
      this.updatedAt);
}
