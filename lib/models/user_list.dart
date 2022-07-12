// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

import 'package:fe_ezlang_admin/models/role.dart';
import 'package:fe_ezlang_admin/models/user.dart';

class UserListModel {
  UserListModel({
    this.items,
    this.start,
    this.limit,
    this.totalItems,
    this.query,
  });

  List<UserModel>? items;
  int? start;
  int? limit;
  int? totalItems;
  String? query;

  factory UserListModel.fromJson(Map<String, dynamic> json) => UserListModel(
        items: List<UserModel>.from(
            json["items"].map((x) => UserModel.fromJson(x))),
        start: json["start"],
        limit: json["limit"],
        totalItems: json["totalItems"],
        query: json["query"],
      );

  Map<String, dynamic> toJson() => {
        "items": List<dynamic>.from(items!.map((x) => x.toJson())),
        "start": start,
        "limit": limit,
        "totalItems": totalItems,
        "query": query,
      };
}

// class Item {
//   Item({
//     this.id,
//     this.firstName,
//     this.lastName,
//     this.email,
//     this.status,
//     this.roles,
//     this.createdAt,
//     this.updatedAt,
//   });

//   String? id;
//   String? firstName;
//   String? lastName;
//   String? email;
//   String? status;
//   List<Role>? roles;
//   String? createdAt;
//   String? updatedAt;

//   factory Item.fromJson(Map<String, dynamic> json) => Item(
//         id: json["id"],
//         firstName: json["firstName"],
//         lastName: json["lastName"],
//         email: json["email"],
//         status: json["status"],
//         roles: List<Role>.from(json["roles"].map((x) => Role.fromJson(x))),
//         createdAt: json["createdAt"],
//         updatedAt: json["updatedAt"],
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "firstName": firstName,
//         "lastName": lastName,
//         "email": email,
//         "status": status,
//         "roles": List<dynamic>.from(roles!.map((x) => x.toJson())),
//         "createdAt": createdAt,
//         "updatedAt": updatedAt,
//       };
// }

// // class Role {
// //     Role({
// //         this.id,
// //         this.name,
// //         this.createdAt,
// //         this.updatedAt,
// //         this.permissions,
// //         this.code,
// //     });

// //     String id;
// //     String name;
// //     DateTime createdAt;
// //     DateTime updatedAt;
// //     List<Role> permissions;
// //     String code;

// //     factory Role.fromJson(Map<String, dynamic> json) => Role(
// //         id: json["id"],
// //         name: json["name"],
// //         createdAt: DateTime.parse(json["createdAt"]),
// //         updatedAt: DateTime.parse(json["updatedAt"]),
// //         permissions: json["permissions"] == null ? null : List<Role>.from(json["permissions"].map((x) => Role.fromJson(x))),
// //         code: json["code"] == null ? null : json["code"],
// //     );

// //     Map<String, dynamic> toJson() => {
// //         "id": id,
// //         "name": name,
// //         "createdAt": createdAt.toIso8601String(),
// //         "updatedAt": updatedAt.toIso8601String(),
// //         "permissions": permissions == null ? null : List<dynamic>.from(permissions.map((x) => x.toJson())),
// //         "code": code == null ? null : code,
// //     };
// // }
