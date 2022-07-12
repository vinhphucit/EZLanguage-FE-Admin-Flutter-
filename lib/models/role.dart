import 'package:fe_ezlang_admin/models/permission.dart';

class Role {
  String? id;
  String? name;
  List<Permission>? permissions;
  String? createdAt;
  String? updatedAt;
  Role({this.id, this.name, this.permissions, this.createdAt, this.updatedAt});

  factory Role.fromJson(Map<String, dynamic> json) => Role(
        id: json["id"],
        name: json["name"],
        createdAt: json["createdAt"],
        updatedAt: json["updatedAt"],
        permissions: json["permissions"] == null
            ? null
            : List<Permission>.from(
                json["permissions"].map((x) => Permission.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
        "permissions": permissions == null
            ? null
            : List<dynamic>.from(permissions!.map((x) => x.toJson())),
      };
}
