import 'package:fe_ezlang_admin/models/role.dart';

class UserModel {
  String? id;
  String? email;
  String? firstName;
  String? lastName;
  String? title;
  String? address;
  String? mobile;
  String? status;
  List<Role>? roles;
  String? createdAt;
  String? updatedAt;

  UserModel(
      {this.id,
      this.firstName,
      this.lastName,
      this.title,
      this.address,
      this.email,
      this.mobile,
      this.status,
      this.roles,
      this.createdAt,
      this.updatedAt});

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        email: json["email"],
        status: json["status"],
        roles: List<Role>.from(json["roles"].map((x) => Role.fromJson(x))),
        createdAt: json["createdAt"],
        updatedAt: json["updatedAt"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
        "status": status,
        "roles": roles == null
            ? null
            : List<dynamic>.from(roles!.map((x) => x.toJson())),
        "createdAt": createdAt,
        "updatedAt": updatedAt,
      };
}
