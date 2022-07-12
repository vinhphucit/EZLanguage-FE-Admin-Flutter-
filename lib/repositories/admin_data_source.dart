import 'package:fe_ezlang_admin/models/session.dart';
import 'package:fe_ezlang_admin/repositories/data_source.dart';

abstract class AdminDataSource {
  Future<Session> signIn(String email, String password);
  Future<Session> refreshToken(String token);
  Future<void> signOut(String token);
}
