import 'package:fe_ezlang_admin/models/paging_list.dart';
import 'package:fe_ezlang_admin/models/session.dart';
import 'package:fe_ezlang_admin/models/user.dart';
import 'package:fe_ezlang_admin/models/user_list.dart';
import 'package:fe_ezlang_admin/repositories/admin_data_source.dart';
import 'package:fe_ezlang_admin/repositories/remotes/remote_admin_repo.dart';

class Repository implements AdminDataSource {
  static Repository? _instance;

  AdminDataSource remoteAdminRepo = RemoteAdminRepo();

  Repository() {}

  static Repository getInstance() {
    _instance ??= Repository();
    return _instance!;
  }

  @override
  Future<Session> signIn(String email, String password) async {
    return await remoteAdminRepo.signIn(email, password);
  }

  @override
  Future<Session> refreshToken(String token) async {
    return await remoteAdminRepo.refreshToken(token);
  }

  @override
  Future<void> signOut(String token) async {
    await remoteAdminRepo.signOut(token);
  }

  @override
  Future<UserModel> signUp(
      String email, String password, String firstName, String lastName) async {
    return await remoteAdminRepo.signUp(email, password, firstName, lastName);
  }

  @override
  Future<UserListModel> getUsers() async {
    return await remoteAdminRepo.getUsers();
  }
}
