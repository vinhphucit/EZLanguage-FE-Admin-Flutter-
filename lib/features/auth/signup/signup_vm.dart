import 'dart:async';
import 'dart:convert';

import 'package:fe_ezlang_admin/models/session.dart';
import 'package:fe_ezlang_admin/repositories/remotes/exceptions/http_exception.dart';
import 'package:fe_ezlang_admin/repositories/respository.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUpVM with ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading {
    return _isLoading;
  }

  void set isLoading(bool isLoading) {
    _isLoading = isLoading;
    notifyListeners();
  }

  Future<void> signUp(
      String email, String password, String firstName, String lastName) async {
    try {
      isLoading = true;
      await Repository.getInstance()
          .signUp(email, password, firstName, lastName);
    } on HttpException catch (e) {
      throw (e as HttpException).toString();
    } catch (e) {
      throw e;
    } finally {
      isLoading = false;
    }
  }
}
