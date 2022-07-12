import 'dart:convert';

import 'package:fe_ezlang_admin/models/paging_list.dart';
import 'package:fe_ezlang_admin/models/session.dart';
import 'package:fe_ezlang_admin/models/user.dart';
import 'package:fe_ezlang_admin/models/user_list.dart';
import 'package:fe_ezlang_admin/repositories/admin_data_source.dart';
import 'package:fe_ezlang_admin/repositories/remotes/admin_api_service.dart';

class RemoteAdminRepo implements AdminDataSource {
  late AdminApiService _adminApiService;
  RemoteAdminRepo() {
    _adminApiService = AdminApiService();
  }

  @override
  Future<Session> signIn(String email, String password) async {
    var res = await _adminApiService.signIn(email, password);
    _updateTokenForServices(res.accessToken);
    return res;
  }

  @override
  Future<Session> refreshToken(String token) async {
    var res = await _adminApiService.refreshToken(token);
    _updateTokenForServices(res.accessToken);
    return res;
  }

  @override
  Future<void> signOut(String token) async {
    await _adminApiService.signOut(token);
    _updateTokenForServices(null);
  }

  @override
  Future<UserModel> signUp(
      String email, String password, String firstName, String lastName) async {
    return await _adminApiService.signUp(email, password, firstName, lastName);
  }

  void _updateTokenForServices(String? token) {
    _adminApiService.updateToken(token);
  }

  @override
  Future<UserListModel> getUsers() async {
    return await _adminApiService.getUsers();
  }
}
