import 'dart:convert';

import '../../mvvm/models/user.dart';
import '../../mvvm/models/pageable_permissions.dart';
import '../../mvvm/models/pageable_roles.dart';
import '../../mvvm/models/pageable_users.dart';
import '../../mvvm/models/session.dart';
import 'base_api_service.dart';

class AdminApiService extends BaseApiService {
  final String baseUrl = 'https://ez-lang-alpha.herokuapp.com/ezlang/';
  final String signInEndpoint = 'auth/signIn';
  final String signOutEndpoint = 'auth/signOut';
  final String refreshTokenEndpoint = 'auth/refreshToken';
  final String signUpEndpoint = 'auth/signUp';
  final String usersEndpoint = 'users';
  final String rolesEndpoint = 'roles';
  final String permissionsEndpoint = 'permissions';

  Future<Session> signIn(String email, String password) async {
    return Session.fromJson(await post(
        '$baseUrl$signInEndpoint', {'email': email, 'password': password}));
  }

  Future<Session> refreshToken(String token) async {
    return Session.fromJson(
        await post('$baseUrl$refreshTokenEndpoint', {'token': token}));
  }

  Future<void> signOut(String token) async {
    await post('$baseUrl$signOutEndpoint', {'token': token});
  }

  Future<UserModel> signUp(
      email, String password, String firstName, String lastName) async {
    return UserModel.fromJson(await post('$baseUrl$signUpEndpoint', {
      'email': email,
      'password': password,
      'firstName': firstName,
      'lastName': lastName
    }));
  }

  Future<PageableUsersModel> getUsers() async {
    return PageableUsersModel.fromJson(await get('$baseUrl$usersEndpoint'));
  }

  Future<PagableRolesModel> getRoles() async {
    return PagableRolesModel.fromJson(await get('$baseUrl$rolesEndpoint'));
  }

  Future<PagablePermissionsModel> getPermissions() async {
    return PagablePermissionsModel.fromJson(
        await get('$baseUrl$permissionsEndpoint'));
  }
}
