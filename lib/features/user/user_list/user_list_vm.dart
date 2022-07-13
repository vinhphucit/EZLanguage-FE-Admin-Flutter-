import 'dart:async';
import 'dart:convert';

import 'package:fe_ezlang_admin/models/paging_list.dart';
import 'package:fe_ezlang_admin/models/session.dart';
import 'package:fe_ezlang_admin/models/user.dart';
import 'package:fe_ezlang_admin/models/user_list.dart';
import 'package:fe_ezlang_admin/repositories/remotes/exceptions/http_exception.dart';
import 'package:fe_ezlang_admin/repositories/respository.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserListVM with ChangeNotifier {
  bool _isLoading = false;
  List<UserModel>? _users;
  bool get isLoading {
    return _isLoading;
  }

  void set isLoading(bool isLoading) {
    _isLoading = isLoading;
    notifyListeners();
  }

  List<UserModel>? get users {
    return _users;
  }

  getUsers() async {
    try {
      isLoading = true;
      var userList = await Repository.getInstance().getUsers();
      _users = userList.items;
    } catch (e) {
      throw e;
    } finally {
      isLoading = false;
    }
  }
}
