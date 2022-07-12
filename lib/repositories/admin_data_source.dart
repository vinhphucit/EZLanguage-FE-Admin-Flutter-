import 'package:fe_ezlang_admin/models/paging_list.dart';
import 'package:fe_ezlang_admin/models/session.dart';
import 'package:fe_ezlang_admin/models/user.dart';
import 'package:fe_ezlang_admin/models/user_list.dart';

abstract class AdminDataSource {
  Future<Session> signIn(String email, String password);
  Future<Session> refreshToken(String token);
  Future<void> signOut(String token);
  Future<UserModel> signUp(
      String email, String password, String firstName, String lastName);

  Future<UserListModel> getUsers();
}
