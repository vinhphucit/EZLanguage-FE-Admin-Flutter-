// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

import 'package:fe_ezlang_admin/mvvm/models/permission.dart';
import 'package:fe_ezlang_admin/mvvm/models/role.dart';

class PagablePermissionsModel {
  PagablePermissionsModel({
    this.items,
    this.start,
    this.limit,
    this.totalItems,
    this.query,
  });

  List<PermissionModel>? items;
  int? start;
  int? limit;
  int? totalItems;
  String? query;

  factory PagablePermissionsModel.fromJson(Map<String, dynamic> json) =>
      PagablePermissionsModel(
        items: List<PermissionModel>.from(
            json["items"].map((x) => PermissionModel.fromJson(x))),
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
