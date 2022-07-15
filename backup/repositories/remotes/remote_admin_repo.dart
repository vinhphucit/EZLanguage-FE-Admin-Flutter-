import 'dart:convert';

import '../../mvvm/models/user.dart';
import '../../mvvm/models/pageable_permissions.dart';
import '../../mvvm/models/pageable_roles.dart';
import '../../mvvm/models/pageable_users.dart';
import '../../mvvm/models/session.dart';
import '../admin_data_source.dart';
import 'admin_api_service.dart';

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
  Future<PageableUsersModel> getUsers() async {
    return await _adminApiService.getUsers();
  }

  @override
  Future<PagableRolesModel> getRoles() async {
    return await _adminApiService.getRoles();
  }

  @override
  Future<PagablePermissionsModel> getPermissions() async {
    return await _adminApiService.getPermissions();
  }
}
