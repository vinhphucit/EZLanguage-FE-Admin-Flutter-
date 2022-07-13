// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'package:fe_ezlang_admin/mvvm/models/role.dart';

class PagableRolesModel {
  PagableRolesModel({
    this.items,
    this.start,
    this.limit,
    this.totalItems,
    this.query,
  });

  List<RoleModel>? items;
  int? start;
  int? limit;
  int? totalItems;
  String? query;

  factory PagableRolesModel.fromJson(Map<String, dynamic> json) =>
      PagableRolesModel(
        items: List<RoleModel>.from(
            json["items"].map((x) => RoleModel.fromJson(x))),
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
