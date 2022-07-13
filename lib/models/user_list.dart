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
