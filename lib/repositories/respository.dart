import '../mvvm/models/pageable_permissions.dart';
import '../mvvm/models/pageable_roles.dart';
import '../mvvm/models/pageable_users.dart';
import '../mvvm/models/session.dart';
import '../mvvm/models/user.dart';
import 'admin_data_source.dart';
import 'remotes/remote_admin_repo.dart';

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
  Future<PageableUsersModel> getUsers() async {
    return await remoteAdminRepo.getUsers();
  }

  @override
  Future<PagableRolesModel> getRoles() async {
    return await remoteAdminRepo.getRoles();
  }

  @override
  Future<PagablePermissionsModel> getPermissions() async {
    return await remoteAdminRepo.getPermissions();
  }
}
