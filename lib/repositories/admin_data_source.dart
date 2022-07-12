import 'package:fe_ezlang_admin/models/session.dart';
import 'package:fe_ezlang_admin/models/user.dart';

abstract class AdminDataSource {
  Future<Session> signIn(String email, String password);
  Future<Session> refreshToken(String token);
  Future<void> signOut(String token);
  Future<User> signUp(
      String email, String password, String firstName, String lastName);
}
