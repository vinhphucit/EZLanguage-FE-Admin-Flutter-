import 'dart:async';
import 'dart:convert';

import '../../../models/user.dart';
import '../../../views/admin/user/user_list_screen.dart';
import '../../../../repositories/respository.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserListVM extends State<UserListScreen> {
  bool _isLoading = false;
  List<UserModel> _users = [];
  bool get isLoading {
    return _isLoading;
  }

  void set isLoading(bool isLoading) {
    setState(() {
      _isLoading = isLoading;
    });
  }

  List<UserModel> get users {
    return _users;
  }

  getUsers() async {
    try {
      isLoading = true;
      var userList = await Repository.getInstance().getUsers();
      _users = userList.items ?? [];
    } catch (e) {
      throw e;
    } finally {
      isLoading = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}
