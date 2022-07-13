import 'dart:async';
import 'dart:convert';

import '../../models/user.dart';
import '../../../repositories/remotes/exceptions/http_exception.dart';
import '../../../repositories/respository.dart';
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

  Future<UserModel> signUp(
      String email, String password, String firstName, String lastName) async {
    try {
      isLoading = true;
      return await Repository.getInstance()
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
